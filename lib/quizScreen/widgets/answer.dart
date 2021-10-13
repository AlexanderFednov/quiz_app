import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/models/question_list.dart';
import 'package:quiz_app/quizScreen/quiz_logic_bloc.dart';

class Answer extends StatelessWidget {
  const Answer();

  @override
  Widget build(BuildContext context) {
    var userListBloc = Provider.of<QuizLogicBloc>(context);
    var answers = Provider.of<Answers>(context);

    return Container(
      decoration: BoxDecoration(),
      //borderRadius: BorderRadius.circular(20),
      //border: Border.all(color: Colors.black, width: 1),
      //color: Colors.blueGrey),
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => userListBloc.answerQuestion(answers.result!),
        style: ButtonStyle(
          backgroundColor:
              MaterialStateColor.resolveWith((states) => Colors.blueGrey),
          animationDuration: Duration(milliseconds: 1),
          textStyle: MaterialStateProperty.all(
            TextStyle(color: Colors.white),
          ),
        ),
        child: Row(
          children: <Widget>[
            Text(
              '${answers.code})  ',
              softWrap: true,
              style: TextStyle(
                fontSize: 25,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              answers.text!,
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
