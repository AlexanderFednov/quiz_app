import 'package:flutter/material.dart';
import './quiz.dart';
import './main_page.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'generated/l10n.dart';
import './questionList.dart';
import 'progressBar.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return QuizAppState();
  }
}

class QuizAppState extends State<QuizApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(localizationsDelegates: [
      S.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ], supportedLocales: S.delegate.supportedLocales, home: MyApp());
  }
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  List<QuestionInside> questionAll;
  List<QuestionInside> questionFilms;
  List<QuestionInside> questionSpace;

  int _questionIndex = 0;
  int _totalScore = 0;
  int _saveScore = 0;
  int _questionsLenght = 0;

  List<Widget> _progress = [];

// Reset Quiz App

  void _resetQuiz() async {
    cont.animateToPage(0,
        duration: (Duration(seconds: 1)), curve: Curves.easeInOut);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _questionsLenght = _questionIndex;
      prefs.setInt('questionsLenght', _questionIndex);
      _saveScore = _totalScore;
      prefs.setInt('saveScore', _saveScore);
      _questionIndex = 0;
      _totalScore = 0;
      _progress = [];
    });
  }

//When answer question

  void _answerQuestion(bool result) async {
    if (result == true) {
      setState(() {
        _questionIndex = _questionIndex + 1;
        _totalScore++;
        _progress.add(IconTrue());
      });
    } else {
      setState(() {
        _questionIndex = _questionIndex + 1;
        _progress.add(IconFalse());
      });
    }
  }

  //Loading savescore value on start
  _loadSaveScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _saveScore = (prefs.getInt('saveScore') ?? 0);
      _questionsLenght = (prefs.getInt('questionsLenght') ?? 0);
    });
  }

//Load banks of questions

  loadList() async {
    String jsonQuestionAll =
        await rootBundle.loadString('assets/questions/questionsAll.json');
    Map decoded = jsonDecode(jsonQuestionAll);

    var questionListAll = QuestionList.fromJson(decoded).question;

    String jsonQuestionFilms =
        await rootBundle.loadString('assets/questions/questionsFilms.json');
    Map decoded2 = jsonDecode(jsonQuestionFilms);

    var questionListFilms = QuestionList.fromJson(decoded2).question;

    String jsonQuestionSpace =
        await rootBundle.loadString('assets/questions/questionsSpace.json');
    Map decoded3 = jsonDecode(jsonQuestionSpace);

    var questionListSpace = QuestionList.fromJson(decoded3).question;

    setState(() {
      questionAll = questionListAll;
      questionFilms = questionListFilms;
      questionSpace = questionListSpace;
    });
  }

//Page navigation

  PageController cont = PageController();

  // void swap0() {
  //   cont.animateToPage(0,
  //       duration: (Duration(seconds: 1)), curve: Curves.easeInOut);
  // }

  void swap1() {
    cont.animateToPage(1,
        duration: (Duration(seconds: 1)), curve: Curves.easeInOut);
  }

  void swap2() {
    cont.animateToPage(2,
        duration: (Duration(seconds: 1)), curve: Curves.easeInOut);
  }

  void swap3() {
    cont.animateToPage(3,
        duration: (Duration(seconds: 1)), curve: Curves.easeInOut);
  }

  void onMainPage() {
    cont.animateToPage(0,
        duration: (Duration(seconds: 1)), curve: Curves.easeInOut);
    setState(() {
      _totalScore = 0;
      _questionIndex = 0;
      _progress = [];
    });
  }

//localization select

  void localeRu() {
    setState(() {
      S.load(Locale('ru', 'RU'));
    });
  }

  void localeEn() {
    setState(() {
      S.load(Locale('en', 'EN'));
    });
  }

  @override
  void initState() {
    super.initState();
    loadList();
    _loadSaveScore();

    S.load(Locale('ru', 'RU'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).titleAppbar,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: cont,
        children: <Widget>[
          MainPage(
            swap1: swap1,
            swap2: swap2,
            swap3: swap3,
            localeRu: localeRu,
            localeEn: localeEn,
            savedResult: _saveScore,
            questionsLenght: _questionsLenght,
          ),
          Quiz(
              answerQuestions: _answerQuestion,
              questionIndex: _questionIndex,
              questions: questionAll,
              resetQuiz: _resetQuiz,
              totalScore: _totalScore,
              onMainPage: onMainPage,
              imageUrl:
                  'https://pryamoj-efir.ru/wp-content/uploads/2017/08/Andrej-Malahov-vedushhij-Pryamoj-efir.jpg',
              progress: _progress),
          Quiz(
              answerQuestions: _answerQuestion,
              questionIndex: _questionIndex,
              questions: questionFilms,
              resetQuiz: _resetQuiz,
              totalScore: _totalScore,
              onMainPage: onMainPage,
              imageUrl:
                  'https://ic.pics.livejournal.com/dubikvit/65747770/4248710/4248710_original.jpg',
              progress: _progress),
          Quiz(
              answerQuestions: _answerQuestion,
              questionIndex: _questionIndex,
              questions: questionSpace,
              resetQuiz: _resetQuiz,
              totalScore: _totalScore,
              onMainPage: onMainPage,
              imageUrl:
                  'https://cubiq.ru/wp-content/uploads/2020/02/Space-780x437.jpg',
              progress: _progress)
        ],
      ),
    );
  }
}
