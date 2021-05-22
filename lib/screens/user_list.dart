import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
//import 'package:intl/intl.dart';
import 'package:quiz_app/screens/add_user.dart';
import '../models/hive_user_data.dart';
import '../screens/user_Information.dart';
import '../generated/l10n.dart';

class UserList extends StatefulWidget {
  final Function setCurrentUser;
  final Function clearCurrentUser;
  UserList({@required this.setCurrentUser, @required this.clearCurrentUser});

  @override
  State<StatefulWidget> createState() {
    return UserListState(
      setCurrentUser: setCurrentUser,
      clearCurrentUser: clearCurrentUser,
    );
  }
}

class UserListState extends State<UserList> {
  UserData currentUser;

  Function setCurrentUser;
  Function clearCurrentUser;

  TextEditingController cont = TextEditingController();

  List searchResult = [];

  String searchText;

  final FocusNode focus = FocusNode();

  UserListState({
    @required this.setCurrentUser,
    @required this.clearCurrentUser,
  });

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
              Flexible(
                flex: 0,
                child: ShowCurrentUserWidget(
                  currentUser: currentUser,
                ),
              ),
            Flexible(
              flex: 0,
              child: SearchBarWidget(
                cont: cont,
                focus: focus,
                onSearchChange: _onSearchChange,
                searchResult: searchResult,
                cancelButton: _cancelButton,
              ),
            ),
            if (searchResult.isNotEmpty)
              Expanded(
                flex: 1,
                child: SearchResultListWidget(
                  cont: cont,
                  setCurrentUser: setCurrentUser,
                  currentUser: currentUser,
                  searchResult: searchResult,
                  searchResultListTap: _searchResultTap,
                ),
              ),
            Flexible(
              flex: 1,
              child: UserListWidget(
                onDismiss: _onDismiss,
                onUserListTileTap: _onUserListTileTap,
              ),
            ),
            TextButton(
              onPressed: _onNullifyPress,
              child: Text(
                S.of(context).nullify,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: S.of(context).addNewUser,
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AddUser(),
          ),
        ),
        child: Icon(Icons.add),
      ),
    );
  }

  void _deleteData() async {
    var contactsBox = Hive.box<UserData>('UserData1');
    setState(() {
      contactsBox.clear();
      currentUser = null;
      clearCurrentUser();
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

  void _getCurrentUser() {
    var contactsBox = Hive.box<UserData>('UserData1');
    if (contactsBox.isNotEmpty) {
      contactsBox.values.forEach((element) {
        if (element.isCurrentUser) {
          currentUser = element;
        }
      });
    } else {
      currentUser = null;
    }
  }

  @override
  void initState() {
    super.initState();

    _getCurrentUser();
    focus.addListener(() {
      setState(() {
        null;
      });
    });
  }

  void _onSearchChange(String text) async {
    var contactBox = Hive.box<UserData>('UserData1');
    var searchedText = text.trim();
    setState(() {
      searchResult.clear();
    });
    if (text.isEmpty) {
      setState(() {
        null;
      });

      return;
    }
    contactBox.values.forEach((element) {
      if (element.userName.toLowerCase().contains(searchedText.toLowerCase())) {
        setState(() {
          searchResult.add(element);
        });
      }
    });
  }

  void _onDismiss(UserData res) {
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
                      _onDismissTextButtonYes(context, res),
                      _onDismissTextButtonNo(context, res),
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

  void _cancelButton() {
    setState(() {
      cont.clear();
      searchResult = [];
      FocusScope.of(context).unfocus();
    });
  }

  void _searchResultTap(int index) {
    setState(() {
      Hive.box<UserData>('UserData1').values.forEach((element) {
        element.isCurrentUser = false;
        element.save();
      });
      Hive.box<UserData>('UserData1').values.forEach((element) {
        if (element.userName.contains(searchResult[index].userName)) {
          element.isCurrentUser = true;
          element.save();
          currentUser = element;
        }
      });
      searchResult = [];
      cont.clear();
      setCurrentUser();
      FocusScope.of(context).unfocus();
    });
  }

  void _onUserListTileTap(UserData res, Box<UserData> box) async {
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
  }

  Widget _onDismissTextButtonYes(BuildContext context, UserData res) {
    return TextButton(
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
      child: Text(
        S.of(context).yes,
        style: TextStyle(fontSize: 25),
      ),
    );
  }

  Widget _onDismissTextButtonNo(BuildContext context, UserData res) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop();
        setState(() {
          null;
        });
      },
      child: Text(
        S.of(context).cancel,
        style: TextStyle(fontSize: 25),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class ShowCurrentUserWidget extends StatefulWidget {
  final UserData currentUser;

  ShowCurrentUserWidget({@required this.currentUser});

  @override
  State<StatefulWidget> createState() {
    return ShowCurrentUserWidgetState();
  }
}

class ShowCurrentUserWidgetState extends State<ShowCurrentUserWidget> {
  // UserData currentUser;
  // Function currentUserChange;

  // ShowCurrentUserWidgetState({@required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(12),
      ),
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
              Text(
                widget.currentUser.userName,
                style: TextStyle(fontSize: 30),
              ),
              Text(
                widget.currentUser.userResults.isEmpty
                    ? '0/0'
                    : '${widget.currentUser.userResults[0].score}/${widget.currentUser.userResults[0].questionsLenght}',
                style: TextStyle(fontSize: 30),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SearchBarWidget extends StatefulWidget {
  final cont;
  final focus;
  final onSearchChange;
  final cancelButton;
  final searchResult;

  SearchBarWidget({
    @required this.cont,
    @required this.focus,
    @required this.onSearchChange,
    @required this.searchResult,
    @required this.cancelButton,
  });

  @override
  State<StatefulWidget> createState() {
    return SearchBarWidgetState(
      cont: cont,
      focus: focus,
      onSearchChange: onSearchChange,
      searchResult: searchResult,
      cancelButton: cancelButton,
    );
  }
}

class SearchBarWidgetState extends State<SearchBarWidget> {
  TextEditingController cont;
  FocusNode focus;
  Function onSearchChange;
  Function cancelButton;
  List searchResult;

  SearchBarWidgetState({
    @required this.cont,
    @required this.focus,
    @required this.onSearchChange,
    @required this.searchResult,
    @required this.cancelButton,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: focus.hasFocus ? Theme.of(context).primaryColor : Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: ListTile(
            leading: Icon(
              Icons.search,
              color: focus.hasFocus ? Colors.blue[700] : Colors.grey,
            ),
            title: TextField(
              focusNode: focus,
              // inputFormatters: [
              //   FilteringTextInputFormatter(' ', allow: false)
              // ],
              autofocus: false,
              controller: cont,
              onChanged: (value) {
                setState(() {
                  onSearchChange(value);
                });
              },
              decoration: InputDecoration(
                hintText: S.of(context).search,
                border: InputBorder.none,
              ),
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.cancel,
                color: focus.hasFocus ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                cancelButton();
              },
            ),
          ),
        ),
      ),
    );
  }
}

class SearchResultListWidget extends StatelessWidget {
  final searchResult;
  final currentUser;
  final cont;
  final setCurrentUser;
  final searchResultListTap;

  SearchResultListWidget({
    @required this.cont,
    @required this.currentUser,
    @required this.searchResult,
    @required this.setCurrentUser,
    @required this.searchResultListTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: searchResult.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            searchResult[index].userName,
            style: TextStyle(fontSize: 20),
          ),
          leading: IconButton(
            icon: Icon(Icons.info_rounded, color: Colors.blue),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => UserInformation(
                  user: searchResult[index],
                ),
              ),
            ),
          ),
          onTap: () {
            searchResultListTap(index);
          },
        );
      },
    );
  }
}

