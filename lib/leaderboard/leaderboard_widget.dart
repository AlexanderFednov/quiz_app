import 'package:flutter/material.dart';
// import 'package:grafpix/icons.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/leaderboard/leaderboard_bloc.dart';
import 'package:quiz_app/registration/models/hive_user_data.dart';
import 'package:quiz_app/leaderboard/models/moor_database.dart';
// import 'package:grafpix/pixbuttons/medal.dart';
import 'package:animated_background/animated_background.dart';
import 'package:quiz_app/generated/l10n.dart';

class LeaderBoardWidget extends StatefulWidget {
  const LeaderBoardWidget();

  @override
  State<StatefulWidget> createState() {
    return LeaderBoardWidgetState();
  }
}

class LeaderBoardWidgetState extends State<LeaderBoardWidget>
    with TickerProviderStateMixin {
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
        child: const _LeaderboardBodyWidget(),
      ),
    );
  }

  // void categorySort(int category) {
  //   List<MoorResult>? sortList;
  //   moorResults!.forEach((element) {
  //     if (element.categoryNumber == category) {
  //       sortList!.add(element);
  //     }
  //     setState(() {
  //       moorResults = sortList;
  //       moorResults!.sort(
  //         (b, a) => a.rightResultsPercent.compareTo(b.rightResultsPercent),
  //       );
  //     });
  //   });
  // }
}

class _LeaderboardBodyWidget extends StatelessWidget {
  const _LeaderboardBodyWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Flexible(
            child: const _LeaderboardBuildListWidget(),
          ),
          const _NullifyLeaderboard(),
          // TextButton(
          //   child: Text('Sort'),
          //   onPressed: () {
          //     _bestInCategory(1);
          //   },
          // )
        ],
      ),
    );
  }
}

class _LeaderboardBuildListWidget extends StatelessWidget {
  const _LeaderboardBuildListWidget();

  @override
  Widget build(BuildContext context) {
    var leaderboardBloc = Provider.of<LeaderboardBloc>(context);

    return StreamBuilder<List<MoorResult>?>(
      stream: leaderboardBloc.moorResultsStream,
      initialData: [],
      builder: (context, snapshot) {
        var moorResults = snapshot.data;

        if (moorResults!.isEmpty) {
          return Center(
            child: Text(
              S.of(context).userListEmpty,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          );
        }

        return Provider.value(
          value: moorResults,
          child: const _LeaderboardWinnersListWidget(),
        );
      },
    );
  }
}

class _LeaderboardWinnersListWidget extends StatelessWidget {
  const _LeaderboardWinnersListWidget();

  @override
  Widget build(BuildContext context) {
    var moorResults = Provider.of<List<MoorResult>?>(context);

    return ListView.builder(
      itemCount: moorResults!.length < 10 ? moorResults.length : 10,
      itemBuilder: (context, index) {
        final res = moorResults[index];

        return Container(
          height: 80,
          child: Card(
            shadowColor: Colors.yellowAccent[100],
            elevation: 5,
            child: ListTile(
              title: Text(
                '${res.name} ${res.result}/${res.questionsLenght} (${res.rightResultsPercent.toStringAsFixed(1)}%) (${category(context, res.category)}) - ${DateFormat('yyyy-MM-dd (kk:mm)').format(res.resultDate)}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: Provider.value(
                value: index,
                child: const _LeaderboardListTileLeadingWidget(),
              ),
            ),
          ),
        );
      },
    );
  }

  String category(BuildContext context, Category? category) {
    switch (category) {
      case Category.generalQuestions:
        return S.of(context).questionsAll;

      case Category.moviesOfUSSSR:
        return S.of(context).questionsFilms;

      case Category.sector13:
        return S.of(context).questionsSpace;

      case Category.space:
        return S.of(context).questionsWeb;

      default:
        return '';
    }
  }
}

class _LeaderboardListTileLeadingWidget extends StatelessWidget {
  const _LeaderboardListTileLeadingWidget();

  @override
  Widget build(BuildContext context) {
    var index = Provider.of<int>(context);

    return Container(
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
          if (index < 3)
            Container(
              margin: EdgeInsets.only(left: 7),
              child: Provider.value(
                value: index + 1,
                child: const _LeaderboardMedalWidget(),
              ),
            )
          else
            SizedBox(),
        ],
      ),
    );
  }
}

class _LeaderboardMedalWidget extends StatelessWidget {
  const _LeaderboardMedalWidget();

  @override
  Widget build(BuildContext context) {
    var place = Provider.of<int>(context);

    switch (place) {
      case 1:
        return Icon(
          Icons.brightness_1,
          color: Colors.yellow,
        );

      case 2:
        return Icon(
          Icons.brightness_1,
          color: Colors.grey[400],
        );

      case 3:
        return Icon(Icons.brightness_1, color: Colors.brown[600]);

      default:
        return Container();
    }
  }
}

class _NullifyLeaderboard extends StatelessWidget {
  const _NullifyLeaderboard();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        _onNullifyPress(context);
      },
      child: Text(S.of(context).nullify),
    );
  }

  void _onNullifyPress(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [Colors.white, Colors.blue[100]!, Colors.red[100]!],
            ),
          ),
          height: 200,
          child: const _OnNullifyDialogBodyWidget(),
        ),
      ),
    );
  }
}

class _OnNullifyDialogBodyWidget extends StatelessWidget {
  const _OnNullifyDialogBodyWidget();

  @override
  Widget build(BuildContext context) {
    var leaderboardBloc = Provider.of<LeaderboardBloc>(context);

    return Center(
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
                    leaderboardBloc.nullifyLeaderboard();
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
    );
  }
}
