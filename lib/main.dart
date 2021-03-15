import 'package:flutter/material.dart';
import './quiz.dart';
import './questions.dart';
import './main_page.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
//import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
//import 'package:intl/intl.dart';
import 'generated/l10n.dart';

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
  List<Map<String, Object>> jsonQuestAll = [];
  int _questionIndex = 0;
  int _totalScore = 0;

  void _resetQuiz() {
    cont.animateToPage(0,
        duration: (Duration(seconds: 1)), curve: Curves.easeInOut);
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(bool result) {
    if (result == true) {
      setState(() {
        _questionIndex = _questionIndex + 1;
        _totalScore++;
      });
    } else {
      setState(() {
        _questionIndex = _questionIndex + 1;
      });
    }
  }

  loadList() async {
    String jsonQuestion =
        await rootBundle.loadString('assets/questions/questionsAll.json');
    List decoded = jsonDecode(jsonQuestion);
    List<Map<String, Object>> listFun = [];

    for (Map<String, Object> i in decoded) {
      listFun.add(i);
    }
    //print(listFun);

    setState(() {
      jsonQuestAll = listFun;
    });
    print(jsonQuestAll[0]['answers']);
  }

  //List<Map<String, Object>> mainQuestionsAll = Questions().questionsAll;
  List<Map<String, Object>> mainQuestionsFilms = Questions().questionsFilms;
  List<Map<String, Object>> mainQuestionsSpace = Questions().questionsSpace;

  PageController cont = PageController();

  void swap0() {
    cont.animateToPage(0,
        duration: (Duration(seconds: 1)), curve: Curves.easeInOut);
  }

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
    });
  }

  @override
  void initState() {
    super.initState();
    loadList();

    S.load(Locale('ru', 'RU'));
  }

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
          ),
          Quiz(
            answerQuestions: _answerQuestion,
            questionIndex: _questionIndex,
            questions: jsonQuestAll,
            resetQuiz: _resetQuiz,
            totalScore: _totalScore,
            onMainPage: onMainPage,
            imageUrl:
                'https://pryamoj-efir.ru/wp-content/uploads/2017/08/Andrej-Malahov-vedushhij-Pryamoj-efir.jpg',
          ),
          Quiz(
            answerQuestions: _answerQuestion,
            questionIndex: _questionIndex,
            questions: mainQuestionsFilms,
            resetQuiz: _resetQuiz,
            totalScore: _totalScore,
            onMainPage: onMainPage,
            imageUrl:
                'https://ic.pics.livejournal.com/dubikvit/65747770/4248710/4248710_original.jpg',
          ),
          Quiz(
            answerQuestions: _answerQuestion,
            questionIndex: _questionIndex,
            questions: mainQuestionsSpace,
            resetQuiz: _resetQuiz,
            totalScore: _totalScore,
            onMainPage: onMainPage,
            imageUrl:
                'https://cubiq.ru/wp-content/uploads/2020/02/Space-780x437.jpg',
          )
        ],
      ),
    );
  }
}
