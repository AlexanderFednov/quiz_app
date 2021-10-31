import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/quiz_screen/quiz_logic_bloc.dart';
import '../../generated/l10n.dart';

class LastResultWidget extends StatelessWidget {
  const LastResultWidget();

  @override
  Widget build(BuildContext context) {
    var logicBloc = Provider.of<QuizLogicBloc>(context);

    return StreamBuilder<int>(
      stream: logicBloc.savedScoreSctream,
      initialData: logicBloc.logicState.savedScore,
      builder: (context, snapshot) {
        var savedScore = snapshot.data;

        return StreamBuilder<int>(
          stream: logicBloc.savedQuestionsLenghtStream,
          initialData: logicBloc.logicState.savedQuestionLenght,
          builder: (context, snapshot) {
            var savedQuestionLenght = snapshot.data;

            return Text(
              S.of(context).lastResult(
                    savedScore!,
                    savedQuestionLenght!,
                  ),
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        );
      },
    );
  }
}
