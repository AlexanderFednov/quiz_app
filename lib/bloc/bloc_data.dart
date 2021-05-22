import 'dart:async';

import 'package:quiz_app/widgets/progressbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:bloc/bloc.dart';
// import 'package:flutter/material.dart';

abstract class BlocBase {
  void dispose();
}

enum MainBlocEvent {
  increementLearningCounter,
  decreementLearningCounter,
  nullfyLearningCounter,
  progressAddTrue,
  progressAddFalse,
  progressNullify,
  totalScoreIncreement,
  totalScoreNullify,
  questionIndexIncreement,
  questionIndexNullify,
  setSavedScore,
  setQuestionsLenght,
  loadSavedScore,
}

class MainBloc extends BlocBase {
  int totalScore = 0;
  int questionIndex = 0;
  int savedScore = 0;
  int questionsLenght = 0;

  List progress = [];

  MainBloc() {
    outEvent.listen((event) {
      _handleEvent(event);
    });
  }

  final StreamController<MainBlocEvent> _eventController =
      StreamController<MainBlocEvent>.broadcast();

  Sink<MainBlocEvent> get inEvent => _eventController.sink;
  Stream<MainBlocEvent> get outEvent => _eventController.stream;

  void _handleEvent(MainBlocEvent event) {
    switch (event) {
      case MainBlocEvent.totalScoreIncreement:
        _totalScoreIncreement();
        break;
      case MainBlocEvent.totalScoreNullify:
        _totalScoreNullify();
        break;

      case MainBlocEvent.progressAddTrue:
        _progressAddTrue();
        break;
      case MainBlocEvent.progressAddFalse:
        _progressAddFalse();
        break;
      case MainBlocEvent.progressNullify:
        _progressNullify();
        break;
      case MainBlocEvent.questionIndexIncreement:
        _questionIndexIncreement();
        break;
      case MainBlocEvent.questionIndexNullify:
        _questionIndexNullify();
        break;
      case MainBlocEvent.setSavedScore:
        _setSavedScore();
        break;
      case MainBlocEvent.setQuestionsLenght:
        _setQuestionsLenght();
        break;
      default:
        // чтобы гарантировать, что мы не пропустим ни один кейс enum-а
        assert(false, 'Should never reach there');
        break;
    }
  }

  void _totalScoreIncreement() {
    ++totalScore;
  }

  void _totalScoreNullify() {
    totalScore = 0;
  }

  void _questionIndexIncreement() {
    ++questionIndex;
  }

  void _questionIndexNullify() {
    questionIndex = 0;
  }

  void _setSavedScore() {
    savedScore = totalScore;
  }

  void _setQuestionsLenght() {
    questionsLenght = questionIndex;
  }

  Future loadSavedScore() async {
    var prefs = await SharedPreferences.getInstance();

    savedScore = (prefs.getInt('saveScore') ?? 0);
    questionsLenght = (prefs.getInt('questionsLenght') ?? 0);

    return Future.value();
  }

  void _progressAddTrue() {
    progress.add(IconTrue());
  }

  void _progressAddFalse() {
    progress.add(
      IconFalse(),
    );
  }

  void _progressNullify() {
    progress = [];
  }

  @override
  void dispose() {
    _eventController.close();
  }
}
