import 'package:flutter/material.dart';
import 'generated/l10n.dart';

class Result extends StatelessWidget {
  final Function resetHandler;
  final int score;
  final List<Map<String, Object>> questions;

  Result({this.score, this.resetHandler, this.questions});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: Image.network(
                      'https://lh3.googleusercontent.com/proxy/ryGAu_ryOUlOcuAiuYhl4atXwWitF4AcMUMh6Q6iTTpwIwoSaJ1yq0C79iII2D3GeFl3YpC6Dl4cUKVjcg2kWECkRZFdhXTv9vDA421prbduuh2hIuF-kw')
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
                'Правильных ответов - $score из ${questions.length}',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              TextButton(
                child: Text('На главную страницу',
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
