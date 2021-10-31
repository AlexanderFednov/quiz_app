import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/models/question_list.dart';
import 'package:quiz_app/quiz_screen/quiz_logic_bloc.dart';

class AnswerWidget extends StatelessWidget {
  const AnswerWidget();

  @override
  Widget build(BuildContext context) {
    var userListBloc = Provider.of<QuizLogicBloc>(context);
    var answer = Provider.of<Answer>(context);

    return Container(
      decoration: BoxDecoration(),
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => userListBloc.answerQuestion(answer),
        style: ButtonStyle(
          backgroundColor:
              MaterialStateColor.resolveWith((states) => Colors.blueGrey),
          animationDuration: Duration(milliseconds: 1),
          textStyle: MaterialStateProperty.all(
            TextStyle(color: Colors.white),
          ),
        ),
        child: Provider.value(
          value: answer,
          child: const _AnswerSignatureWidget(),
        ),
      ),
    );
  }
}

class _AnswerSignatureWidget extends StatelessWidget {
  const _AnswerSignatureWidget();

  @override
  Widget build(BuildContext context) {
    var answers = Provider.of<Answer>(context);

    return Row(
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
    );
  }
}
