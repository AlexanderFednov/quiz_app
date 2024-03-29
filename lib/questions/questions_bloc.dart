import 'dart:convert';

import 'package:easy_dispose/easy_dispose.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:quiz_app/questions/models/question_list.dart';
import 'package:quiz_app/questions/questions_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

class QuestionsBloc extends DisposableOwner {
  QuestionsBloc() {
    _questionsInit();

    _questionsStateSubject.disposeWith(this);
  }

  static final QuestionsModel _questionsModel = QuestionsModel();

  final BehaviorSubject<QuestionsModel> _questionsStateSubject =
      BehaviorSubject.seeded(_questionsModel);

  Stream<QuestionsModel> get questionsStream => _questionsStateSubject.stream;

  QuestionsModel get questionsState => _questionsStateSubject.value;

  Future<void> _questionsInit() async {
    var questionsGeneral = await _loadQuestionsFromAssets(
      questionsUrl: 'assets/questions/questionsAll.json',
    );

    var questionsMovies = await _loadQuestionsFromAssets(
      questionsUrl: 'assets/questions/questionsFilms.json',
    );

    var questionsSpace = await _loadQuestionsFromAssets(
      questionsUrl: 'assets/questions/questionsSpace.json',
    );

    _questionsStateSubject.add(
      questionsState.copyWith(
        questionsGeneral: questionsGeneral,
        questionsMovies: questionsMovies,
        questionsSpace: questionsSpace,
      ),
    );

    await loadData();
  }

  Future<void> loadData() async {
    var questionsWeb = await _getQuestionsFromServer();

    _questionsStateSubject.add(
      questionsState.copyWith(questionsWeb: questionsWeb),
    );
  }

  Future<List<Question>> _loadQuestionsFromAssets({
    required String questionsUrl,
  }) async {
    var jsonQuestionList = await rootBundle.loadString(questionsUrl);
    Map<String, dynamic> decodedQuestionList = jsonDecode(jsonQuestionList);

    var questionList = QuestionList.fromJson(decodedQuestionList).question;

    return questionList!;
  }

  Future<List<Question>> _getQuestionsFromServer() async {
    final responce = await http.get(Uri.http('10.0.2.2:8000', '')).timeout(
          Duration(seconds: 3),
          onTimeout: (() => Response('Server Error', 404)),
        );

    if (responce.statusCode == 200) {
      Map decoded = jsonDecode(responce.body);
      var questionListDecoded =
          QuestionList.fromJson(decoded as Map<String, dynamic>).question;
      print('Server is available');

      return questionListDecoded!;
    } else {
      print('HTTP error: server is not available');

      return [];
    }
  }
}
