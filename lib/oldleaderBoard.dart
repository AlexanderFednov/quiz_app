import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'generated/l10n.dart';

class OldLeaderBoard extends StatefulWidget {
  final List<String> lastResults;
  final Function resetLeaderBoard;

  OldLeaderBoard({this.lastResults, this.resetLeaderBoard});

  @override
  State<StatefulWidget> createState() {
    return OldLeaderBoardState(
        lastResults: lastResults, resetLeaderBoard: resetLeaderBoard);
  }
}

class OldLeaderBoardState extends State {
  List<String> lastResults;
  Function resetLeaderBoard;
  OldLeaderBoardState({this.lastResults, this.resetLeaderBoard});

  @override
  void initState() {
    super.initState();
  }

  _resetBoardState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    lastResults = [];
    setState(() {
      resetLeaderBoard();
      lastResults = [];
      prefs.setStringList('lastResults', lastResults);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).lastResults),
          backgroundColor: Colors.amber,
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                height: 450,
                width: double.infinity,
                child: ListView(
                  children: [
                    ...(lastResults).map((result) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey),
                            color: Colors.white),
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text(result,
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                      );
                    }),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                child: Text(S.of(context).resetLeaderBoard,
                    style: TextStyle(fontSize: 30)),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateColor.resolveWith((states) => Colors.red)),
                onPressed: () {
                  _resetBoardState();
                },
              )
            ],
          ),
        ));
  }
}
