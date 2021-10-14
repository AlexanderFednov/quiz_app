import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'package:quiz_app/models/question_list.dart';

class LoadQuestionsData with ChangeNotifier {
  List<QuestionInside>? questionAll = [];
  List<QuestionInside>? questionFilms = [];
  List<QuestionInside>? questionSpace = [];
  List<QuestionInside>? questionWeb = [];

  Future loadList() async {
    var jsonQuestionAll =
        await rootBundle.loadString('assets/questions/questionsAll.json');
    Map<String, dynamic> decoded = jsonDecode(jsonQuestionAll);

    var questionListAll = QuestionList.fromJson(decoded).question;

    var jsonQuestionFilms =
        await rootBundle.loadString('assets/questions/questionsFilms.json');
    Map<String, dynamic> decoded2 = jsonDecode(jsonQuestionFilms);

    var questionListFilms = QuestionList.fromJson(decoded2).question;

    var jsonQuestionSpace =
        await rootBundle.loadString('assets/questions/questionsSpace.json');
    Map<String, dynamic> decoded3 = jsonDecode(jsonQuestionSpace);

    var questionListSpace = QuestionList.fromJson(decoded3).question;

    questionAll = questionListAll;
    questionFilms = questionListFilms;
    questionSpace = questionListSpace;
  }

  void loadData() async {
    final responce = await http.get(Uri.http('10.0.2.2:8000', '')).timeout(
          Duration(seconds: 3),
          onTimeout: (() => Response('Server Error', 404)),
        );

    if (responce.statusCode == 200) {
      Map decoded = jsonDecode(responce.body);
      var questionListWeb =
          QuestionList.fromJson(decoded as Map<String, dynamic>).question;
      print('Server is available');

      questionWeb = questionListWeb;
    }
    //responceText = decoded;
    else {
      print('HTTP error: server is not available');
      // String jsonQuestionNull =
      //     await rootBundle.loadString('assets/questions/questionsNull.json');
      // Map decoded = jsonDecode(jsonQuestionNull);

      // var questionListNull = QuestionList.fromJson(decoded).question;

      // setState(() {
      //   questionWeb = questionListNull;
      // });
    }

    return Future.value();
  }

  Future loadQuestions() async {
    loadData();
    await loadList();

    return Future.value();
  }
}
