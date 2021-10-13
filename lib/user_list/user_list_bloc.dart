import 'package:easy_dispose/easy_dispose.dart';
import 'package:hive/hive.dart';
import 'package:quiz_app/current_user/current_user_bloc.dart';
import 'package:quiz_app/models/hive_user_data.dart';
import 'package:quiz_app/user_list/user_list_model.dart';
import 'package:rxdart/rxdart.dart';

class UserListBloc extends DisposableOwner {
  UserListBloc({this.currentUserBloc}) {
    getUserList();

    _usersListStateSubject.disposeWith(this);
  }

  static final UserListModel userListModel = UserListModel();

  final CurrentUserBloc? currentUserBloc;

  final BehaviorSubject<UserListModel> _usersListStateSubject =
      BehaviorSubject.seeded(userListModel);

  Stream<UserListModel> get userListStateStream =>
      _usersListStateSubject.stream;

  UserListModel get userListState => _usersListStateSubject.value;

  Stream<List<UserData>?> get userListStream =>
      userListStateStream.map((usersListState) => usersListState.userList);

  Stream<List<UserData>?> get searchResultListStream => userListStateStream
      .map((usersListState) => usersListState.searchResultList);

  Stream<UserListStatus?> get userListStatusStream => userListStateStream
      .map((usersListState) => usersListState.userListStatus);

  void getUserList() {
    var userListFromDB = Hive.box<UserData>('UserData1').values.toList();

    userListFromDB.sort((a, b) => a.userName!.compareTo(b.userName!));

    _usersListStateSubject.add(
      userListState.copyWith(userList: userListFromDB),
    );
  }

  void deleteUser(UserData user) {
    if (currentUserBloc!.currentUser == user) {
      currentUserBloc!.clearCurrentUser();
    }

    user.delete();
    getUserList();
  }

  void selectCurrentUser(UserData user) {
    var usersListFromDB = Hive.box<UserData>('UserData1').values;

    usersListFromDB.forEach((element) {
      if (element != user) {
        element.isCurrentUser = false;
        element.save();
      } else {
        element.isCurrentUser = true;
        element.save();
      }
    });

    getUserList();
    currentUserBloc!.getCurrentUser();
  }

  void onSearchChange(String text) async {
    var databaseBox = Hive.box<UserData>('UserData1');

    _usersListStateSubject.add(
      userListState.copyWith(
        searchResultList: [],
        userListStatus: UserListStatus.searchInProgress,
      ),
    );

    if (text.isEmpty) {
      _usersListStateSubject.add(
        userListState.copyWith(
          searchResultList: [],
          userListStatus: UserListStatus.searchNotStarted,
        ),
      );

      return;
    }

    if (text.trim().isNotEmpty) {
      var searchResultListTemporary = userListState.searchResultList;

      databaseBox.values.forEach((user) {
        if (user.userName!.toLowerCase().contains(
              text.toLowerCase().trim(),
            )) {
          searchResultListTemporary!.add(user);
        }
      });

      searchResultListTemporary!
          .sort((a, b) => a.userName!.compareTo(b.userName!));

      _usersListStateSubject.add(
        userListState.copyWith(
          searchResultList: searchResultListTemporary,
        ),
      );
    }
  }

  void searchComplete({required UserData user}) {
    selectCurrentUser(user);

    _usersListStateSubject.add(
      userListState.copyWith(userListStatus: UserListStatus.searchCompleted),
    );
  }

  void searchResultClear() {
    _usersListStateSubject.add(
      userListState.copyWith(
        searchResultList: [],
        userListStatus: UserListStatus.searchNotStarted,
      ),
    );
  }

  void nullifyUserList() async {
    var contactsBox = Hive.box<UserData>('UserData1');

    await contactsBox.clear();
    currentUserBloc!.clearCurrentUser();
    getUserList();
  }
}
