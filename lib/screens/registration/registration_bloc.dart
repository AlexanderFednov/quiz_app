import 'package:easy_dispose/easy_dispose.dart';
import 'package:hive/hive.dart';
import 'package:quiz_app/models/hive_user_data.dart';
import 'package:quiz_app/screens/registration/registration_model.dart';
import 'package:rxdart/rxdart.dart';

enum RegistrationErrorText { nullable, nameIsEmpty, nameIsTaken }

class RegistrationBloc extends DisposableOwner {
  static final RegistrationModel registrationModel = RegistrationModel();

  final BehaviorSubject<RegistrationModel> _registrationSubject =
      BehaviorSubject.seeded(registrationModel);

  Stream<RegistrationModel> get registrationStream =>
      _registrationSubject.stream;

  RegistrationModel get registerSubjectValue => _registrationSubject.value;

  String get userName => registerSubjectValue.userName;

  final BehaviorSubject<RegistrationErrorText> _regostrationErrorSubject = BehaviorSubject.seeded(RegistrationErrorText.nullable);

  Stream<RegistrationErrorText> get registrationErrorStream =>
      _regostrationErrorSubject.stream;

  final BehaviorSubject<bool> _isRegistrationValidSubject =
      BehaviorSubject.seeded(false);

  Stream<bool> get isRegistrationValidStream =>
      _isRegistrationValidSubject.stream;

  void onUserNameChanged(String text) {
    var contactsBox = Hive.box<UserData>('UserData1');

    _registrationSubject.add(
      registrationModel.copyWith(userName: text.trim()),
    );

    if (userName.trim().isEmpty ||
        userName.trim() == null ||
        contactsBox.values.any((element) => element.userName == userName)) {
      _isRegistrationValidSubject.add(false);
    } else {
      _isRegistrationValidSubject.add(true);
    }
  }

  void onRegistrationSubmit() {
    var contactsBox = Hive.box<UserData>('UserData1');

    if (userName.trim().isEmpty || userName.trim() == null) {
      _regostrationErrorSubject.add(RegistrationErrorText.nameIsEmpty);
    } else if (contactsBox.values
        .any((element) => element.userName == userName)) {
      _regostrationErrorSubject.add(RegistrationErrorText.nameIsTaken);
    } else {
      contactsBox.add(UserData(
        userName: userName,
        userResult: 0,
        registerDate: DateTime.now(),
        userResults: [],
        userId: 0,
        isCurrentUser: false,
      ));
    }
  }

  void registrationReset() {
    _registrationSubject.add(registrationModel.copyWith(userName: ''));
    _regostrationErrorSubject.add(RegistrationErrorText.nullable);
    _isRegistrationValidSubject.add(false);
  }

  RegistrationBloc() {
    _registrationSubject.disposeWith(this);
    _regostrationErrorSubject.disposeWith(this);
    _isRegistrationValidSubject.disposeWith(this);
  }
}
