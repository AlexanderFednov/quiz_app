import 'package:flutter/material.dart';
import 'package:quiz_app/questions/models/question_list.dart';
import 'package:quiz_app/quiz_screen/quiz_logic_bloc.dart';
import 'package:quiz_app/quiz_screen/quiz_logic_model.dart';
import '../../generated/l10n.dart';
import 'package:provider/provider.dart';

class Result extends StatelessWidget {
  const Result();

  @override
  Widget build(BuildContext context) {
    return Container(
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
          child: const _ResultBodyWidget(),
        ),
      ),
    );
  }
}

class _ResultBodyWidget extends StatelessWidget {
  const _ResultBodyWidget();

  @override
  Widget build(BuildContext context) {
    var logicBloc = Provider.of<QuizLogicBloc>(context);

    return StreamBuilder<int>(
      stream: logicBloc.totalScoreStream,
      initialData: logicBloc.logicState.totalScore,
      builder: (context, snapshot) {
        var totalScore = snapshot.data;

        return StreamBuilder<List<Question>>(
          stream: logicBloc.questionsStream,
          initialData: [],
          builder: (context, snapshot) {
            var questionsLenght = snapshot.data!.length;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    S.of(context).result(
                          totalScore!,
                          questionsLenght,
                        ),
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                ),
                TextButton(
                  onPressed: () => logicBloc.reset(),
                  child: Text(
                    S.of(context).toMainPage,
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
