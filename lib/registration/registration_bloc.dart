import 'package:easy_dispose/easy_dispose.dart';
import 'package:hive/hive.dart';
import 'package:quiz_app/registration/models/hive_user_data.dart';
import 'package:quiz_app/registration/registration_model.dart';
import 'package:quiz_app/user_list/user_list_bloc.dart';
import 'package:rxdart/rxdart.dart';

class RegistrationBloc extends DisposableOwner {
  RegistrationBloc({this.userListBloc}) {
    _registrationStateSubject.disposeWith(this);
  }

  final UserListBloc? userListBloc;

  static final RegistrationModel _registrationModel = RegistrationModel();

  final BehaviorSubject<RegistrationModel> _registrationStateSubject =
      BehaviorSubject.seeded(_registrationModel);

  RegistrationModel get registrationState => _registrationStateSubject.value;

  String get userName => registrationState.userName;

  Stream<RegistrationErrorText> get registrationErrorStream =>
      _registrationStateSubject.stream.map(
        (registrationStateSubject) =>
            registrationStateSubject.registrationErrorText,
      );

  Stream<bool> get isRegistrationValidStream => _registrationStateSubject.stream
      .map(
        (registrationStateSubject) =>
            registrationStateSubject.isRegistrationValid,
      )
      .distinct();

  void onUserNameChanged(String text) {
    var contactsBox = Hive.box<UserData>('UserData1');

    _registrationStateSubject.add(
      registrationState.copyWith(userName: text.trim()),
    );

    if (userName.isEmpty ||
        userName == '' ||
        contactsBox.values.any((element) => element.userName == userName)) {
      _registrationStateSubject.add(
        registrationState.copyWith(isRegistrationValid: false),
      );
    } else {
      _registrationStateSubject.add(
        registrationState.copyWith(isRegistrationValid: true),
      );
    }
  }

  void onRegistrationSubmit() {
    var contactsBox = Hive.box<UserData>('UserData1');

    if (userName.trim().isEmpty || userName.trim() == '') {
      _registrationStateSubject.add(
        registrationState.copyWith(
          registrationErrorText: RegistrationErrorText.nameIsEmpty,
        ),
      );
    } else if (contactsBox.values
        .any((element) => element.userName == userName)) {
      _registrationStateSubject.add(
        registrationState.copyWith(
          registrationErrorText: RegistrationErrorText.nameIsTaken,
        ),
      );
    } else {
      contactsBox.add(UserData(
        userName: userName,
        userResult: 0,
        registerDate: DateTime.now(),
        userResults: [],
        isCurrentUser: false,
      ));

      userListBloc!.getUserList();
    }
  }

  void registrationReset() {
    _registrationStateSubject.add(
      registrationState.copyWith(
        userName: '',
        registrationErrorText: RegistrationErrorText.nullable,
      ),
    );
  }
}
