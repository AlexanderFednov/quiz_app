import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
// import 'package:quiz_app/bloc/current_user_class.dart';
import 'package:quiz_app/current_user/current_user_bloc.dart';
import 'package:quiz_app/generated/l10n.dart';
import 'package:quiz_app/models/hive_user_data.dart';
import 'package:quiz_app/registration/registration_widget.dart';
import 'package:quiz_app/user_list/user_list_bloc.dart';
import 'package:quiz_app/user_list/user_list_model.dart';
import 'package:quiz_app/user_information/user_information_bloc.dart';
import 'package:quiz_app/user_information/user_information_widget.dart';

class UserListWidget extends StatelessWidget {
  const UserListWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).userList),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: const _UserListWidgetBody(),
      floatingActionButton: FloatingActionButton(
        tooltip: S.of(context).addNewUser,
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const RegistrationScreenWidget(),
          ),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}

class _UserListWidgetBody extends StatelessWidget {
  const _UserListWidgetBody();

  @override
  Widget build(BuildContext context) {
    var currentUserBloc = Provider.of<CurrentUserBloc>(context);
    var userListBloc = Provider.of<UserListBloc>(context);

    return StreamBuilder<List<UserData>?>(
      stream: userListBloc.searchResultListStream,
      initialData: [],
      builder: (context, snapshot) {
        var searchResultList = snapshot.data;

        return StreamBuilder<UserData?>(
          stream: currentUserBloc.currentuserStream,
          builder: (context, snapshot) {
            var currentUser = snapshot.data;

            return Column(
              children: [
                if (currentUser != null)
                  Provider.value(
                    value: currentUser,
                    child: const _ShowCurrentUserWidget(),
                  ),
                const _SearchBarWidget(),
                if (searchResultList!.isNotEmpty)
                  Flexible(
                    flex: 1,
                    child: const _SearchResultListWidget(),
                  ),
                Flexible(
                  flex: 1,
                  child: const _UserListViewWidget(),
                ),
                _NullifyUserListButtonWidget(),
              ],
            );
          },
        );
      },
    );
  }
}

class _ShowCurrentUserWidget extends StatelessWidget {
  const _ShowCurrentUserWidget();

  @override
  Widget build(BuildContext context) {
    var currentUser = Provider.of<UserData>(context);

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
                currentUser.userName!,
                style: TextStyle(fontSize: 30),
              ),
              Text(
                currentUser.userResults!.isEmpty
                    ? '0/0'
                    : '${currentUser.userResults![0].score}/${currentUser.userResults![0].questionsLenght}',
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
  const _SearchBarWidget();

  @override
  State<StatefulWidget> createState() {
    return _SearchBarWidgetState();
  }
}

class _SearchBarWidgetState extends State<_SearchBarWidget> {
  _SearchBarWidgetState() {
    _focus.addListener(() {
      if (!_focus.hasFocus) {
        _cancelButton();
      }
      setState(() {
        null;
      });
    });
  }

  @override
  void dispose() {
    _focus.dispose();
    _cont.dispose();
    super.dispose();
  }

  final FocusNode _focus = FocusNode();
  final TextEditingController _cont = TextEditingController();

