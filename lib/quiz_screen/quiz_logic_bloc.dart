import 'dart:async';

import 'package:hive/hive.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:quiz_app/leaderboard/leaderboard_bloc.dart';
import 'package:quiz_app/quiz_screen/quiz_logic_model.dart';
import 'package:quiz_app/models/hive_user_data.dart';
import 'package:quiz_app/models/moor_database.dart';
import 'package:quiz_app/models/question_list.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_dispose/easy_dispose.dart';

// enum MainPageViewEvent { quizReset, quizComplete, serverError }

class QuizLogicBloc extends DisposableOwner {
  QuizLogicBloc({required this.moorDatabase, required this.leaderboardBloc}) {
    _loadSavedScore();

    quizStatusStream.listen((quizStatus) {
      _onQuizStatusChange(quizStatus);
    }).disposeWith(this);
  }

  static final QuizLogicModel _quizLogicModel =
      QuizLogicModel(answerStatusList: []);

  final MyDatabase moorDatabase;

  final LeaderboardBloc leaderboardBloc;

  final BehaviorSubject<QuizLogicModel> _logicStateSubject =
      BehaviorSubject.seeded(_quizLogicModel);

  // List<QuestionInside>? questions;

  QuizLogicModel get logicState => _logicStateSubject.value;

  Stream<QuizLogicModel> get logicStream => _logicStateSubject.stream;

  Stream<int> get questionIndexStream =>
      logicStream.map((logicModel) => logicModel.questionIndex);

  int get currentQuestionIndex => logicState.questionIndex;

  Stream<List<AnswerStatus>?> get answerStatusListStream =>
      logicStream.map((logicModel) => logicModel.answerStatusList);

  List<AnswerStatus>? get answerStatusList => logicState.answerStatusList;

  Stream<QuizStatus> get quizStatusStream =>
      logicStream.map((logicModel) => logicModel.quizStatus).distinct();

  void answerQuestion(bool result) {
    if (result) {
      _rightAnswer();
    } else {
      _wrongAnswer();
    }
  }

  void _rightAnswer() {
    var anwerStatusListTemporary = answerStatusList!;
    anwerStatusListTemporary.add(AnswerStatus.right);

    _logicStateSubject.add(
      logicState.copyWith(
        questionIndex: logicState.questionIndex + 1,
        totalScore: logicState.totalScore + 1,
        answerStatusList: anwerStatusListTemporary,
      ),
    );
  }

  void _wrongAnswer() {
    var anwerStatusListTemporary = answerStatusList!;
    anwerStatusListTemporary.add(AnswerStatus.wrong);

    _logicStateSubject.add(
      logicState.copyWith(
        questionIndex: logicState.questionIndex + 1,
        answerStatusList: anwerStatusListTemporary,
      ),
    );
  }

  void _onQuizStatusChange(QuizStatus quizStatus) {
    if (quizStatus == QuizStatus.reset || quizStatus == QuizStatus.error) {
      _nullifyLogic();
    } else if (quizStatus == QuizStatus.completed) {
      _quizCompleted();
    }
  }

  void _quizCompleted() async {
    var prefs = await SharedPreferences.getInstance();
    var currentUser = getCurrentUser();

    await prefs.setInt('questionsLenght', logicState.questionIndex);
    await prefs.setInt('saveScore', logicState.totalScore);

    if (logicState.questionIndex > 0) {
      if (currentUser != null) {
        _addHiveUserResult();
        _addMoorUserResult(currentUser);
        leaderboardBloc.getMoorResults();
      }

      _logicStateSubject.add(
        logicState.copyWith(
          savedScore: logicState.totalScore,
          savedQuestionLenght: logicState.questionIndex,
        ),
      );
    }
    _nullifyLogic();
  }

  void reset() {
    _logicStateSubject.add(
      logicState.copyWith(quizStatus: QuizStatus.reset),
    );
  }

  void completed() {
    _logicStateSubject.add(
      logicState.copyWith(quizStatus: QuizStatus.completed),
    );
  }

  void error() {
    _logicStateSubject.add(
      logicState.copyWith(quizStatus: QuizStatus.error),
    );
  }

  void _nullifyLogic() {
    _logicStateSubject.add(
      logicState.copyWith(
        totalScore: 0,
        questionIndex: 0,
        categoryNumber: 0,
        quizStatus: QuizStatus.notStarted,
        answerStatusList: [],
      ),
    );
  }

  void _addHiveUserResult() {
    var contactBox = Hive.box<UserData>('UserData1');

    contactBox.values.forEach((element) {
      if (element.isCurrentUser!) {
        element.userResult = logicState.totalScore;
        element.userResults!.insert(
          0,
          UserResult(
            score: logicState.totalScore,
            questionsLenght: logicState.questionIndex,
            resultDate: DateTime.now(),
            categoryNumber: logicState.categoryNumber,
          ),
        );
        element.save();
      }
    });
  }

  void _addMoorUserResult(UserData currentUser) {
    moorDatabase.insertMoorResultCompanion(
      MoorResultsCompanion(
        name: Value(currentUser.userName!),
        result: Value(_logicStateSubject.value.totalScore),
        questionsLenght: Value(_logicStateSubject.value.questionIndex),
        rightResultsPercent: Value(100 /
            _logicStateSubject.value.questionIndex *
            _logicStateSubject.value.totalScore),
        categoryNumber: Value(logicState.categoryNumber),
        resultDate: Value(DateTime.now()),
      ),
    );
  }

  void setCategoryNumber(int num) {
    _logicStateSubject.add(
      _logicStateSubject.value
          .copyWith(categoryNumber: num, quizStatus: QuizStatus.inProgress),
    );
  }

  UserData? getCurrentUser() {
    UserData? currentUser;

    var contactsBox = Hive.box<UserData>('UserData1');
    if (contactsBox.isNotEmpty) {
      contactsBox.values.forEach((element) {
        if (element.isCurrentUser!) {
          currentUser = element;
        }
      });
    } else {
      currentUser = null;
    }

    return currentUser;
  }

  void _loadSavedScore() async {
    var prefs = await SharedPreferences.getInstance();

    _logicStateSubject
        .add(logicState.copyWith(savedScore: prefs.getInt('saveScore') ?? 0));
    _logicStateSubject.add(
      logicState.copyWith(
        savedQuestionLenght: prefs.getInt('questionsLenght') ?? 0,
      ),
    );
  }
}
