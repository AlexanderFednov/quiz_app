import 'dart:async';

import 'package:drift/drift.dart';
import 'package:hive/hive.dart';
// import 'package:moor_flutter/moor_flutter.dart';
import 'package:quiz_app/leaderboard/leaderboard_bloc.dart';
import 'package:quiz_app/questions/models/question_list.dart';
import 'package:quiz_app/questions/questions_bloc.dart';
import 'package:quiz_app/quiz_screen/quiz_logic_model.dart';
import 'package:quiz_app/registration/models/hive_user_data.dart';
import 'package:quiz_app/leaderboard/models/moor_database.dart';
// import 'package:quiz_app/models/question_list.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_dispose/easy_dispose.dart';

class QuizLogicBloc extends DisposableOwner {
  QuizLogicBloc({
    required this.moorDatabase,
    required this.leaderboardBloc,
    required this.questionsBloc,
  }) {
    _loadSavedScore();

    quizStatusStream.listen((quizStatus) {
      _onQuizStatusChange(quizStatus);
    }).disposeWith(this);

    _logicStateSubject.disposeWith(this);
  }

  final MyDatabase moorDatabase;
  final LeaderboardBloc leaderboardBloc;
  final QuestionsBloc questionsBloc;

  static final QuizLogicModel _quizLogicModel =
      QuizLogicModel(answerStatusList: []);

  final BehaviorSubject<QuizLogicModel> _logicStateSubject =
      BehaviorSubject.seeded(_quizLogicModel);

  QuizLogicModel get logicState => _logicStateSubject.value;

  Stream<QuizLogicModel> get logicStateStream => _logicStateSubject.stream;

  Stream<List<AnswerStatus>?> get answerStatusListStream =>
      logicStateStream.map((logicModel) => logicModel.answerStatusList);

  Stream<int> get questionIndexStream =>
      logicStateStream.map((logicModel) => logicModel.questionIndex);

  Stream<QuizStatus> get quizStatusStream =>
      logicStateStream.map((logicModel) => logicModel.quizStatus).distinct();

  Stream<List<Question>> get questionsStream =>
      logicStateStream.map((logicModel) => logicModel.questions);

  Stream<Question?> get currentQuestionStream =>
      logicStateStream.map((logicModel) => logicModel.currentQuestion);

  Stream<int> get totalScoreStream =>
      logicStateStream.map((logicModel) => logicModel.totalScore);

  Stream<int> get savedScoreStream =>
      logicStateStream.map((logicModel) => logicModel.savedScore);

  Stream<int> get savedQuestionsLenghtStream =>
      logicStateStream.map((logicModel) => logicModel.savedQuestionLenght);

  List<AnswerStatus>? get answerStatusList => logicState.answerStatusList;

  int get currentQuestionIndex => logicState.questionIndex;

  Question? get currentQuestion => logicState.currentQuestion;

  Stream<int> get questionsLenghtStream =>
      logicStateStream.map((logicModel) => logicModel.questions.length);

  void answerQuestion(Answer answer) {
    var anwerStatusListTemporary = answerStatusList!;
    anwerStatusListTemporary
        .add(answer.result! ? AnswerStatus.right : AnswerStatus.wrong);

    _logicStateSubject.add(
      logicState.copyWith(
        questionIndex: logicState.questionIndex + 1,
        totalScore:
            answer.result! ? logicState.totalScore + 1 : logicState.totalScore,
        answerStatusList: anwerStatusListTemporary,
      ),
    );

    if (logicState.questionIndex < logicState.questions.length) {
      _logicStateSubject.add(
        logicState.copyWith(
          currentQuestion: logicState.questions[logicState.questionIndex],
        ),
      );
    } else {
      _logicStateSubject.add(
        logicState.copyWith(
          quizStatus: QuizStatus.completed,
        ),
      );
    }
  }

  void _onQuizStatusChange(QuizStatus quizStatus) {
    if (quizStatus == QuizStatus.reset) {
      _resetQuizState();
    } else if (quizStatus == QuizStatus.error) {
      questionsBloc.loadData();
    } else if (quizStatus == QuizStatus.completed) {
      _quizCompleted();
    }
  }

  Future<void> _quizCompleted() async {
    var prefs = await SharedPreferences.getInstance();
    var currentUser = getCurrentUser();

    await prefs.setInt('questionsLenght', logicState.questionIndex);
    await prefs.setInt('saveScore', logicState.totalScore);

    if (logicState.questionIndex > 0) {
      if (currentUser != null) {
        _addHiveUserResult();
        _addMoorUserResult(currentUser);
        await leaderboardBloc.getMoorResults();
      }

      _logicStateSubject.add(
        logicState.copyWith(
          savedScore: logicState.totalScore,
          savedQuestionLenght: logicState.questionIndex,
        ),
      );
    }
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

  void _resetQuizState() {
    _logicStateSubject.add(
      logicState.copyWith(
        totalScore: 0,
        questionIndex: 0,
        category: null,
        quizStatus: QuizStatus.notStarted,
        answerStatusList: [],
        questions: [],
        currentQuestion: null,
      ),
    );
  }

  void _addHiveUserResult() {
    var contactBox = Hive.box<UserData>('UserData1');

    contactBox.values.forEach((element) {
      if (element.isCurrentUser) {
        element.userResult = logicState.totalScore;
        element.userResults!.insert(
          0,
          UserResult(
            score: logicState.totalScore,
            questionsLenght: logicState.questionIndex,
            resultDate: DateTime.now(),
            category: logicState.category,
          ),
        );
        element.save();
      }
    });
  }

  void _addMoorUserResult(UserData currentUser) {
    moorDatabase.insertMoorResultCompanion(
      MoorResultsCompanion(
        name: Value(currentUser.userName),
        result: Value(logicState.totalScore),
        questionsLenght: Value(logicState.questionIndex),
        rightResultsPercent:
            Value(100 / logicState.questionIndex * logicState.totalScore),
        category: Value(logicState.category!),
        resultDate: Value(DateTime.now()),
      ),
    );
  }

  void setCategoryNumber(Category category) {
    _logicStateSubject.add(
      logicState.copyWith(
        category: category,
        quizStatus: QuizStatus.inProgress,
      ),
    );

    _logicStateSubject.add(
      logicState.copyWith(
        questions: _calculateCategoryQuestionsList(category),
      ),
    );

    if (logicState.questions.isNotEmpty) {
      _logicStateSubject.add(
        logicState.copyWith(
          currentQuestion: logicState.questions[logicState.questionIndex],
        ),
      );
    } else {
      _logicStateSubject.add(
        logicState.copyWith(
          quizStatus: QuizStatus.error,
        ),
      );
    }
  }

  List<Question>? _calculateCategoryQuestionsList(Category category) {
    switch (category) {
      case Category.generalQuestions:
        return questionsBloc.questionsState.questionsGeneral;
      case Category.moviesOfUSSSR:
        return questionsBloc.questionsState.questionsMovies;
      case Category.space:
        return questionsBloc.questionsState.questionsSpace;
      case Category.sector13:
        return questionsBloc.questionsState.questionsWeb;
      default:
        return null;
    }
  }

  UserData? getCurrentUser() {
    UserData? currentUser;

    var contactsBox = Hive.box<UserData>('UserData1');
    if (contactsBox.isNotEmpty) {
      contactsBox.values.forEach((element) {
        if (element.isCurrentUser) {
          currentUser = element;
        }
      });
    } else {
      currentUser = null;
    }

    return currentUser;
  }

  Future<void> _loadSavedScore() async {
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
