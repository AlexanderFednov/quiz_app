import 'package:equatable/equatable.dart';
import 'package:quiz_app/models/hive_user_data.dart';

class UserInformationModel extends Equatable {
  final UserData? selectedUser;

  UserInformationModel({this.selectedUser});

  UserInformationModel copyWith({UserData? selectedUser}) {
    return UserInformationModel(
      selectedUser: selectedUser ?? this.selectedUser,
    );
  }

  @override
  List<Object?> get props => [selectedUser];
}
