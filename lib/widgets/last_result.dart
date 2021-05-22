import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/bloc/bloc_data.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../generated/l10n.dart';

class LastResultWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LastResultWidgetState();
  }
}

class LastResultWidgetState extends State<LastResultWidget> {
  final _mainBlocInstance = MainBloc();
  var _futureLoadLastResults;

  @override
  Widget build(BuildContext context) {
    var bloc = context.watch<MainBloc>();

    return FutureBuilder(
        future: _futureLoadLastResults,
        builder: (context, snapshot) {
          return StreamBuilder(
              stream: bloc.outEvent,
              builder: (context, snapshot) {
                return Text(
                  S.of(context).lastResult(_mainBlocInstance.savedScore,
                      _mainBlocInstance.questionsLenght,),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },);
        },);
  }

  // void loadSaveScore() async {
  //   var prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     savedResult = (prefs.getInt('saveScore') ?? 0);
  //     questionsLenght = (prefs.getInt('questionsLenght') ?? 0);
  //   });
  // }

  @override
  void initState() {
    super.initState();
    _futureLoadLastResults = _mainBlocInstance.loadSavedScore();
    // loadSaveScore();
  }
}
