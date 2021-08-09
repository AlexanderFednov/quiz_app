import 'package:flutter/material.dart';
import 'package:grafpix/icons.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/models/moor_database.dart';
import 'package:grafpix/pixbuttons/medal.dart';
import 'package:animated_background/animated_background.dart';
import '../generated/l10n.dart';

class LeaderBoard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LeaderBoardState();
  }
}

class LeaderBoardState extends State<LeaderBoard>
    with TickerProviderStateMixin {
  List<MoorResult> moorResults;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(S.of(context).leaderBoard),
        centerTitle: true,
      ),
      body: AnimatedBackground(
        behaviour: RandomParticleBehaviour(
          options: ParticleOptions(
            image: Image.asset(
              'assets/images/starBig2.png',
            ),
            maxOpacity: 0.4,
            minOpacity: 0.1,
            spawnMinRadius: 5.0,
            spawnMaxRadius: 20.0,
            spawnMinSpeed: 20,
            spawnMaxSpeed: 30,
            particleCount: 200,
          ),
        ),
        vsync: this,
        child: Center(
          child: Column(
            children: [
              Flexible(child: Container(child: _buildList(context))),
              TextButton(
                onPressed: () {
                  _onNullifyPress();
                },
                child: Text(S.of(context).nullify),
              ),
              // TextButton(
              //   child: Text('Sort'),
              //   onPressed: () {
              //     _bestInCategory(1);
              //   },
              // )
            ],
          ),
        ),
      ),
    );
  }

  StreamBuilder<List<MoorResult>> _buildList(BuildContext context) {
    return StreamBuilder(
      stream: moorDatabase.watchAllResults(),
      builder: (context, AsyncSnapshot<List<MoorResult>> snapshot) {
        moorResults = snapshot.data ?? [];
        moorResults.sort(
          (b, a) => a.rightResultsPercent.compareTo(b.rightResultsPercent),
        );
        if (moorResults.isEmpty) {
          return Center(
            child: Text(
              S.of(context).userListEmpty,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          );
        }

        return ListView.builder(
          itemCount: moorResults.length < 10 ? moorResults.length : 10,
          itemBuilder: (_, index) {
            final res = moorResults[index];

            return Container(
              height: 80,
              child: Card(
                shadowColor: Colors.yellowAccent[100],
                elevation: 5,
                child: ListTile(
                  leading: Container(
                    width: 40,
                    child: Row(
                      children: [
                        Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        index < 3
                            ? Container(
                                margin: EdgeInsets.only(left: 7),
                                child: pixMedal(index + 1),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                  title: Text(
                    '${res.name} ${res.result}/${res.questionsLenght} (${res.rightResultsPercent.toStringAsFixed(1)}%) (${category(context, res.categoryNumber)}) - ${DateFormat('yyyy-MM-dd (kk:mm)').format(res.resultDate)}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _onNullifyPress() {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [Colors.white, Colors.blue[100], Colors.red[100]],
            ),
          ),
          height: 200,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  S.of(context).areYouSure,
                  style: TextStyle(fontSize: 30),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          moorDatabase.clearMyDatabase();
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          S.of(context).yes,
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          S.of(context).cancel,
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String category(BuildContext context, int categoryNumber) {
    switch (categoryNumber) {
      case 1:
        return S.of(context).questionsAll;
        break;
      case 2:
        return S.of(context).questionsFilms;
        break;
      case 3:
        return S.of(context).questionsSpace;
        break;
      case 4:
        return S.of(context).questionsWeb;
        break;
      default:
        return '';
    }
  }

  Widget medal(int place) {
    switch (place) {
      case 1:
        return Icon(
          Icons.military_tech,
          color: Colors.yellow[800],
          size: 30,
        );
        break;
      case 2:
        return Icon(Icons.military_tech, color: Colors.grey[400], size: 30);
        break;
      case 3:
        return Icon(Icons.military_tech, color: Colors.brown[800], size: 30);
        break;

      default:
        return null;
    }
  }

  Widget pixMedal(int place) {
    switch (place) {
      case 1:
        return PixMedal(
          icon: PixIcon.fa_atom,
          medalType: MedalType.Gold,
          radius: 10.0,
          iconSize: 500.0,
        );
      case 2:
        return PixMedal(
          icon: PixIcon.fa_atom,
          medalType: MedalType.Silver,
          radius: 10.0,
          iconSize: 60.0,
        );
      case 3:
        return PixMedal(
          icon: PixIcon.fa_atom,
          medalType: MedalType.Bronze,
          radius: 10.0,
          iconSize: 60.0,
        );

      default:
        return null;
    }
  }

  void categorySort(int category) {
    List<MoorResult> sortList;
    moorResults.forEach((element) {
      if (element.categoryNumber == category) {
        sortList.add(element);
      }
      setState(() {
        moorResults = sortList;
        moorResults.sort(
          (b, a) => a.rightResultsPercent.compareTo(b.rightResultsPercent),
        );
      });
    });
  }
}
