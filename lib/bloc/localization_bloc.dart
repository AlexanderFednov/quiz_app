import 'dart:ui';

import 'package:rxdart/subjects.dart';
import 'package:easy_dispose/easy_dispose.dart';

class LocalizationBloc extends DisposableOwner {
  static Locale locale = Locale('ru', 'RU');

  final BehaviorSubject<Locale> _localizationSubject =
      BehaviorSubject.seeded(locale);

  Stream<Locale> get localizationStream => _localizationSubject.stream;

  Locale get currentLocale => _localizationSubject.value;

  void localeRu() {
    _localizationSubject.add(
      Locale('ru', 'RU'),
    );
  }

  void localeEn() {
    _localizationSubject.add(
      Locale('en', 'EN'),
    );
  }

  LocalizationBloc() {
    _localizationSubject.disposeWith(this);
  }
}
