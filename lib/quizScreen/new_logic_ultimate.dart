import 'package:hive/hive.dart';
import 'package:quiz_app/quizScreen/logic_model.dart';
import 'package:quiz_app/models/hive_user_data.dart';
import 'package:quiz_app/models/moor_database.dart';
import 'package:quiz_app/models/question_list.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_dispose/easy_dispose.dart';

class NewLogicUltimate extends DisposableOwner {
  static final LogicModel logicModel = LogicModel(answerStatusList: []);

  List<QuestionInside> questions;

  MyDatabase moorDatabase;

  final BehaviorSubject<LogicModel> _logicSubject =
      BehaviorSubject.seeded(logicModel);

  LogicModel get logic => _logicSubject.value;

  Stream<LogicModel> get logicStream => _logicSubject.stream;

  Stream<int> get logicQuestionIndexStream =>
      logicStream.map((logicModel) => logicModel.questionIndex);

  int get questionIndex => logic.questionIndex;

  Stream<List<AnswerStatus>> get answerStatusListStream =>
      logicStream.map((logicModel) => logicModel.answerStatusList);

  List<AnswerStatus> get answerStatusList => logic.answerStatusList;

  void answerQuestion(bool result) {
    if (result) {
      rightAnswer();
    } else {
      wrongAnswer();
    }
  }

  void rightAnswer() {
    var anwerStatusListTemporary = answerStatusList;
    anwerStatusListTemporary.add(AnswerStatus.right);

    _logicSubject.add(logic.copyWith(
        questionIndex: logic.questionIndex + 1,
        totalScore: logic.totalScore + 1,
        answerStatusList: anwerStatusListTemporary));
  }

  void wrongAnswer() {
    var anwerStatusListTemporary = answerStatusList;
    anwerStatusListTemporary.add(AnswerStatus.wrong);

    _logicSubject.add(logic.copyWith(
        questionIndex: logic.questionIndex + 1,
        answerStatusList: anwerStatusListTemporary));
  }

  void resetQuiz() async {
    var prefs = await SharedPreferences.getInstance();
    var currentUser = getCurrentUser();

    if (logic.questionIndex > 0) {
      if (currentUser != null) {
        _addHiveUserResult();
        _addMoorUserResult(currentUser);
      }
      await prefs.setInt('questionsLenght', logic.questionIndex);
      await prefs.setInt('saveScore', logic.totalScore);
      _logicSubject.add(logic.copyWith(savedScore: logic.totalScore));
      _logicSubject
          .add(logic.copyWith(savedQuestionLenght: logic.savedQuestionLenght));
    }
    nullifyLogic();
  }

  void nullifyLogic() {
    _logicSubject.add(logic.copyWith(
        totalScore: 0,
        questionIndex: 0,
        categoryNumber: 0,
        answerStatusList: []));
  }

  void _addHiveUserResult() {
    var contactBox = Hive.box<UserData>('UserData1');

    contactBox.values.forEach((element) {
      if (element.isCurrentUser) {
        element.userResult = logic.totalScore;
        element.userResults.insert(
          0,
          UserResult(
            score: logic.totalScore,
            questionsLenght: logic.questionIndex,
            resultDate: DateTime.now(),
            categoryNumber: logic.categoryNumber,
          ),
        );
        element.save();
      }
    });
  }

  void _addMoorUserResult(UserData currentUser) {
    moorDatabase.insertMoorResult(
      MoorResult(
        id: null,
        name: currentUser.userName,
        result: _logicSubject.value.totalScore,
        questionsLenght: _logicSubject.value.questionIndex,
        rightResultsPercent: (100 /
            _logicSubject.value.questionIndex *
            _logicSubject.value.totalScore),
        categoryNumber: logic.categoryNumber,
        resultDate: DateTime.now(),
      ),
    );
  }

  void setCategorynumber(int num) {
    _logicSubject.add(_logicSubject.value.copyWith(categoryNumber: num));
  }

  UserData getCurrentUser() {
    UserData currentUser;

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

  void loadSavedScore() async {
    var prefs = await SharedPreferences.getInstance();

    _logicSubject
        .add(logic.copyWith(savedScore: prefs.getInt('saveScore') ?? 0));
    _logicSubject.add(logic.copyWith(
        savedQuestionLenght: prefs.getInt('questionsLenght') ?? 0));
  }

  NewLogicUltimate({this.moorDatabase}) {
    loadSavedScore();

    _logicSubject.disposeWith(this);
  }
}
