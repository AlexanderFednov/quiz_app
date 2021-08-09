import 'package:flutter/material.dart';
import 'package:quiz_app/bloc/new_logic_ultimate.dart';
import 'package:quiz_app/data/logic_model.dart';
import 'package:quiz_app/screens/error_screen.dart';
import 'generated/l10n.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'answer.dart';
import 'widgets/question.dart';
import 'result.dart';
import 'models/question_list.dart';
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

    return StreamProvider<LogicModel>(
        create: (_) => logicBloc.logicStream,
        initialData: logicBloc.logic,
        child: _QuizMainScreen(
          answerQuestion: logicBloc.answerQuestion,
          onMainPage: onMainPage,
          resetQuiz: resetQuiz,
          imageUrl: imageUrl,
          questions: questions,
          loadData: loadData,
        ));
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
    var logic = Provider.of<LogicModel>(context);

    return logic.questionIndex < questions.length
        ? _QuizRun(
            questions: questions,
            imageUrl: imageUrl,
            onMainPage: onMainPage,
            answerQuestion: answerQuestion)
        : logic.questionIndex > 0
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
  }
}

class _QuizRun extends StatelessWidget {
  final List<QuestionInside> questions;

  final String imageUrl;

  final Function onMainPage;
  final Function answerQuestion;

  _QuizRun(
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
    var logic = Provider.of<LogicModel>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Question(questions[logic.questionIndex].questionText),
        _AnswersList(questions: questions, answerQuestion: answerQuestion),
        _ResetButtonWidget(onMainPage: onMainPage),
        _ShowQuestionIndexWidget(
          questions: questions,
        ),
      ],
    );
  }
}

class _AnswersList extends StatelessWidget {
  final List<QuestionInside> questions;

  final Function answerQuestion;

  _AnswersList({@required this.questions, @required this.answerQuestion});

  @override
  Widget build(BuildContext context) {
    var logic = Provider.of<LogicModel>(context);

    return Column(
      children: [
        ...(questions[logic.questionIndex].answers).map((answers) {
          return Answer(
            () => answerQuestion(answers.result),
            answers.text,
            answers.code,
          );
        }).toList(),
      ],
    );
  }
}

class _ShowQuestionIndexWidget extends StatelessWidget {
  final List<QuestionInside> questions;

  _ShowQuestionIndexWidget({@required this.questions});

  @override
  Widget build(BuildContext context) {
    var logic = Provider.of<LogicModel>(context);

    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: Text(
        '${logic.questionIndex + 1} / ${questions.length}',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
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
