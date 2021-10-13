import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/hive_user_data.dart';
import '../generated/l10n.dart';

class UserInformation extends StatefulWidget {
  final UserData? user;

  UserInformation({required this.user});

  @override
  State<StatefulWidget> createState() {
    return UserInformationState(user: user);
  }
}

class UserInformationState extends State<UserInformation> {
  final UserData? user;
  List<UserResult>? results;

  UserInformationState({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          user!.userName!,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: _userInformationCollumn(),
    );
  }

  Widget _userInformationCollumn() {
    return Center(
      child: Column(
        children: [
          _registrationDate(),
          _lastResult(),
          _rightAnswersPersent(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                S.of(context).allUserResult,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          user!.userResults!.isNotEmpty && user!.userResults != null
              ? _allUserResultsList()
              : _userResultsListEmpty(),
          _nullifyButton(),
        ],
      ),
    );
  }

  Widget _registrationDate() {
    return Row(
      children: [
        Text(
          S.of(context).registrationDate,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          '${DateFormat('yyyy-MM-dd (kk:mm)').format(user!.registerDate!).toString()}',
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }

  Widget _lastResult() {
    return Row(
      children: [
        Text(
          S.of(context).userLastResult,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          user!.userResults!.isEmpty
              ? '0'
              : '${user!.userResults![0].score} / ${user!.userResults![0].questionsLenght}',
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }

  Widget _rightAnswersPersent() {
    return Row(
      children: [
        Text(
          S.of(context).rightAnswersPercent,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          user!.userResults!.isEmpty
              ? '0 %'
              : '${user!.rightAnswersPercentAll.toStringAsFixed(2)} %',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  Widget _allUserResultsList() {
    return Container(
      height: 400,
      child: Scrollbar(
        hoverThickness: 10,
        radius: Radius.circular(10),
        showTrackOnHover: true,
        isAlwaysShown: true,
        thickness: 10,
        child: ListView.builder(
          itemCount: user!.userResults!.length,
          itemBuilder: (context, index) {
            results = user!.userResults;
            results!.sort(
              (b, a) => a.resultDate!.compareTo(b.resultDate!),
            );

            return Card(
              child: ListTile(
                title: Text(
                  '${results![index].score} / ${results![index].questionsLenght} (${results![index].rightAnswersPercent.toStringAsFixed(1)}%)(${category(context, results![index].categoryNumber)}) / ${DateFormat('yyyy-MM-dd (kk:mm)').format(results![index].resultDate!)}',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _userResultsListEmpty() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: Text(
          S.of(context).resultsListEmpty,
          style: TextStyle(fontSize: 15),
        ),
      ),
    );
  }

  Widget _nullifyButton() {
    return TextButton(
      onPressed: _onNullifyPress,
      child: Text(
        S.of(context).nullify,
        style: TextStyle(
          color: user!.userResults!.isEmpty
              ? Colors.grey
              : Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  void _deleteData() async {
    setState(() {
      user!.userResults!.clear();
      user!.userResult = 0;
      user!.save();
      Navigator.of(context).pop();
    });
  }

  void _onNullifyPress() {
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
                        onPressed: _deleteData,
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

  String category(BuildContext context, int? categoryNumber) {
    switch (categoryNumber) {
      case 1:
        return S.of(context).questionsAll;

      case 2:
        return S.of(context).questionsFilms;

      case 3:
        return S.of(context).questionsSpace;

      case 4:
        return S.of(context).questionsWeb;

      default:
        return '';
    }
  }
}
