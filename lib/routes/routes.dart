import 'package:flutter/material.dart';
import 'package:quiz_app/leaderboard/leaderboard_widget.dart';
import 'package:quiz_app/main.dart';
import 'package:quiz_app/registration/registration_widget.dart';
import 'package:quiz_app/user_information/user_information_widget.dart';
import 'package:quiz_app/user_list/user_list_widget.dart';

class RouteGenerator {
  static const appScaffold = 'mainPage';
  static const leaderboard = 'leaderboard';
  static const userList = 'userList';
  static const userInformation = 'userInformation ';
  static const registrationScreen = 'registration';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case appScaffold:
        return MaterialPageRoute(
          builder: (_) => const QuizAppScaffold(),
        );

      case leaderboard:
        return MaterialPageRoute(
          builder: (_) => const LeaderBoardWidget(),
        );

      case userList:
        return MaterialPageRoute(
          builder: (_) => const UserListWidget(),
        );

      case userInformation:
        return MaterialPageRoute(
          builder: (_) => const UserInformationWidget(),
        );

      case registrationScreen:
        return MaterialPageRoute(
          builder: (_) => const RegistrationScreenWidget(),
        );

      default:
        throw 'This way is not exist';
    }
  }
}
