import 'package:flutter/material.dart';
import 'generated/l10n.dart';

import './answer.dart';
import './question.dart';
import './result.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestions;
  final int totalScore;
  final Function resetQuiz;
  final Function onMainPage;
  final String imageUrl;

  Quiz(
      {@required this.questions,
      @required this.questionIndex,
      @required this.answerQuestions,
      @required this.totalScore,
      @required this.resetQuiz,
      @required this.onMainPage,
      @required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return questionIndex < questions.length
        ? Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: Image.network(imageUrl).image, fit: BoxFit.cover),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Question(questions[questionIndex]['questionText']),
                ...(questions[questionIndex]['answers']
                        as List<Map<String, Object>>)
                    .map((answers) {
                  return Answer(() => answerQuestions(answers['result']),
                      answers['text'], answers['code']);
                }).toList(),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                      color: Colors.white),
                  child: TextButton(
                    child: Text(S.of(context).reset,
                        style: TextStyle(color: Colors.black)),
                    onPressed: onMainPage,
                  ),
                ),
              ],
            ))
        : Result(
            score: totalScore,
            resetHandler: resetQuiz,
            questions: questions,
          );
  }
}
