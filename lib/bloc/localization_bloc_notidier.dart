import 'package:flutter/cupertino.dart';

class LocalizationBlocNotifier with ChangeNotifier {
  Locale locale = Locale('ru', 'RU');

  void localizationRu() {
    locale = Locale('ru', 'RU');

    notifyListeners();
  }

  void localizationEn() {
    locale = Locale('en', 'EN');

    notifyListeners();
  }
}
