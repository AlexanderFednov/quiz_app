import 'package:equatable/equatable.dart';
import 'package:quiz_app/registration/models/hive_user_data.dart';

enum RegistrationErrorText { nullable, nameIsEmpty, nameIsTaken }

class RegistrationModel extends Equatable {
  final String userName;
  final RegistrationErrorText registrationErrorText;
  final bool isRegistrationValid;
  final List<UserResult> userResults;

  RegistrationModel({
    this.userName = '',
    this.registrationErrorText = RegistrationErrorText.nullable,
    this.isRegistrationValid = false,
    this.userResults = const [],
  });

  RegistrationModel copyWith({
    String? userName,
    RegistrationErrorText? registrationErrorText,
    bool? isRegistrationValid,
    List<UserResult>? userResults,
  }) {
    return RegistrationModel(
      userName: userName ?? this.userName,
      registrationErrorText:
          registrationErrorText ?? this.registrationErrorText,
      isRegistrationValid: isRegistrationValid ?? this.isRegistrationValid,
      userResults: userResults ?? this.userResults,
    );
  }

  @override
  List<Object?> get props => [
        userName,
        registrationErrorText,
        isRegistrationValid,
        userResults,
      ];
}
