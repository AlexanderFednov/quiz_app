import 'package:easy_dispose/easy_dispose.dart';
import 'package:hive/hive.dart';
import 'package:quiz_app/current_user/current_user_model.dart';
import 'package:quiz_app/registration/models/hive_user_data.dart';
import 'package:rxdart/subjects.dart';

class CurrentUserBloc extends DisposableOwner {
  CurrentUserBloc({required this.hiveBox}) {
    getCurrentUser();

    _currentUserStateSubject.disposeWith(this);
  }

  final Box<UserData> hiveBox;

  static final CurrentUserModel _currentUserModel = CurrentUserModel();

  final BehaviorSubject<CurrentUserModel> _currentUserStateSubject =
      BehaviorSubject.seeded(_currentUserModel);

  CurrentUserModel get currentUserState => _currentUserStateSubject.value;

  Stream<UserData?> get currentuserStream => _currentUserStateSubject
      .map((currentUserModel) => currentUserModel.currentUser);

  UserData? get currentUser => currentUserState.currentUser;

  void getCurrentUser() {
    // var contactsBox = Hive.box<UserData>('UserData1');
    if (hiveBox.isNotEmpty) {
      hiveBox.values.forEach((element) {
        if (element.isCurrentUser) {
          _currentUserStateSubject.add(
            currentUserState.copyWith(
              currentUser: element,
            ),
          );
        }
      });
    }
  }

  // void setCurrentUser() {
  //   var contactsBox = Hive.box<UserData>('UserData1');

  //   if (contactsBox.isNotEmpty) {
  //     contactsBox.values.forEach((element) {
  //       if (element.isCurrentUser!) {
  //         _currentUserStateSubject.add(
  //           currentUserState.copyWith(
  //             currentUser: element,
  //           ),
  //         );
  //       }
  //     });
  //   }
  // }

  void clearCurrentUser() {
    _currentUserStateSubject.add(
      currentUserState.copyWith(
        currentUser: null,
      ),
    );
  }
}
