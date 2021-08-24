import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/bloc/current_user_class.dart';
//import 'package:intl/intl.dart';
import 'package:quiz_app/screens/add_user.dart';
import 'package:quiz_app/screens/registration/registration_widget.dart';
import '../models/hive_user_data.dart';
import '../screens/user_Information.dart';
import '../generated/l10n.dart';

class UserList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UserListState();
  }
}

class UserListState extends State<UserList> {
  TextEditingController cont = TextEditingController();

  List searchResult = [];

  String searchText;

  final FocusNode focus = FocusNode();

  List<UserData> userData = [];

  @override
  Widget build(BuildContext context) {
    var currentUserClass = Provider.of<CurrentUserClass>(context);
    var currentUser = currentUserClass.currentUser;
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
                child: _ShowCurrentUserWidget(),
              ),
            Flexible(
              flex: 0,
              child: _SearchBarWidget(
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
                child: _SearchResultListWidget(
                  cont: cont,
                  searchResult: searchResult,
                  searchResultListTap: _searchResultTap,
                ),
              ),
            Flexible(
              flex: 1,
              child: _UsersListWidget(
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
            builder: (context) => RegistrationWidget(),
          ),
        ),
        child: Icon(Icons.add),
      ),
    );
  }

  void _deleteData() async {
    var currentUserClass = Provider.of<CurrentUserClass>(context);
    var contactsBox = Hive.box<UserData>('UserData1');
    setState(() {
      contactsBox.clear();
      currentUserClass.clearCurrentUser();
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

  // void _getCurrentUser() {
  //   var contactsBox = Hive.box<UserData>('UserData1');
  //   if (contactsBox.isNotEmpty) {
  //     contactsBox.values.forEach((element) {
  //       if (element.isCurrentUser) {
  //         currentUser = element;
  //       }
  //     });
  //   } else {
  //     currentUser = null;
  //   }
  // }

  @override
  void initState() {
    super.initState();

    // _getCurrentUser();
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
    var currentUserClass =
        Provider.of<CurrentUserClass>(context, listen: false);

    setState(() {
      Hive.box<UserData>('UserData1').values.forEach((element) {
        element.isCurrentUser = false;
        element.save();
      });
      Hive.box<UserData>('UserData1').values.forEach((element) {
        if (element.userName.contains(searchResult[index].userName)) {
          element.isCurrentUser = true;
          element.save();
          // currentUserClass.setCurrentUser();
        }
      });
      searchResult = [];
      cont.clear();
      currentUserClass.setCurrentUser();
      FocusScope.of(context).unfocus();
    });
  }

  void _onUserListTileTap(UserData res, Box<UserData> box) async {
    var currentUserClass =
        Provider.of<CurrentUserClass>(context, listen: false);

    setState(() {
      box.values.forEach((element) {
        element.isCurrentUser = false;
        element.save();
      });
      res.isCurrentUser = true;
      // res.userId = index;

      //currentUser.userId = index;
      res.save();
      currentUserClass.setCurrentUser();
      // currentUserClass.getCurrentUser();
    });
  }

  Widget _onDismissTextButtonYes(BuildContext context, UserData res) {
    var currentUserClass = Provider.of<CurrentUserClass>(context);
    var currentUser = currentUserClass.currentUser;

    return TextButton(
      onPressed: () {
        Navigator.of(context).pop();
        res.delete();
        setState(() {
          if (currentUser == res) {
            currentUser = null;

            currentUserClass.clearCurrentUser();
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

class _ShowCurrentUserWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var currentUserClass = Provider.of<CurrentUserClass>(context);
    var currentUser = currentUserClass.currentUser;
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
                currentUser.userName,
                style: TextStyle(fontSize: 30),
              ),
              Text(
                currentUser.userResults.isEmpty
                    ? '0/0'
                    : '${currentUser.userResults[0].score}/${currentUser.userResults[0].questionsLenght}',
                style: TextStyle(fontSize: 30),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SearchBarWidget extends StatefulWidget {
  final cont;
  final focus;
  final onSearchChange;
  final cancelButton;
  final searchResult;

  _SearchBarWidget({
    @required this.cont,
    @required this.focus,
    @required this.onSearchChange,
    @required this.searchResult,
    @required this.cancelButton,
  });

  @override
  State<StatefulWidget> createState() {
    return _SearchBarWidgetState(
      cont: cont,
      focus: focus,
      onSearchChange: onSearchChange,
      searchResult: searchResult,
      cancelButton: cancelButton,
    );
  }
}

class _SearchBarWidgetState extends State<_SearchBarWidget> {
  TextEditingController cont;
  FocusNode focus;
  Function onSearchChange;
  Function cancelButton;
  List searchResult;

  _SearchBarWidgetState({
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

class _SearchResultListWidget extends StatelessWidget {
  final searchResult;

  final cont;

  final searchResultListTap;

  _SearchResultListWidget({
    @required this.cont,
    @required this.searchResult,
    @required this.searchResultListTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: searchResult.length,
      itemBuilder: (context, index) {
        return _SearchResultListTile(
          index: index,
          searchResult: searchResult,
          searchResultListTap: searchResultListTap,
        );
      },
    );
  }
}

class _SearchResultListTile extends StatelessWidget {
  final searchResult;
  final index;
  final searchResultListTap;

  _SearchResultListTile({
    @required this.index,
    @required this.searchResult,
    @required this.searchResultListTap,
  });

  @override
  Widget build(BuildContext context) {
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
  }
}

class _UsersListWidget extends StatelessWidget {
  final onDismiss;
  final onUserListTileTap;

  _UsersListWidget(
      {@required this.onDismiss, @required this.onUserListTileTap});

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

          return _UsersListViewWidget(
            onDismiss: onDismiss,
            onUserListTileTap: onUserListTileTap,
            userData: userData,
            box: box,
          );
        },
      ),
    );
  }
}

class _UsersListViewWidget extends StatelessWidget {
  final onDismiss;
  final onUserListTileTap;
  final userData;
  final box;

  _UsersListViewWidget(
      {@required this.onDismiss,
      @required this.onUserListTileTap,
      @required this.userData,
      @required this.box});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: userData.length,
      itemBuilder: (context, index) {
        var res = userData[index];
        res.userId = index;

        return Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) {
            onDismiss(res);
          },
          child: _UserListTileWidget(
            box: box,
            res: res,
            onUserListTileTap: onUserListTileTap,
          ),
        );
      },
    );
  }
}

class _UserListTileWidget extends StatelessWidget {
  final UserData res;
  final Box<UserData> box;
  final onUserListTileTap;

  _UserListTileWidget({
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
      trailing: _UserListTileTrailingWidget(
        res: res,
      ),
      leading: res.isCurrentUser
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

class _UserListTileTrailingWidget extends StatelessWidget {
  final res;

  _UserListTileTrailingWidget({@required this.res});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
