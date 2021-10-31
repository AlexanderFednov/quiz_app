import 'package:json_annotation/json_annotation.dart';

//import 'package:flutter/material.dart';
part 'question_list.g.dart';

@JsonSerializable()
class QuestionList {
  List<Question>? question;
  QuestionList(this.question);

  factory QuestionList.fromJson(Map<String, dynamic> json) =>
      _$QuestionListFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionListToJson(this);
}

@JsonSerializable()
class Question {
  String? questionText;
  List<Answer>? answers;
  Question(this.questionText, this.answers);

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}

@JsonSerializable()
class Answer {
  String? text;
  bool? result;
  String? code;

  Answer(this.text, this.result, this.code);

  factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerToJson(this);
}
