import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/quiz_screen/quiz_logic_bloc.dart';
import 'package:quiz_app/quiz_screen/quiz_logic_model.dart';
import '../../generated/l10n.dart';

class LastResultWidget extends StatelessWidget {
 const LastResultWidget();

  @override
  Widget build(BuildContext context) {
    // var bloc = context.watch<MainBloc>();
    var logicBloc = Provider.of<QuizLogicBloc>(context);

    return StreamBuilder<QuizLogicModel>(
      stream: logicBloc.logicStateStream,
      initialData: logicBloc.logicState,
      builder: (context, snapshot) {
        var logicModel = snapshot.data;

        return Text(
          S.of(context).lastResult(
                logicModel!.savedScore,
                logicModel.savedQuestionLenght,
              ),
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    );
  }
}