  void _cancelButton() {
    var userListBloc = Provider.of<UserListBloc>(context, listen: false);

    userListBloc.searchResultClear();

    setState(() {
      FocusScope.of(context).unfocus();
      _cont.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    var userListBloc = Provider.of<UserListBloc>(context);

    userListBloc.userListStatusStream.listen((userListStatus) {
      if (userListStatus == UserListStatus.searchCompleted) {
        _cancelButton();
      }
    });

    return Container(
      color: _focus.hasFocus ? Theme.of(context).primaryColor : Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: ListTile(
            leading: Icon(
              Icons.search,
              color: _focus.hasFocus ? Colors.blue[700] : Colors.grey,
            ),
            title: TextField(
              focusNode: _focus,
              controller: _cont,
              // inputFormatters: [
              //   FilteringTextInputFormatter(' ', allow: false)
              // ],
              autofocus: false,
              onChanged: (text) {
                userListBloc.onSearchChange(text);
              },
              decoration: InputDecoration(
                hintText: S.of(context).search,
                border: InputBorder.none,
              ),
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.cancel,
                color: _focus.hasFocus ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                _cancelButton();
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _SearchResultListWidget extends StatelessWidget {
  const _SearchResultListWidget();

  static final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var userListBloc = Provider.of<UserListBloc>(context);

    return StreamBuilder<List<UserData>?>(
      stream: userListBloc.searchResultListStream,
      initialData: userListBloc.userListState.searchResultList,
      builder: (context, snapshot) {
        var searchResultList = snapshot.data;

        return Scrollbar(
          controller: _scrollController,
          thickness: 10,
          radius: Radius.circular(8),
          isAlwaysShown: true,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            controller: _scrollController,
            shrinkWrap: true,
            itemCount: searchResultList!.length,
            itemBuilder: (context, index) {
              var _foundUser = searchResultList[index];

              return Provider.value(
                value: _foundUser,
                child: const _SearchResultListTile(),
              );
            },
          ),
        );
      },
    );
  }
}

class _SearchResultListTile extends StatelessWidget {
  const _SearchResultListTile();

  @override
  Widget build(BuildContext context) {
    var userListBloc = Provider.of<UserListBloc>(context);
    var userInformationBloc = Provider.of<UserInformationBloc>(context);
    var foundUser = Provider.of<UserData>(context);

    return ListTile(
      title: Text(
        foundUser.userName!,
        style: TextStyle(fontSize: 20),
      ),
      leading: IconButton(
        icon: Icon(Icons.info_rounded, color: Colors.blue),
        onPressed: () {
          userInformationBloc.selectUser(user: foundUser);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const UserInformationWidget(),
            ),
          );
        },
      ),
      onTap: () {
        userListBloc.searchComplete(user: foundUser);
      },
    );
  }
}

class _UserListViewWidget extends StatelessWidget {
  const _UserListViewWidget();

  static final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var usersListBloc = Provider.of<UserListBloc>(context);

    return StreamBuilder<List<UserData>?>(
      stream: usersListBloc.userListStream,
      initialData: usersListBloc.userListState.userList,
      builder: (context, snapshot) {
        var usersList = snapshot.data;

        if (usersList!.isEmpty) {
          return Center(
            child: Text(S.of(context).userListEmpty),
          );
        }

        return Scrollbar(
          controller: _scrollController,
          thickness: 7,
          isAlwaysShown: true,
          radius: Radius.circular(15),
          child: ListView.builder(
            controller: _scrollController,
            itemCount: usersList.length,
            itemBuilder: (context, index) {
              var user = usersList[index];

              return Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) {
                  _onDismiss(context: context, user: user);
                },
                child: Provider.value(
                  value: user,
                  child: _UserListTileWidget(),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _onDismiss({required BuildContext context, required UserData user}) {
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
                      Provider.value(
                        value: user,
                        child: const _OnDismissTextButtonYesWidget(),
                      ),
                      const _OnDismissTextButtonNoWidget(),
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
}

class _UserListTileWidget extends StatelessWidget {
  const _UserListTileWidget();

  @override
  Widget build(BuildContext context) {
    var usersListBloc = Provider.of<UserListBloc>(context);
    var user = Provider.of<UserData>(context);

    return ListTile(
      title: Text(
        user.userName!,
        style: TextStyle(fontSize: 20),
      ),
      trailing: Provider.value(
        value: user,
        child: _UserListTileTrailingWidget(),
      ),
      leading: user.isCurrentUser!
          ? Icon(
              Icons.check_box,
              color: Colors.green,
            )
          : Icon(Icons.check_box_outline_blank),
      onTap: () {
        usersListBloc.selectCurrentUser(user);
      },
    );
  }
}

class _UserListTileTrailingWidget extends StatelessWidget {
  const _UserListTileTrailingWidget();

  @override
  Widget build(BuildContext context) {
    var userInformationBloc = Provider.of<UserInformationBloc>(context);
    var user = Provider.of<UserData>(context);

    return Container(
      height: 40,
      width: 110,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            user.userResults!.isNotEmpty
                ? '${user.rightAnswersPercentAll.toStringAsFixed(1)} %'
                : '0 %',
            style: TextStyle(fontSize: 15),
          ),
          IconButton(
            icon: Icon(
              Icons.info_rounded,
              color: Colors.blue,
            ),
            onPressed: () {
              userInformationBloc.selectUser(user: user);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const UserInformationWidget(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _OnDismissTextButtonYesWidget extends StatelessWidget {
  const _OnDismissTextButtonYesWidget();

  @override
  Widget build(BuildContext context) {
    var usersListBloc = Provider.of<UserListBloc>(context);
    var user = Provider.of<UserData>(context);

    return TextButton(
      onPressed: () {
        usersListBloc.deleteUser(user);
        Navigator.of(context).pop();
      },
      child: Text(
        S.of(context).yes,
        style: TextStyle(fontSize: 25),
      ),
    );
  }
}

class _OnDismissTextButtonNoWidget extends StatelessWidget {
  const _OnDismissTextButtonNoWidget();

  @override
  Widget build(BuildContext context) {
    var usersListBloc = Provider.of<UserListBloc>(context);

    return TextButton(
      onPressed: () {
        Navigator.of(context).pop();
        usersListBloc.getUserList();
      },
      child: Text(
        S.of(context).cancel,
        style: TextStyle(fontSize: 25),
      ),
    );
  }
}

class _NullifyUserListButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => _onNullifyPress(context),
      child: Text(
        S.of(context).nullify,
      ),
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
          child: Center(
            child: const _NullifyUserListDialogCollumnWidget(),
          ),
        ),
      ),
    );
  }
}

class _NullifyUserListDialogCollumnWidget extends StatelessWidget {
  const _NullifyUserListDialogCollumnWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
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
              const _NullifyUserListDialogButtonYesWidget(),
              const _NullifyUserListDialogButtonNoWidget(),
            ],
          ),
        ),
      ],
    );
  }
}

class _NullifyUserListDialogButtonYesWidget extends StatelessWidget {
  const _NullifyUserListDialogButtonYesWidget();

  @override
  Widget build(BuildContext context) {
    var userListBloc = Provider.of<UserListBloc>(context);

    return TextButton(
      onPressed: () {
        _cancelDialog(context);
        userListBloc.nullifyUserList();
      },
      child: Text(
        S.of(context).yes,
        style: TextStyle(fontSize: 25),
      ),
    );
  }

  void _cancelDialog(BuildContext context) {
    Navigator.of(context).pop();
  }
}

class _NullifyUserListDialogButtonNoWidget extends StatelessWidget {
  const _NullifyUserListDialogButtonNoWidget();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: Text(
        S.of(context).cancel,
        style: TextStyle(fontSize: 25),
      ),
    );
  }
}
