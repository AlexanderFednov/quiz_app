import 'package:flutter/material.dart';
import 'package:quiz_app/quizScreen/new_logic_ultimate.dart';
import 'package:quiz_app/quizScreen/logic_model.dart';
import 'package:quiz_app/screens/error_screen.dart';
import 'package:quiz_app/widgets/progressbar.dart';
import '../generated/l10n.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../answer.dart';
import '../widgets/question_text.dart';
import '../result.dart';
import '../models/question_list.dart';
import 'package:provider/provider.dart';

class Quiz extends StatelessWidget {
  final List<QuestionInside> questions;

  final Function resetQuiz;
  final Function onMainPage;
  final Function loadData;
  final String imageUrl;

  Quiz({
    @required this.questions,
    @required this.resetQuiz,
    @required this.onMainPage,
    @required this.loadData,
    @required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final logicBloc = Provider.of<NewLogicUltimate>(context);

    return
        // StreamProvider<LogicModel>(
        //   create: (_) => logicBloc.logicStream,
        //   initialData: logicBloc.logic,
        //   child:
        _QuizMainScreen(
      answerQuestion: logicBloc.answerQuestion,
      onMainPage: onMainPage,
      resetQuiz: resetQuiz,
      imageUrl: imageUrl,
      questions: questions,
      loadData: loadData,
    )
        //   ,
        // )
        ;
  }
}

class _QuizMainScreen extends StatelessWidget {
  final List<QuestionInside> questions;

  final String imageUrl;

  final Function answerQuestion;
  final Function onMainPage;
  final Function resetQuiz;
  final Function loadData;

  _QuizMainScreen(
      {@required this.questions,
      @required this.imageUrl,
      @required this.answerQuestion,
      @required this.onMainPage,
      @required this.resetQuiz,
      @required this.loadData});

  @override
  Widget build(BuildContext context) {
    var logicBloc = Provider.of<NewLogicUltimate>(context);

    return StreamBuilder<int>(
        stream: logicBloc.logicQuestionIndexStream,
        initialData: logicBloc.questionIndex,
        builder: (context, snapshot) {
          var index = snapshot.data;
          return index < questions.length
              ? _RunQuiz(
                  questions: questions,
                  imageUrl: imageUrl,
                  onMainPage: onMainPage,
                  answerQuestion: answerQuestion)
              : index > 0
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
        });
  }
}

class _RunQuiz extends StatelessWidget {
  final List<QuestionInside> questions;

  final String imageUrl;

  final Function onMainPage;
  final Function answerQuestion;

  _RunQuiz(
      {@required this.questions,
      @required this.imageUrl,
      @required this.onMainPage,
      @required this.answerQuestion});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: _QuizQuestion(
        questions: questions,
        onMainPage: onMainPage,
        answerQuestion: answerQuestion,
      ),
    );
  }
}

class _QuizQuestion extends StatelessWidget {
  _QuizQuestion(
      {@required this.questions,
      @required this.onMainPage,
      @required this.answerQuestion});

  final List<QuestionInside> questions;

  final Function onMainPage;
  final Function answerQuestion;

  @override
  Widget build(BuildContext context) {
    var logicBloc = Provider.of<NewLogicUltimate>(context);

    return StreamBuilder<int>(
      stream: logicBloc.logicQuestionIndexStream,
      initialData: logicBloc.questionIndex,
      builder: (context, snapshot) {
        var index = snapshot.data;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            QuestionText(questions[index].questionText),
            _AnswersListWidget(
                questions: questions, answerQuestion: answerQuestion),
            _ResetButtonWidget(onMainPage: onMainPage),
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
  final List<QuestionInside> questions;

  final Function answerQuestion;

  _AnswersListWidget({@required this.questions, @required this.answerQuestion});

  @override
  Widget build(BuildContext context) {
    var logicBloc = Provider.of<NewLogicUltimate>(context);

    return StreamBuilder<int>(
        stream: logicBloc.logicQuestionIndexStream,
        initialData: logicBloc.questionIndex,
        builder: (context, snapshot) {
          var index = snapshot.data;
          return Column(
            children: [
              ...(questions[index].answers).map((answers) {
                return Answer(
                  () => answerQuestion(answers.result),
                  answers.text,
                  answers.code,
                );
              }).toList(),
            ],
          );
        });
  }
}

class _ShowQuestionNumberWidget extends StatelessWidget {
  final List<QuestionInside> questions;

  _ShowQuestionNumberWidget({@required this.questions});

  @override
  Widget build(BuildContext context) {
    var logicBloc = Provider.of<NewLogicUltimate>(context);

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
          initialData: logicBloc.questionIndex,
          builder: (context, snapshot) {
            var index = snapshot.data;
            return Text(
              '${index + 1} / ${questions.length}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            );
          }),
    );
  }
}

class _ResetButtonWidget extends StatelessWidget {
  final Function onMainPage;

  _ResetButtonWidget({this.onMainPage});

  @override
  Widget build(BuildContext context) {
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
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar();

  @override
  Widget build(BuildContext context) {
    var logicBloc = Provider.of<NewLogicUltimate>(context);

    return StreamBuilder<List<AnswerStatus>>(
        stream: logicBloc.answerStatusListStream,
        initialData: logicBloc.answerStatusList,
        builder: (context, snapshot) {
          var answerStatusList = snapshot.data;

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...answerStatusList.map(
                (status) => Provider.value(
                  value: status,
                  child: const _AnswerStatusIcon(),
                ),
              )
            ],
          );
        });
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
