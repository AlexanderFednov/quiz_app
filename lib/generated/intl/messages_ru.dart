// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  static m0(savedScore, questionsLenght) => "${Intl.plural(savedScore, zero: 'Последний результат - ${savedScore} баллов из ${questionsLenght}', one: 'Последний результат - ${savedScore} балл из ${questionsLenght}', two: 'Последний результат - ${savedScore} балла из ${questionsLenght}', few: 'Последний результат - ${savedScore} балла из ${questionsLenght}', many: 'Последний результат - ${savedScore} баллов из ${questionsLenght}', other: 'Последний результат - ${savedScore} баллов из ${questionsLenght}')}";

  static m1(score, questions) => "Правильных ответов - ${score} из ${questions}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "categotyChoice" : MessageLookupByLibrary.simpleMessage("Выберите категорию"),
    "lastResult" : m0,
    "questionsAll" : MessageLookupByLibrary.simpleMessage("Общие вопросы"),
    "questionsFilms" : MessageLookupByLibrary.simpleMessage("Кинофильмы СССР"),
    "questionsSpace" : MessageLookupByLibrary.simpleMessage("Космос"),
    "reset" : MessageLookupByLibrary.simpleMessage("На главную страницу(результат будет сброшен)"),
    "result" : m1,
    "title" : MessageLookupByLibrary.simpleMessage("Весёлая викторина"),
    "titleAppbar" : MessageLookupByLibrary.simpleMessage("Викторина без денежных призов"),
    "toMainPage" : MessageLookupByLibrary.simpleMessage("На главную страницу")
  };
}
