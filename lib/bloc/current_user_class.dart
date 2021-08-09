import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:quiz_app/models/hive_user_data.dart';

class CurrentUserClass with ChangeNotifier {
  UserData currentUser;

  void getCurrentUser() {
    var contactsBox = Hive.box<UserData>('UserData1');
    if (contactsBox.isNotEmpty) {
      contactsBox.values.forEach((element) {
        if (element.isCurrentUser) {
          currentUser = element;
        }
      });
    } else {
      currentUser = null;
    }
    notifyListeners();
  }

  void setCurrentUser() {
    var contactsBox = Hive.box<UserData>('UserData1');

    contactsBox.values.forEach((element) {
      if (element.isCurrentUser) currentUser = element;
    });

    notifyListeners();
  }

  void clearCurrentUser() {
    currentUser = null;

    notifyListeners();
  }

  CurrentUserClass() {
    getCurrentUser();
  }
}
