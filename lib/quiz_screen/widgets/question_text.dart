import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/models/question_list.dart';
import 'package:quiz_app/quiz_screen/quiz_logic_bloc.dart';

class QuestionTextWidget extends StatelessWidget {
  const QuestionTextWidget();

  @override
  Widget build(BuildContext context) {
    var logicBloc = Provider.of<QuizLogicBloc>(context);

    return StreamBuilder<Question?>(
      stream: logicBloc.currentQuestionStream,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          var questionText = snapshot.data!.questionText;

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey),
              color: Colors.white,
            ),
            child: Text(
              questionText!,
              softWrap: true,
              style: TextStyle(
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
