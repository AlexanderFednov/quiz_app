import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/user_information/user_information_bloc.dart';
import 'package:quiz_app/registration/models/hive_user_data.dart';
import 'package:quiz_app/generated/l10n.dart';

class UserInformationWidget extends StatelessWidget {
  const UserInformationWidget();

  @override
  Widget build(BuildContext context) {
    var userInformationBloc = Provider.of<UserInformationBloc>(context);

    return StreamProvider(
      create: (_) => userInformationBloc.selectedUserStream,
      initialData: userInformationBloc.selectedUser,
      updateShouldNotify: (_, __) => true,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text(
            userInformationBloc.selectedUser!.userName!,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: userInformationBloc.selectedUser != null
            ? const _UserInformationBody()
            : null,
      ),
    );
  }
}

class _UserInformationBody extends StatelessWidget {
  const _UserInformationBody();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserData>(context);

    return Center(
      child: Column(
        children: [
          const _RegistrationDateWidget(),
          const _UsersLastResultWidget(),
          const _RightAnswersPercentWidget(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                S.of(context).allUserResult,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          user.userResults!.isNotEmpty && user.userResults != null
              ? const _AllUsersResultsWidget()
              : const _UsersResultListIsEmptyWidget(),
          const _NuliffyUserResultsButtonWidget(),
        ],
      ),
    );
  }
}

class _RegistrationDateWidget extends StatelessWidget {
  const _RegistrationDateWidget();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserData>(context);

    return Row(
      children: [
        Text(
          S.of(context).registrationDate,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          '${DateFormat('yyyy-MM-dd (kk:mm)').format(user.registerDate!).toString()}',
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}

class _UsersLastResultWidget extends StatelessWidget {
  const _UsersLastResultWidget();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserData>(context);

    return Row(
      children: [
        Text(
          S.of(context).userLastResult,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          user.userResults!.isEmpty
              ? '0'
              : '${user.userResults![0].score} / ${user.userResults![0].questionsLenght}',
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}

class _RightAnswersPercentWidget extends StatelessWidget {
  const _RightAnswersPercentWidget();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserData>(context);

    return Row(
      children: [
        Text(
          S.of(context).rightAnswersPercent,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          user.userResults!.isEmpty
              ? '0 %'
              : '${user.rightAnswersPercentAll.toStringAsFixed(2)} %',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}

class _AllUsersResultsWidget extends StatelessWidget {
  const _AllUsersResultsWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Scrollbar(
        hoverThickness: 10,
        radius: Radius.circular(10),
        showTrackOnHover: true,
        isAlwaysShown: true,
        thickness: 10,
        child: _AllUserResultsCardWidget(),
      ),
    );
  }
}

class _AllUserResultsCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserData>(context);
    var results = user.userResults;
    results!.sort(
      (b, a) => a.resultDate!.compareTo(b.resultDate!),
    );

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(
              '${results[index].score} / ${results[index].questionsLenght} (${results[index].rightAnswersPercent.toStringAsFixed(1)}%)(${category(context, results[index].category!)}) / ${DateFormat('yyyy-MM-dd (kk:mm)').format(results[index].resultDate!)}',
              style: TextStyle(fontSize: 15),
            ),
          ),
        );
      },
    );
  }

  String category(BuildContext context, Category category) {
    switch (category) {
      case Category.generalQuestions:
        return S.of(context).questionsAll;

      case Category.moviesOfUSSSR:
        return S.of(context).questionsFilms;

      case Category.space:
        return S.of(context).questionsSpace;

      case Category.sector13:
        return S.of(context).questionsWeb;

      default:
        return '';
    }
  }
}

class _UsersResultListIsEmptyWidget extends StatelessWidget {
  const _UsersResultListIsEmptyWidget();

  @override
  Widget build(BuildContext context) {
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
}

class _NuliffyUserResultsButtonWidget extends StatelessWidget {
  const _NuliffyUserResultsButtonWidget();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserData>(context);

    return TextButton(
      onPressed: () => _onNullifyPress(context),
      child: Text(
        S.of(context).nullify,
        style: TextStyle(
          color: user.userResults!.isEmpty
              ? Colors.grey
              : Theme.of(context).primaryColor,
        ),
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
          child: _NullifyUserResultsButtonBodyWidget(),
        ),
      ),
    );
  }
}

class _NullifyUserResultsButtonBodyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            child: _NullifyUserResultsDialogButtonsWidget(),
          ),
        ],
      ),
    );
  }
}

class _NullifyUserResultsDialogButtonsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userinformationBloc = Provider.of<UserInformationBloc>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            userinformationBloc.deleteUserResults();
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
    );
  }
}
