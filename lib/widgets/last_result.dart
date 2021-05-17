import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../generated/l10n.dart';

class LastResultWidget extends StatefulWidget {
  final savedResult;
  final questionsLenght;

  LastResultWidget(
      {@required this.savedResult, @required this.questionsLenght});

  @override
  State<StatefulWidget> createState() {
    return LastResultWidgetState(
        savedResult: savedResult, questionsLenght: questionsLenght);
  }
}

class LastResultWidgetState extends State<LastResultWidget> {
  int savedResult;
  int questionsLenght;

  LastResultWidgetState(
      {@required this.savedResult, @required this.questionsLenght});

  @override
  Widget build(BuildContext context) {
    return Text(
      S.of(context).lastResult(savedResult, questionsLenght),
      style: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  void loadSaveScore() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      savedResult = (prefs.getInt('saveScore') ?? 0);
      questionsLenght = (prefs.getInt('questionsLenght') ?? 0);
    });
  }

  @override
  void initState() {
    super.initState();
    loadSaveScore();
  }
}
