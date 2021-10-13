import 'dart:ui';

import 'package:quiz_app/localization/localization_model.dart';
import 'package:rxdart/subjects.dart';
import 'package:easy_dispose/easy_dispose.dart';

class LocalizationBloc extends DisposableOwner {
  LocalizationBloc() {
    _localizationStateSubject.disposeWith(this);
  }

  static final LocalizationModel _localizationModel = LocalizationModel();

  final BehaviorSubject<LocalizationModel> _localizationStateSubject =
      BehaviorSubject.seeded(_localizationModel);

  Stream<Locale> get localizationStream => _localizationStateSubject.stream
      .map((localizationModel) => localizationModel.currentLocale);

  LocalizationModel get localizationState => _localizationStateSubject.value;

  Locale get currentLocale => _localizationStateSubject.value.currentLocale;

  void localeRu() {
    _localizationStateSubject.add(
      localizationState.copyWith(
        currentLocale: Locale('ru', 'RU'),
      ),
    );
  }

  void localeEn() {
    _localizationStateSubject.add(
      localizationState.copyWith(
        currentLocale: Locale('en', 'EN'),
      ),
    );
  }
}
