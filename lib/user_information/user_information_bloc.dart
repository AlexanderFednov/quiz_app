import 'package:easy_dispose/easy_dispose.dart';
import 'package:quiz_app/models/hive_user_data.dart';
import 'package:quiz_app/user_information/user_information_model.dart';
import 'package:rxdart/subjects.dart';

class UserInformationBloc extends DisposableOwner {
  UserInformationBloc() {
    _userInformationStateSubject.disposeWith(this);
  }

  static final UserInformationModel _userInformationModel =
      UserInformationModel();

  final BehaviorSubject<UserInformationModel> _userInformationStateSubject =
      BehaviorSubject.seeded(_userInformationModel);

  UserInformationModel get userInformationState =>
      _userInformationStateSubject.value;

  Stream<UserData> get selectedUserStream => _userInformationStateSubject.stream
      .map((userInformationModel) => userInformationModel.selectedUser!);

  UserData? get selectedUser => userInformationState.selectedUser;

  void selectUser({required UserData user}) {
    _userInformationStateSubject.add(
      userInformationState.copyWith(
        selectedUser: user,
      ),
    );
  }

  void deleteUserResults() {
    selectedUser!.userResults!.clear();
    selectedUser!.userResult = 0;
    selectedUser!.save();

    _userInformationStateSubject.add(
      userInformationState,
    );
  }
}
