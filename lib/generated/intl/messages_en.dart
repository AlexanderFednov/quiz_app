// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static m0(savedScore, questionsLenght) => "${Intl.plural(savedScore, zero: 'Last result - ${savedScore} points of ${questionsLenght}', one: 'Last result - ${savedScore} point of ${questionsLenght}', two: 'Last result - ${savedScore} points of ${questionsLenght}', few: 'Last result - ${savedScore} points of ${questionsLenght}', many: 'Last result - ${savedScore} points of ${questionsLenght}', other: 'Last result - ${savedScore} points of ${questionsLenght}')}";

  static m1(score, questions) => "Your score - ${score} of ${questions}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "categotyChoice" : MessageLookupByLibrary.simpleMessage("Select a category"),
    "lastResult" : m0,
    "questionsAll" : MessageLookupByLibrary.simpleMessage("General questions"),
    "questionsFilms" : MessageLookupByLibrary.simpleMessage("Movies of the USSR"),
    "questionsSpace" : MessageLookupByLibrary.simpleMessage("Space"),
    "reset" : MessageLookupByLibrary.simpleMessage("To the main page (the result will be reset)"),
    "result" : m1,
    "title" : MessageLookupByLibrary.simpleMessage("Funny Quiz"),
    "titleAppbar" : MessageLookupByLibrary.simpleMessage("Quiz without cash prizes "),
    "toMainPage" : MessageLookupByLibrary.simpleMessage("To the main page")
  };
}
