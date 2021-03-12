import 'package:json_annotation/json_annotation.dart';
//import 'package:flutter/material.dart';

@JsonSerializable()
class QuestionList {
  List<QuestionInside> question;
}

class QuestionInside {
  String questionText;
  List<Map<String, Object>> answers;
}
