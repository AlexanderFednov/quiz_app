import 'package:json_annotation/json_annotation.dart';

//import 'package:flutter/material.dart';
part 'question_list.g.dart';

@JsonSerializable()
class QuestionList {
  List<QuestionInside> question;
  QuestionList(this.question);

  factory QuestionList.fromJson(Map<String, dynamic> json) =>
      _$QuestionListFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionListToJson(this);
}

@JsonSerializable()
class QuestionInside {
  String questionText;
  List<Answers> answers;
  QuestionInside(this.questionText, this.answers);

  factory QuestionInside.fromJson(Map<String, dynamic> json) =>
      _$QuestionInsideFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionInsideToJson(this);
}

@JsonSerializable()
class Answers {
  String text;
  bool result;
  String code;

  Answers(this.text, this.result, this.code);

  factory Answers.fromJson(Map<String, dynamic> json) =>
      _$AnswersFromJson(json);

  Map<String, dynamic> toJson() => _$AnswersToJson(this);
}
