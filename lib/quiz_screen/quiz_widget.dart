import 'package:flutter/material.dart';
import 'package:quiz_app/quiz_screen/quiz_logic_bloc.dart';
import 'package:quiz_app/quiz_screen/quiz_logic_model.dart';
import 'package:quiz_app/quiz_screen/widgets/progress_bar_icons.dart';
import 'package:quiz_app/generated/l10n.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:quiz_app/quiz_screen/widgets/answer.dart';
import 'package:quiz_app/quiz_screen/widgets/question_text.dart';
import 'package:quiz_app/questions/models/question_list.dart';
import 'package:provider/provider.dart';

class QuizScreenWidget extends StatelessWidget {
  QuizScreenWidget({
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const QuestionTextWidget(),
          const _AnswersListWidget(),
          const _ResetButtonWidget(),
          const _ShowQuestionNumberWidget(),
          const _ProgressBar(),
        ],
      ),
    );
  }
}

class _AnswersListWidget extends StatelessWidget {
  const _AnswersListWidget();

  @override
  Widget build(BuildContext context) {
    var logicBloc = Provider.of<QuizLogicBloc>(context);

    return StreamBuilder<Question?>(
      stream: logicBloc.currentQuestionStream,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          var currentQuestion = snapshot.data!;

          return Column(
            children: [
              ...(currentQuestion.answers!).map((answer) {
                return Provider.value(
                  value: answer,
                  child: const AnswerWidget(),
                );
              }).toList(),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class _ShowQuestionNumberWidget extends StatelessWidget {
  const _ShowQuestionNumberWidget();

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
        stream: logicBloc.questionIndexStream,
        initialData: logicBloc.currentQuestionIndex,
        builder: (context, snapshot) {
          var questionNumber = snapshot.data!;

          return StreamBuilder<int>(
            stream: logicBloc.questionsLenghtStream,
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                var questionsListLenght = snapshot.data!;

                return Text(
                  '${questionNumber + 1} / $questionsListLenght',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                );
              } else {
                return Container();
              }
            },
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
                child: const _AnswerStatusIconWidget(),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _AnswerStatusIconWidget extends StatelessWidget {
  const _AnswerStatusIconWidget();

  @override
  Widget build(BuildContext context) {
    var status = Provider.of<AnswerStatus>(context);

    return status == AnswerStatus.right
        ? const IconTrueWidget()
        : const IconFalseWidget();
  }
}
