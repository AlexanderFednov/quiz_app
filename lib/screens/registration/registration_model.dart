import 'package:equatable/equatable.dart';
import 'package:quiz_app/models/hive_user_data.dart';

class RegistrationModel extends Equatable {
  final String userName;
  final int userResult;
  final int userId;
  final bool isCurrentUser;
  final DateTime registerDate;
  final List<UserResult> userResults;

  RegistrationModel(
      {this.userName = '',
      this.userResult = 0,
      this.userId = 0,
      this.isCurrentUser = false,
      this.registerDate,
      this.userResults = const []});

  RegistrationModel copyWith(
      {String userName,
      int userResult,
      int userId,
      bool isCurrentUser,
      DateTime registerDate,
      List<UserResult> userResults}) {
    return RegistrationModel(
        userName: userName ?? this.userName,
        userResult: userResult ?? this.userResult,
        userId: userId ?? this.userId,
        isCurrentUser: isCurrentUser ?? this.isCurrentUser,
        registerDate: registerDate ?? this.registerDate,
        userResults: userResults ?? this.userResults);
  }

  @override
  List<Object> get props =>
      [userName, userResult, userId, isCurrentUser, registerDate, userResults];
}
