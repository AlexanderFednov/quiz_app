import 'package:equatable/equatable.dart';
import 'package:quiz_app/models/hive_user_data.dart';

enum UserListStatus { searchNotStarted, searchInProgress, searchCompleted }

class UserListModel extends Equatable {
  final List<UserData>? userList;
  final List<UserData>? searchResultList;
  final UserListStatus? userListStatus;

  UserListModel({
    this.userList = const [],
    this.searchResultList = const [],
    this.userListStatus = UserListStatus.searchNotStarted,
  });

  UserListModel copyWith({
    List<UserData>? userList,
    List<UserData>? searchResultList,
    UserListStatus? userListStatus,
  }) {
    return UserListModel(
      userList: userList ?? this.userList,
      searchResultList: searchResultList ?? this.searchResultList,
      userListStatus: userListStatus ?? this.userListStatus,
    );
  }

  @override
  List<Object?> get props => [
        userList,
        searchResultList,
        userListStatus,
      ];
}
