import 'package:json_annotation/json_annotation.dart';
//import 'package:flutter/material.dart';

@JsonSerializable()
class QuestionList {
  List<QuestionInside> question;
}

class QuestionInside {
  String questionText;
  List<Answers> answers;
}

class Answers {
  String questionText;
  bool result;
  String code;

  Answers(this.questionText, this.result, this.code);
}
