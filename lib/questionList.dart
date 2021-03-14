import 'package:json_annotation/json_annotation.dart';
//import 'package:flutter/material.dart';

@JsonSerializable()
class QuestionList {
  List<QuestionInside> question;
  QuestionList(this.question);
}

class QuestionInside {
  String questionText;
  List<Answers> answers;
  QuestionInside(this.questionText, this.answers);
}

class Answers {
  String text;
  bool result;
  String code;

  Answers(this.text, this.result, this.code);
}
