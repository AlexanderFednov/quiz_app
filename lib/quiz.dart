import 'package:flutter/material.dart';
import 'package:quiz_app/screens/error_screen.dart';
import 'bloc/bloc_data.dart';
import 'generated/l10n.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'answer.dart';
import 'widgets/question.dart';
import 'result.dart';
import 'models/question_list.dart';
import 'package:provider/provider.dart';

class Quiz extends StatelessWidget {
  final List<QuestionInside> questions;
  final Function answerQuestions;

  final Function resetQuiz;
  final Function onMainPage;
  final Function loadData;
  final String imageUrl;

  Quiz({
    @required this.questions,
    @required this.answerQuestions,
    @required this.resetQuiz,
    @required this.onMainPage,
    @required this.loadData,
    @required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<MainBloc>();

    return StreamBuilder(
      stream: bloc.outEvent,
      builder: (context, snapshot) {
        return bloc.questionIndex < questions.length
            ? Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Question(questions[bloc.questionIndex].questionText),
                    ...(questions[bloc.questionIndex].answers).map((answers) {
                      return Answer(
                        () => answerQuestions(answers.result),
                        answers.text,
                        answers.code,
                      );
                    }).toList(),
                    _resetButton(context),
                    _showQuestionIndex(context),
                    StreamBuilder(
                      stream: bloc.outEvent,
                      builder: (context, snapshot) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [...bloc.progress],
                        );
                      },
                    ),
                  ],
                ),
              )
            : bloc.questionIndex > 0
                ? Result(
                    resetHandler: resetQuiz,
                  )
                : ErrorScreen(
                    errorText: S.of(context).httpServerError,
                    buttonText: S.of(context).toMainPage,
                    buttonFunction: () async {
                      loadData();
                      resetQuiz();
                    },
                    imageUrl: imageUrl,
                  );
      },
    );
  }

  Widget _resetButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
        color: Colors.white,
      ),
      child: TextButton(
        onPressed: onMainPage,
        child: Text(
          S.of(context).reset,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Widget _showQuestionIndex(BuildContext context) {
    var bloc = context.watch<MainBloc>();

    return StreamBuilder(
      stream: bloc.outEvent,
      builder: (context, snapshot) {
        return Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey),
          ),
          child: Text(
            '${bloc.questionIndex + 1} / ${questions.length}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        );
      },
    );
  }
}
