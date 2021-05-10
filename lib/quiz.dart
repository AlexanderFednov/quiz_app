import 'package:flutter/material.dart';
import 'package:quiz_app/screens/error_Screen.dart';
import 'generated/l10n.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'answer.dart';
import 'widgets/question.dart';
import 'result.dart';
import 'models/questionList.dart';

class Quiz extends StatelessWidget {
  final List<QuestionInside> questions;
  final int questionIndex;
  final Function answerQuestions;
  final int totalScore;
  final Function resetQuiz;
  final Function onMainPage;
  final Function loadData;
  final String imageUrl;
  final List<Widget> progress;

  Quiz({
    @required this.questions,
    @required this.questionIndex,
    @required this.answerQuestions,
    @required this.totalScore,
    @required this.resetQuiz,
    @required this.onMainPage,
    @required this.loadData,
    @required this.imageUrl,
    @required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return questionIndex < questions.length
        ? Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Question(questions[questionIndex].questionText),
                ...(questions[questionIndex].answers).map((answers) {
                  return Answer(
                    () => answerQuestions(answers.result),
                    answers.text,
                    answers.code,
                  );
                }).toList(),
                _resetButton(context),
                _questionIndex(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [...progress],
                ),
              ],
            ),
          )
        : questionIndex > 0
            ? Result(
                score: totalScore,
                resetHandler: resetQuiz,
                questions: questions,
              )
            : ErrorScreen(
                errorText: S.of(context).httpServerError,
                buttonText: S.of(context).toMainPage,
                buttonFunction: () async {
                  resetQuiz();
                  await loadData();
                },
                imageUrl: imageUrl,
              );
  }

  Widget _resetButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
        color: Colors.white,
      ),
      child: TextButton(
        onPressed: onMainPage,
        child: Text(
          S.of(context).reset,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Widget _questionIndex() {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: Text(
        '${questionIndex + 1} / ${questions.length}',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
