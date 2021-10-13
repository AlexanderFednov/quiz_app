import 'package:flutter/material.dart';
import 'package:quiz_app/quizScreen/quiz_logic_bloc.dart';
import 'package:quiz_app/quizScreen/quiz_logic_model.dart';
import 'package:quiz_app/screens/error_screen.dart';
import 'package:quiz_app/quizScreen/widgets/progress_bar_icons.dart';
import '../generated/l10n.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'widgets/answer.dart';
import 'widgets/question_text.dart';
import 'widgets/result.dart';
import '../models/question_list.dart';
import 'package:provider/provider.dart';

// class Quiz extends StatelessWidget {
//   final List<QuestionInside>? questions;

//   final String imageUrl;

//   Quiz({
//     required this.questions,
//     required this.imageUrl,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return
//         // StreamProvider<LogicModel>(
//         //   create: (_) => logicBloc.logicStream,
//         //   initialData: logicBloc.logic,
//         //   child:
//         _QuizMainScreen(
//       imageUrl: imageUrl,
//       questions: questions,
//     )
//         //   ,
//         // )
//         ;
//   }
// }

class QuizScreenWidget extends StatelessWidget {
  final List<QuestionInside>? questions;

  final String imageUrl;

  QuizScreenWidget({
    required this.questions,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    var logicBloc = Provider.of<QuizLogicBloc>(context);

    return StreamBuilder<int>(
      stream: logicBloc.logicQuestionIndexStream,
      initialData: logicBloc.currentQuestionIndex,
      builder: (context, snapshot) {
        var index = snapshot.data!;

        return index < questions!.length
            ? _RunQuiz(
                questions: questions,
                imageUrl: imageUrl,
              )
            : index > 0
                ? const Result()
                : ErrorScreen(
                    errorText: S.of(context).httpServerError,
                    buttonText: S.of(context).toMainPage,
                    imageUrl: imageUrl,
                  );
      },
    );
  }
}

class _RunQuiz extends StatelessWidget {
  final List<QuestionInside>? questions;

  final String imageUrl;

  _RunQuiz({
    required this.questions,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: _QuizQuestionWidget(
        questions: questions,
      ),
    );
  }
}

class _QuizQuestionWidget extends StatelessWidget {
  _QuizQuestionWidget({
    required this.questions,
  });

  final List<QuestionInside>? questions;

  @override
  Widget build(BuildContext context) {
    var logicBloc = Provider.of<QuizLogicBloc>(context);

    return StreamBuilder<int>(
      stream: logicBloc.logicQuestionIndexStream,
      initialData: logicBloc.currentQuestionIndex,
      builder: (context, snapshot) {
        var index = snapshot.data!;

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            QuestionText(questions![index].questionText),
            _AnswersListWidget(
              questions: questions,
            ),
            const _ResetButtonWidget(),
            _ShowQuestionNumberWidget(
              questions: questions,
            ),
            const _ProgressBar(),
          ],
        );
      },
    );
  }
}

class _AnswersListWidget extends StatelessWidget {
  _AnswersListWidget({required this.questions});

  final List<QuestionInside>? questions;

  @override
  Widget build(BuildContext context) {
    var logicBloc = Provider.of<QuizLogicBloc>(context);

    return StreamBuilder<int>(
      stream: logicBloc.logicQuestionIndexStream,
      initialData: logicBloc.currentQuestionIndex,
      builder: (context, snapshot) {
        var index = snapshot.data!;

        return Column(
          children: [
            ...(questions![index].answers!).map((answers) {
              return Provider.value(
                value: answers,
                child: const Answer(),
              );
            }).toList(),
          ],
        );
      },
    );
  }
}

class _ShowQuestionNumberWidget extends StatelessWidget {
  final List<QuestionInside>? questions;

  _ShowQuestionNumberWidget({required this.questions});

  @override
  Widget build(BuildContext context) {
    var logicBloc = Provider.of<QuizLogicBloc>(context);

    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: StreamBuilder<int>(
        stream: logicBloc.logicQuestionIndexStream,
        initialData: logicBloc.currentQuestionIndex,
        builder: (context, snapshot) {
          var index = snapshot.data!;

          return Text(
            '${index + 1} / ${questions!.length}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          );
        },
      ),
    );
  }
}

class _ResetButtonWidget extends StatelessWidget {
  const _ResetButtonWidget();

  @override
  Widget build(BuildContext context) {
    var logicBloc = Provider.of<QuizLogicBloc>(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
        color: Colors.white,
      ),
      child: TextButton(
        onPressed: () => logicBloc.reset(),
        child: Text(
          S.of(context).reset,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar();

  @override
  Widget build(BuildContext context) {
    var logicBloc = Provider.of<QuizLogicBloc>(context);

    return StreamBuilder<List<AnswerStatus>?>(
      stream: logicBloc.answerStatusListStream,
      initialData: logicBloc.answerStatusList,
      builder: (context, snapshot) {
        var answerStatusList = snapshot.data!;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...answerStatusList.map(
              (status) => Provider.value(
                value: status,
                child: const _AnswerStatusIcon(),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _AnswerStatusIcon extends StatelessWidget {
  const _AnswerStatusIcon();

  @override
  Widget build(BuildContext context) {
    var status = Provider.of<AnswerStatus>(context);

    return status == AnswerStatus.right ? IconTrue() : IconFalse();
  }
}
