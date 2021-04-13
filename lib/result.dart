import 'package:flutter/material.dart';
import 'generated/l10n.dart';
import 'models/questionList.dart';

class Result extends StatelessWidget {
  final Function resetHandler;
  final int score;
  final List<QuestionInside> questions;

  Result({this.score, this.resetHandler, this.questions});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: Image.network(
                      'https://vogazeta.ru/uploads/full_size_1551691416-ec07565f279118e2314a7eb80dc93e66.jpg')
                  .image,
              fit: BoxFit.cover)),
      child: Center(
        child: Container(
          height: 120,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                S.of(context).result(score, questions.length),
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              TextButton(
                child: Text(S.of(context).toMainPage,
                    style: TextStyle(fontSize: 30, color: Colors.black)),
                onPressed: resetHandler,
              )
            ],
          ),
        ),
      ),
    );
  }
}
