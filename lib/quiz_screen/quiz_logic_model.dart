import 'package:equatable/equatable.dart';
import 'package:quiz_app/registration/models/hive_user_data.dart';
import 'package:quiz_app/questions/models/question_list.dart';

enum AnswerStatus { right, wrong }

enum QuizStatus { notStarted, inProgress, reset, completed, error }

class QuizLogicModel extends Equatable {
  final int totalScore;
  final int questionIndex;
  final int savedScore;
  final int savedQuestionLenght;
  final Category? category;
  final QuizStatus quizStatus;
  final Question? currentQuestion;
  final List<AnswerStatus>? answerStatusList;
  final List<Question> questions;

  QuizLogicModel({
    this.totalScore = 0,
    this.questionIndex = 0,
    this.savedScore = 0,
    this.savedQuestionLenght = 0,
    this.category,
    this.quizStatus = QuizStatus.notStarted,
    this.currentQuestion,
    this.answerStatusList,
    this.questions = const [],
  });

  QuizLogicModel copyWith({
    int? totalScore,
    int? questionIndex,
    int? savedScore,
    int? savedQuestionLenght,
    Category? category,
    QuizStatus? quizStatus,
    Question? currentQuestion,
    List<AnswerStatus>? answerStatusList,
    List<Question>? questions,
  }) {
    return QuizLogicModel(
      totalScore: totalScore ?? this.totalScore,
      questionIndex: questionIndex ?? this.questionIndex,
      savedScore: savedScore ?? this.savedScore,
      savedQuestionLenght: savedQuestionLenght ?? this.savedQuestionLenght,
      category: category ?? this.category,
      quizStatus: quizStatus ?? this.quizStatus,
      currentQuestion: currentQuestion ?? this.currentQuestion,
      answerStatusList: answerStatusList ?? this.answerStatusList,
      questions: questions ?? this.questions,
    );
  }

  @override
  List<Object?> get props => [
        totalScore,
        questionIndex,
        savedScore,
        savedQuestionLenght,
        category,
        quizStatus,
        currentQuestion,
        answerStatusList,
        questions,
      ];
}
