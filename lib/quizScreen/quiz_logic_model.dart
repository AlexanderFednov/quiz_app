import 'package:equatable/equatable.dart';

enum AnswerStatus { right, wrong }

enum QuizStatus { notStarted, inProgress, reset, completed, error }

class QuizLogicModel extends Equatable {
  final int totalScore;
  final int questionIndex;
  final int categoryNumber;
  final int savedScore;
  final int savedQuestionLenght;
  final QuizStatus quizStatus;
  final List<AnswerStatus>? answerStatusList;

  QuizLogicModel({
    this.totalScore = 0,
    this.questionIndex = 0,
    this.categoryNumber = 0,
    this.savedScore = 0,
    this.savedQuestionLenght = 0,
    this.quizStatus = QuizStatus.notStarted,
    this.answerStatusList,
  });

  QuizLogicModel copyWith({
    int? totalScore,
    int? questionIndex,
    int? categoryNumber,
    int? savedScore,
    int? savedQuestionLenght,
    QuizStatus? quizStatus,
    List<AnswerStatus>? answerStatusList,
  }) {
    return QuizLogicModel(
      totalScore: totalScore ?? this.totalScore,
      questionIndex: questionIndex ?? this.questionIndex,
      categoryNumber: categoryNumber ?? this.categoryNumber,
      savedScore: savedScore ?? this.savedScore,
      savedQuestionLenght: savedQuestionLenght ?? this.savedQuestionLenght,
      quizStatus: quizStatus ?? this.quizStatus,
      answerStatusList: answerStatusList ?? this.answerStatusList,
    );
  }

  @override
  List<Object?> get props => [
        totalScore,
        questionIndex,
        categoryNumber,
        savedScore,
        savedQuestionLenght,
        quizStatus,
        answerStatusList,
      ];
}
