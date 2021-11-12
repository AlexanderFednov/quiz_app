import 'dart:ui';

import 'package:quiz_app/localization/localization_model.dart';
import 'package:rxdart/subjects.dart';
import 'package:easy_dispose/easy_dispose.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationBloc extends DisposableOwner {
  LocalizationBloc() {
    _loadSavedLocale();

    _localizationStateSubject.disposeWith(this);
  }

  static final LocalizationModel _localizationModel = LocalizationModel();

  final BehaviorSubject<LocalizationModel> _localizationStateSubject =
      BehaviorSubject.seeded(_localizationModel);

  Stream<Locale> get localizationStream => _localizationStateSubject.stream
      .map((localizationModel) => localizationModel.currentLocale);

  LocalizationModel get localizationState => _localizationStateSubject.value;

  Locale get currentLocale => _localizationStateSubject.value.currentLocale;

  void setLocaleRu() async {
    _localizationStateSubject.add(
      localizationState.copyWith(
        currentLocale: Locale('ru', 'RU'),
      ),
    );

    var prefs = await SharedPreferences.getInstance();

    await prefs.setString('locale', 'ru');
  }

  void setLocaleEn() async {
    _localizationStateSubject.add(
      localizationState.copyWith(
        currentLocale: Locale('en', 'EN'),
      ),
    );

    var prefs = await SharedPreferences.getInstance();

    await prefs.setString('locale', 'en');
  }

  void _loadSavedLocale() async {
    var prefs = await SharedPreferences.getInstance();

    final localeIndex = prefs.getString('locale');

    switch (localeIndex) {
      case 'ru':
        _localizationStateSubject.add(
          localizationState.copyWith(
            currentLocale: Locale('ru', 'RU'),
          ),
        );
        break;

      case 'en':
        _localizationStateSubject.add(
          localizationState.copyWith(
            currentLocale: Locale('en', 'EN'),
          ),
        );
        break;

      default:
        null;
    }
  }
}
