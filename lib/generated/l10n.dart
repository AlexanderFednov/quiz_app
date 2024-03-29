// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Quiz without cash prizes `
  String get titleAppbar {
    return Intl.message(
      'Quiz without cash prizes ',
      name: 'titleAppbar',
      desc: '',
      args: [],
    );
  }

  /// `Funny Quiz`
  String get title {
    return Intl.message(
      'Funny Quiz',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Select a category:`
  String get categotyChoice {
    return Intl.message(
      'Select a category:',
      name: 'categotyChoice',
      desc: '',
      args: [],
    );
  }

  /// `General questions`
  String get questionsAll {
    return Intl.message(
      'General questions',
      name: 'questionsAll',
      desc: '',
      args: [],
    );
  }

  /// `Movies of the USSR`
  String get questionsFilms {
    return Intl.message(
      'Movies of the USSR',
      name: 'questionsFilms',
      desc: '',
      args: [],
    );
  }

  /// `Space`
  String get questionsSpace {
    return Intl.message(
      'Space',
      name: 'questionsSpace',
      desc: '',
      args: [],
    );
  }

  /// `Sector 13`
  String get questionsWeb {
    return Intl.message(
      'Sector 13',
      name: 'questionsWeb',
      desc: '',
      args: [],
    );
  }

  /// `To the main page (the result will be reset)`
  String get reset {
    return Intl.message(
      'To the main page (the result will be reset)',
      name: 'reset',
      desc: '',
      args: [],
    );
  }

  /// `To the main page`
  String get toMainPage {
    return Intl.message(
      'To the main page',
      name: 'toMainPage',
      desc: '',
      args: [],
    );
  }

  /// `Your score - {score} of {questions}`
  String result(int score, int questions) {
    return Intl.message(
      'Your score - $score of $questions',
      name: 'result',
      desc: 'Quiz result',
      args: [score, questions],
    );
  }

  /// `{savedScore, plural, zero{Last result - {savedScore} points of {questionsLenght}} one{Last result - {savedScore} point of {questionsLenght}} two{Last result - {savedScore} points of {questionsLenght}} few{Last result - {savedScore} points of {questionsLenght}} many{Last result - {savedScore} points of {questionsLenght}} other{Last result - {savedScore} points of {questionsLenght}}}`
  String lastResult(int savedScore, int questionsLenght) {
    return Intl.plural(
      savedScore,
      zero: 'Last result - $savedScore points of $questionsLenght',
      one: 'Last result - $savedScore point of $questionsLenght',
      two: 'Last result - $savedScore points of $questionsLenght',
      few: 'Last result - $savedScore points of $questionsLenght',
      many: 'Last result - $savedScore points of $questionsLenght',
      other: 'Last result - $savedScore points of $questionsLenght',
      name: 'lastResult',
      desc: 'Last Result',
      args: [savedScore, questionsLenght],
    );
  }

  /// `Reset`
  String get resetLeaderBoard {
    return Intl.message(
      'Reset',
      name: 'resetLeaderBoard',
      desc: '',
      args: [],
    );
  }

  /// `Last results`
  String get lastResults {
    return Intl.message(
      'Last results',
      name: 'lastResults',
      desc: '',
      args: [],
    );
  }

  /// `Hello, {user}!`
  String helloMessage(String user) {
    return Intl.message(
      'Hello, $user!',
      name: 'helloMessage',
      desc: 'Welcome Message',
      args: [user],
    );
  }

  /// `Change user`
  String get changeUser {
    return Intl.message(
      'Change user',
      name: 'changeUser',
      desc: '',
      args: [],
    );
  }

  /// `Select user`
  String get selectUser {
    return Intl.message(
      'Select user',
      name: 'selectUser',
      desc: '',
      args: [],
    );
  }

  /// `Information`
  String get information {
    return Intl.message(
      'Information',
      name: 'information',
      desc: '',
      args: [],
    );
  }

  /// `Users`
  String get userList {
    return Intl.message(
      'Users',
      name: 'userList',
      desc: '',
      args: [],
    );
  }

  /// `Current user:`
  String get currentUser {
    return Intl.message(
      'Current user:',
      name: 'currentUser',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Nullify`
  String get nullify {
    return Intl.message(
      'Nullify',
      name: 'nullify',
      desc: '',
      args: [],
    );
  }

  /// `User list is empty`
  String get userListEmpty {
    return Intl.message(
      'User list is empty',
      name: 'userListEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Registration date:`
  String get registrationDate {
    return Intl.message(
      'Registration date:',
      name: 'registrationDate',
      desc: '',
      args: [],
    );
  }

  /// `Result:`
  String get userResult {
    return Intl.message(
      'Result:',
      name: 'userResult',
      desc: '',
      args: [],
    );
  }

  /// `Enter name`
  String get enterName {
    return Intl.message(
      'Enter name',
      name: 'enterName',
      desc: '',
      args: [],
    );
  }

  /// `This name is taken`
  String get nameIsTaken {
    return Intl.message(
      'This name is taken',
      name: 'nameIsTaken',
      desc: '',
      args: [],
    );
  }

  /// `Add user`
  String get addUser {
    return Intl.message(
      'Add user',
      name: 'addUser',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure?`
  String get areYouSure {
    return Intl.message(
      'Are you sure?',
      name: 'areYouSure',
      desc: '',
      args: [],
    );
  }

  /// `Last result:`
  String get userLastResult {
    return Intl.message(
      'Last result:',
      name: 'userLastResult',
      desc: '',
      args: [],
    );
  }

  /// `All results:`
  String get allUserResult {
    return Intl.message(
      'All results:',
      name: 'allUserResult',
      desc: '',
      args: [],
    );
  }

  /// `Right answers percent:`
  String get rightAnswersPercent {
    return Intl.message(
      'Right answers percent:',
      name: 'rightAnswersPercent',
      desc: '',
      args: [],
    );
  }

  /// `List of results is empty`
  String get resultsListEmpty {
    return Intl.message(
      'List of results is empty',
      name: 'resultsListEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Leaderboard`
  String get leaderBoard {
    return Intl.message(
      'Leaderboard',
      name: 'leaderBoard',
      desc: '',
      args: [],
    );
  }

  /// `New User`
  String get newUser {
    return Intl.message(
      'New User',
      name: 'newUser',
      desc: '',
      args: [],
    );
  }

  /// `Add new User`
  String get addNewUser {
    return Intl.message(
      'Add new User',
      name: 'addNewUser',
      desc: '',
      args: [],
    );
  }

  /// `User name`
  String get userName {
    return Intl.message(
      'User name',
      name: 'userName',
      desc: '',
      args: [],
    );
  }

  /// `Server unavailable.\n Return to the main page and try again or select another category. `
  String get httpServerError {
    return Intl.message(
      'Server unavailable.\n Return to the main page and try again or select another category. ',
      name: 'httpServerError',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
