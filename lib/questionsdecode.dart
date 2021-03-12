//import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class QuestionJson {
  List<Map<String, Object>> parsedJsonQuestion;

  QuestionJson({this.parsedJsonQuestion});
}

Future<String> _loadQuestionsAsset(String jsonFile) async {
  return await rootBundle.loadString(jsonFile);
}

Future loadQuestion() async {
  String jsonQuestion =
      await _loadQuestionsAsset('assets/questions/questionsAll.json');

  QuestionJson quest = _parseJsonForQuestion(jsonQuestion);
  print(quest.parsedJsonQuestion[0]['answers']);
}

QuestionJson _parseJsonForQuestion(String jsonQuestion) {
  List decoded = jsonDecode(jsonQuestion);

  List<Map<String, Object>> listMap = [];

  for (Map<String, Object> i in decoded) {
    listMap.add(i);
  }

  //print(listMap);
  return QuestionJson(parsedJsonQuestion: listMap);
}

loadList() async {
  String jsonQuestion =
      await rootBundle.loadString('assets/questions/questionsAll.json');
  List decoded = jsonDecode(jsonQuestion);
  List<Map<String, Object>> listFun = [];

  for (Map<String, Object> i in decoded) {
    listFun.add(i);
  }
  print(listFun);
}
