import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
//import 'package:intl/intl.dart';
import 'package:quiz_app/screens/add_User.dart';
import '../models/hive_userData.dart';
import '../screens/user_Information.dart';
import '../generated/l10n.dart';

class UserList extends StatefulWidget {
  final Function setCurrentUser;
  final Function clearCurrentUser;
  UserList({@required this.setCurrentUser, @required this.clearCurrentUser});

  @override
  State<StatefulWidget> createState() {
    return UserListState(
        setCurrentUser: setCurrentUser, clearCurrentUser: clearCurrentUser);
  }
}

class UserListState extends State<UserList> {
  UserData currentUser;

  Function setCurrentUser;
  Function clearCurrentUser;

  TextEditingController cont = TextEditingController();

  List _searchResult = [];

  String searchText;

  FocusNode _focus = FocusNode();

  UserListState(
      {@required this.setCurrentUser, @required this.clearCurrentUser});

  List<UserData> userData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).userList),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Container(
        child: Column(
          children: [
            if (currentUser != null)
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(12)),
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Text(
                      S.of(context).currentUser,
                      style: TextStyle(fontSize: 30),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(currentUser.userName,
                            style: TextStyle(fontSize: 30)),
                        Text(
                            currentUser.userResults.isEmpty
                                ? '0/0'
                                : '${currentUser.userResults[0].score}/${currentUser.userResults[0].questionsLenght}',
                            style: TextStyle(fontSize: 30))
                      ],
                    )
                  ],
                ),
              ),
            Container(
              color: _focus.hasFocus
                  ? Theme.of(context).primaryColor
                  : Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.search,
                        color:
                            _focus.hasFocus ? Colors.blue[700] : Colors.grey),
                    title: TextField(
                      focusNode: _focus,
                      // inputFormatters: [
                      //   FilteringTextInputFormatter(' ', allow: false)
                      // ],
                      autofocus: false,
                      controller: cont,
                      onChanged: (value) {
                        setState(() {
                          _onSearchChange(value);
                        });
                      },
                      decoration: InputDecoration(
                          hintText: S.of(context).search,
                          border: InputBorder.none),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.cancel,
                        color: _focus.hasFocus ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          cont.clear();
                          _searchResult = [];
                          FocusScope.of(context).unfocus();
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            if (_searchResult.isNotEmpty)
              Expanded(
                child: ListView.builder(
                    itemCount: _searchResult.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          _searchResult[index].userName,
                          style: TextStyle(fontSize: 20),
                        ),
                        leading: IconButton(
                          icon: Icon(Icons.info_rounded, color: Colors.blue),
                          onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => UserInformation(
                                      user: _searchResult[index]))),
                        ),
                        onTap: () {
                          setState(() {
                            Hive.box<UserData>('UserData1')
                                .values
                                .forEach((element) {
                              element.isCurrentUser = false;
                            });
                            Hive.box<UserData>('UserData1')
                                .values
                                .forEach((element) {
                              if (element.userName
                                  .contains(_searchResult[index].userName)) {
                                element.isCurrentUser = true;
                                currentUser = element;
                              }
                            });
                            _searchResult = [];
                            cont.clear();
                            setCurrentUser();
                            FocusScope.of(context).unfocus();
                          });
                        },
                      );
                    }),
              ),
            Flexible(
              child: Container(
                child: ValueListenableBuilder(
                  valueListenable: Hive.box<UserData>('UserData1').listenable(),
                  builder: (context, Box<UserData> box, _) {
                    if (box.values.isEmpty)
                      return Center(
                        child: Text(S.of(context).userListEmpty),
                      );
                    userData = Hive.box<UserData>('UserData1').values.toList();
                    userData.sort((a, b) => a.userName.compareTo(b.userName));
                    return ListView.builder(
                        itemCount: userData.length,
                        itemBuilder: (context, index) {
                          UserData res = userData[index];
                          res.userId = index;
                          return Dismissible(
                            key: UniqueKey(),
                            onDismissed: (direction) {
                              onDismiss(res);
                              // res.delete();
                              // setState(() {
                              //   if (currentUser == res) {
                              //     currentUser = null;
                              //   }
                              // });
                            },
                            child: ListTile(
                              title: Text(
                                res.userName,
                                style: TextStyle(fontSize: 20),
                              ),
                              // subtitle: Text(
                              //   'Дата регистрации: ${DateFormat('yyyy-MM-dd (kk:mm)').format(res.registerDate).toString()}',
                              //   style: TextStyle(fontSize: 12),
                              // ),
                              trailing: Container(
                                height: 40,
                                width: 110,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                        res.userResults.isNotEmpty
                                            ? '${res.rightAnswersPercentAll.toStringAsFixed(1)} %'
                                            : '0 %',
                                        style: TextStyle(fontSize: 15)),
                                    IconButton(
                                      icon: Icon(Icons.info_rounded,
                                          color: Colors.blue),
                                      onPressed: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  UserInformation(user: res))),
                                    )
                                  ],
                                ),
                              ),
                              leading: //Text(res.isCurrentUser.toString()),
                                  res.isCurrentUser
                                      ? Icon(
                                          Icons.check_box,
                                          color: Colors.green,
                                        )
                                      : Icon(Icons.check_box_outline_blank),
                              onTap: () async {
                                setState(() {
                                  box.values.forEach((element) {
                                    element.isCurrentUser = false;
                                    element.save();
                                  });
                                  res.isCurrentUser = true;
                                  //res.userId = index;
                                  currentUser = res;
                                  //currentUser.userId = index;
                                  res.save();
                                  setCurrentUser();
                                });
                              },
                            ),
                          );
                        });
                  },
                ),
              ),
            ),
            TextButton(
              child: Text(
                S.of(context).nullify,
              ),
              onPressed: onNullifyPress,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          tooltip: 'Add User',
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddUser()))),
    );
  }

  void deleteData() async {
    Box<UserData> contactsBox = Hive.box<UserData>('UserData1');
    setState(() {
      contactsBox.clear();
      currentUser = null;
      Navigator.of(context).pop();
    });
  }

  onNullifyPress() {
    showDialog(
        context: context,
        builder: (_) => Dialog(
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors: [Colors.white, Colors.blue[100], Colors.red[100]],
                )),
                height: 200,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(S.of(context).areYouSure,
                          style: TextStyle(fontSize: 30)),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              child: Text(S.of(context).yes,
                                  style: TextStyle(fontSize: 25)),
                              onPressed: deleteData,
                            ),
                            TextButton(
                              child: Text(S.of(context).cancel,
                                  style: TextStyle(fontSize: 25)),
                              onPressed: () => Navigator.of(context).pop(),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }

  void _getCurrentUser() {
    Box<UserData> contactsBox = Hive.box<UserData>('UserData1');
    if (contactsBox.isNotEmpty) {
      contactsBox.values.forEach((element) {
        if (element.isCurrentUser == true) {
          currentUser = element;
        }
      });
    } else
      currentUser = null;
  }

  @override
  void initState() {
    super.initState();

    _getCurrentUser();
    _focus.addListener(() {
      setState(() {});
    });
  }

  _onSearchChange(String text) async {
    var contactBox = Hive.box<UserData>('UserData1');
    String searchedText = text.trim();
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    contactBox.values.forEach((element) {
      if (element.userName.toLowerCase().contains(searchedText.toLowerCase())) {
        setState(() {
          _searchResult.add(element);
        });
      }
    });
  }

  void onDismiss(UserData res) {
    showDialog(
        context: context,
        builder: (_) => Dialog(
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors: [Colors.white, Colors.blue[100], Colors.red[100]],
                )),
                height: 200,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(S.of(context).areYouSure,
                          style: TextStyle(fontSize: 30)),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              child: Text(S.of(context).yes,
                                  style: TextStyle(fontSize: 25)),
                              onPressed: () {
                                Navigator.of(context).pop();
                                res.delete();
                                setState(() {
                                  if (currentUser == res) {
                                    currentUser = null;
                                    clearCurrentUser();
                                  }
                                });
                              },
                            ),
                            TextButton(
                              child: Text(S.of(context).cancel,
                                  style: TextStyle(fontSize: 25)),
                              onPressed: () {
                                Navigator.of(context).pop();
                                setState(() {});
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
