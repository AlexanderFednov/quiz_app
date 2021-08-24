import 'package:equatable/equatable.dart';

enum AnswerStatus { right, wrong }

class LogicModel extends Equatable {
  final int totalScore;
  final int questionIndex;
  final int categoryNumber;
  final int savedScore;
  final int savedQuestionLenght;
  final List<AnswerStatus> answerStatusList;

  LogicModel(
      {this.totalScore = 0,
      this.questionIndex = 0,
      this.categoryNumber = 0,
      this.savedScore = 0,
      this.savedQuestionLenght = 0,
      this.answerStatusList});

  LogicModel copyWith(
      {int totalScore,
      int questionIndex,
      int categoryNumber,
      int savedScore,
      int savedQuestionLenght,
      List<AnswerStatus> answerStatusList}) {
    return LogicModel(
        totalScore: totalScore ?? this.totalScore,
        questionIndex: questionIndex ?? this.questionIndex,
        categoryNumber: categoryNumber ?? this.categoryNumber,
        savedScore: savedScore ?? this.savedScore,
        savedQuestionLenght: savedQuestionLenght ?? this.savedQuestionLenght,
        answerStatusList: answerStatusList ?? this.answerStatusList);
  }

  @override
  List<Object> get props => [
        totalScore,
        questionIndex,
        categoryNumber,
        savedScore,
        savedQuestionLenght,
        answerStatusList
      ];
}