class UserListTileWidget extends StatelessWidget {
  final UserData res;
  final Box<UserData> box;
  final onUserListTileTap;

  UserListTileWidget({
    @required this.res,
    @required this.box,
    @required this.onUserListTileTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
              style: TextStyle(fontSize: 15),
            ),
            IconButton(
              icon: Icon(
                Icons.info_rounded,
                color: Colors.blue,
              ),
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => UserInformation(user: res),
              )),
            ),
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
      onTap: () {
        onUserListTileTap(res, box);
      },
    );
  }
}

class UserListWidget extends StatelessWidget {
  final onDismiss;
  final onUserListTileTap;

  UserListWidget({@required this.onDismiss, @required this.onUserListTileTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ValueListenableBuilder(
        valueListenable: Hive.box<UserData>('UserData1').listenable(),
        builder: (context, Box<UserData> box, _) {
          if (box.values.isEmpty) {
            return Center(
              child: Text(S.of(context).userListEmpty),
            );
          }
          var userData = Hive.box<UserData>('UserData1').values.toList();
          userData.sort((a, b) => a.userName.compareTo(b.userName));

          return ListView.builder(
            itemCount: userData.length,
            itemBuilder: (context, index) {
              var res = userData[index];
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
                child: UserListTileWidget(
                  box: box,
                  res: res,
                  onUserListTileTap: onUserListTileTap,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
