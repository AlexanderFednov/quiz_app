import 'package:flutter/material.dart';
import './quiz.dart';
import './questions.dart';
import './main_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
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

  List<Map<String, Object>> mainQuestionsAll = Questions().questionsAll;
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
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Викторина без денежных призов',
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
            ),
            Quiz(
              answerQuestions: _answerQuestion,
              questionIndex: _questionIndex,
              questions: mainQuestionsAll,
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
      ),
    );
  }
}
