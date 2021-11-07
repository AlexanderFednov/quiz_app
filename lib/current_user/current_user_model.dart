import 'package:equatable/equatable.dart';
import 'package:quiz_app/registration/models/hive_user_data.dart';

class CurrentUserModel extends Equatable {
  final UserData? currentUser;

  CurrentUserModel({this.currentUser});

  CurrentUserModel copyWith({UserData? currentUser}) {
    return CurrentUserModel(
      currentUser: currentUser ?? currentUser,
    );
  }

  @override
  List<Object?> get props => [
        currentUser,
      ];
}
