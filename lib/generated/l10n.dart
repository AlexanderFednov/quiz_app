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
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
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

  /// `Select a category`
  String get categotyChoice {
    return Intl.message(
      'Select a category',
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

  /// `To the main page (the result will be reset)`
  String get reset {
    return Intl.message(
      'To the main page (the result will be reset)',
      name: 'reset',
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
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}