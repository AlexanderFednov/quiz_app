import 'dart:async';

// import 'package:bloc/bloc.dart';
// import 'package:flutter/material.dart';

abstract class BlocBase {
  void dispose();
}

enum MainBlocEvent {
  
  increementLearningCounter,
}

class MainBloc extends BlocBase {

  int _learningCounter;

  MainBloc() {
    _outEvent.listen((event) {
      _handleEvent(event);
    });
  }

  final StreamController<MainBlocEvent> _eventController =
      StreamController<MainBlocEvent>();
 
  final StreamController<int> _learningCounterController =
      StreamController<int>();

  Sink<MainBlocEvent> get inEvent => _eventController.sink;
  Stream<MainBlocEvent> get _outEvent => _eventController.stream;

 

  Sink<int> get _inLearningCounter => _learningCounterController.sink;
  Stream<int> get outLearningCounter => _learningCounterController.stream;

  void _handleEvent(MainBlocEvent event) {
    switch (event) {
      case MainBlocEvent.increementLearningCounter:
        _handleIncreementLearningCounter();
        break;
      default:
        // чтобы гарантировать, что мы не пропустим ни один кейс enum-а
        assert(false, 'Should never reach there');
        break;
    }
  }



  void _handleIncreementLearningCounter() {
    _inLearningCounter.add(++_learningCounter);
  }

  @override
  void dispose() {
    _eventController.close();
    _learningCounterController.close();
  }
}
