import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/generated/l10n.dart';
import 'package:quiz_app/screens/registration/registration_bloc.dart';
import 'package:quiz_app/screens/registration/registration_model.dart';

class RegistrationScreenWidget extends StatelessWidget {
  const RegistrationScreenWidget();

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
                const _RegistrationScreenWidgetHeading(),
                const _RegistrationScreenWidgetUserNameTextField(),
                Row(
                  children: [
                    const _RegistrationScreenWidgetAddUserButton(),
                    const _RegistrationScreenWidgetCancelButton(),
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

class _RegistrationScreenWidgetHeading extends StatelessWidget {
  const _RegistrationScreenWidgetHeading();

  @override
  Widget build(BuildContext context) {
    return Text(
      S.of(context).newUser,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    );
  }
}

class _RegistrationScreenWidgetUserNameTextField extends StatelessWidget {
  const _RegistrationScreenWidgetUserNameTextField();

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
            errorText: _errorText(context, registrationErrorText),
          ),
          onChanged: (text) {
            registrationBloc.onUserNameChanged(text);
          },
          // inputFormatters: [
          //   FilteringTextInputFormatter(' ', allow: false)
          // ],
        );
      },
    );
  }

  String? _errorText(BuildContext context, RegistrationErrorText? errorText) {
    switch (errorText) {
      case RegistrationErrorText.nameIsEmpty:
        return S.of(context).enterName;

      case RegistrationErrorText.nameIsTaken:
        return S.of(context).nameIsTaken;

      case RegistrationErrorText.nullable:
      default:
        return null;
    }
  }
}

class _RegistrationScreenWidgetCancelButton extends StatelessWidget {
  const _RegistrationScreenWidgetCancelButton();

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

class _RegistrationScreenWidgetAddUserButton extends StatelessWidget {
  const _RegistrationScreenWidgetAddUserButton();

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

            if (isValid!) {
              Navigator.of(context).pop();
              FocusScope.of(context).unfocus();
              registrationBloc.registrationReset();
            }
          },
          child: Text(S.of(context).addUser),
        );
      },
    );
  }
}
