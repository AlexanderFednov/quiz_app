import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
//import 'package:intl/intl.dart';
import '../generated/l10n.dart';

import '../models/hive_user_data.dart';

class AddUser extends StatefulWidget {
  final formKey = GlobalKey<FormState>();

  @override
  State<StatefulWidget> createState() {
    return AddUserState();
  }
}

class AddUserState extends State<AddUser> {
  String userName;
  //Box<UserData> contactsBox = Hive.box<UserData>('UserData1');
  List<UserData> userData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: widget.formKey,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).newUser,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  TextFormField(
                    autofocus: true,
                    initialValue: '',
                    decoration: InputDecoration(
                      labelText: S.of(context).userName,
                      errorStyle: TextStyle(color: Colors.red),
                    ),
                    validator: (value) {
                      var contactsBox = Hive.box<UserData>('UserData1');
                      if (value.trim().isEmpty || value.trim() == null) {
                        return S.of(context).enterName;
                      } else if (contactsBox.values
                          .any((element) => element.userName == userName)) {
                        return S.of(context).nameIsTaken;
                      }

                      return null;
                    },
                    onChanged: (value) {
                      var name = value.trim();
                      userName = name;
                    },
                    // inputFormatters: [
                    //   FilteringTextInputFormatter(' ', allow: false)
                    // ],
                  ),

                  // Control buttons
                  Row(
                    children: [
                      _addUserButton(),
                      _CancelButton(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _addUserButton() {
    return ElevatedButton(
      onPressed: () {
        if (widget.formKey.currentState.validate()) {
          _onForSubmit();
        }
      },
      child: Text(S.of(context).addUser),
    );
  }

  void _onForSubmit() {
    var contactsBox = Hive.box<UserData>('UserData1');

    Navigator.of(context).pop();
    contactsBox.add(UserData(
      userName: userName,
      registerDate: DateTime.now(),
      userResults: [],
      isCurrentUser: false,
    ));
  }

  // void _errorDialog(String errorText) {
  //   showDialog(
  //       context: context,
  //       builder: (_) => Center(
  //             child: Dialog(
  //               child: Container(
  //                 height: 100,
  //                 width: 300,
  //                 child: Column(
  //                   children: [
  //                     Text(
  //                       errorText,
  //                       style: TextStyle(fontSize: 23),
  //                     ),
  //                     TextButton(
  //                         onPressed: () => Navigator.of(context).pop(),
  //                         child: Text('Ок', style: TextStyle(fontSize: 20)))
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ));
  // }

  @override
  void dispose() {
    super.dispose();
  }
}

class _CancelButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
          FocusScope.of(context).unfocus();
        },
        child: Text(S.of(context).cancel),
      ),
    );
  }
}
