import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/hive_userData.dart';
import '../generated/l10n.dart';

class UserInformation extends StatelessWidget {
  final UserData user;

  UserInformation({@required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text(
            user.userName,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              Row(
                children: [
                  Text(S.of(context).registrationDate,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(
                      '${DateFormat('yyyy-MM-dd (kk:mm)').format(user.registerDate).toString()}',
                      style: TextStyle(fontSize: 20))
                ],
              ),
              Row(
                children: [
                  Text(S.of(context).userResult,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('${user.userResult}', style: TextStyle(fontSize: 20))
                ],
              ),
            ],
          ),
        ));
  }
}
