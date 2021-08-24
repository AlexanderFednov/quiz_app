import 'package:flutter/material.dart';
import 'package:quiz_app/quizScreen/new_logic_ultimate.dart';
import 'generated/l10n.dart';
import 'package:provider/provider.dart';

class Result extends StatelessWidget {
  final Function resetHandler;

  Result({this.resetHandler});

  @override
  Widget build(BuildContext context) {
    // var bloc = context.watch<MainBloc>();
    var logicBloc = Provider.of<NewLogicUltimate>(context);

    return StreamProvider(
      create: (_) => logicBloc.logicStream,
      initialData: logicBloc.logic,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Image.network(
              'https://vogazeta.ru/uploads/full_size_1551691416-ec07565f279118e2314a7eb80dc93e66.jpg',
            ).image,
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    S.of(context).result(logicBloc.logic.totalScore,
                        logicBloc.logic.questionIndex),
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                ),
                TextButton(
                  onPressed: resetHandler,
                  child: Text(
                    S.of(context).toMainPage,
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
