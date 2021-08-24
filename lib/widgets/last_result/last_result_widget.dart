import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/quizScreen/new_logic_ultimate.dart';
import 'package:quiz_app/quizScreen/logic_model.dart';
import '../../generated/l10n.dart';

class LastResultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var bloc = context.watch<MainBloc>();
    var logicBloc = Provider.of<NewLogicUltimate>(context);

    return StreamBuilder<LogicModel>(
        stream: logicBloc.logicStream,
        builder: (context, snapshot) {
          return Text(
            S.of(context).lastResult(
                  logicBloc.logic.savedScore,
                  logicBloc.logic.savedQuestionLenght,
                ),
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          );
        });
  }
}
