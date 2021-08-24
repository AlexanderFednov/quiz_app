import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/generated/l10n.dart';
import 'package:quiz_app/screens/registration/registration_bloc.dart';

class RegistrationWidget extends StatelessWidget {
  const RegistrationWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _RegistrationWidgetHeading(),
                const _RegistrationWidgetUserNameTextField(),
                Row(
                  children: [
                    const _RegistrationWidgetAddUserButton(),
                    const _RegistrationWidgetCancelButton()
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RegistrationWidgetHeading extends StatelessWidget {
  const _RegistrationWidgetHeading();

  @override
  Widget build(BuildContext context) {
    return Text(
      S.of(context).newUser,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    );
  }
}

class _RegistrationWidgetUserNameTextField extends StatelessWidget {
  const _RegistrationWidgetUserNameTextField();

  @override
  Widget build(BuildContext context) {
    var registrationBloc = Provider.of<RegistrationBloc>(context);

    return StreamBuilder<RegistrationErrorText>(
        stream: registrationBloc.registrationErrorStream,
        builder: (context, snapshot) {
          var registrationErrorText = snapshot.data;

          return TextField(
            autofocus: true,
            decoration: InputDecoration(
              labelText: S.of(context).userName,
              errorStyle: TextStyle(color: Colors.red),
              errorText: errorText(context, registrationErrorText),
            ),
            onChanged: (text) {
              registrationBloc.onUserNameChanged(text);
            },
            // inputFormatters: [
            //   FilteringTextInputFormatter(' ', allow: false)
            // ],
          );
        });
  }

  String errorText(BuildContext context, RegistrationErrorText errorText) {
    switch (errorText) {
      case RegistrationErrorText.nameIsEmpty:
        return S.of(context).enterName;
        break;

      case RegistrationErrorText.nameIsTaken:
        return S.of(context).nameIsTaken;
        break;

      case RegistrationErrorText.nullable:
      default:
        return null;
    }
  }
}

class _RegistrationWidgetCancelButton extends StatelessWidget {
  const _RegistrationWidgetCancelButton();

  @override
  Widget build(BuildContext context) {
    var registrationBloc = Provider.of<RegistrationBloc>(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
          FocusScope.of(context).unfocus();
          registrationBloc.registrationReset();
        },
        child: Text(S.of(context).cancel),
      ),
    );
  }
}

class _RegistrationWidgetAddUserButton extends StatelessWidget {
  const _RegistrationWidgetAddUserButton();

  @override
  Widget build(BuildContext context) {
    var registrationBloc = Provider.of<RegistrationBloc>(context);

    return StreamBuilder<bool>(
        stream: registrationBloc.isRegistrationValidStream,
        builder: (context, snapshot) {
          var isValid = snapshot.data;

          return ElevatedButton(
            onPressed: () {
              registrationBloc.onRegistrationSubmit();

              if (isValid) {
                Navigator.of(context).pop();
                FocusScope.of(context).unfocus();
                registrationBloc.registrationReset();
              }
            },
            child: Text(S.of(context).addUser),
          );
        });
  }
}
