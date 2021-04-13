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

  static m0(user) => "Hello, ${user}!";

  static m1(savedScore, questionsLenght) => "${Intl.plural(savedScore, zero: 'Last result - ${savedScore} points of ${questionsLenght}', one: 'Last result - ${savedScore} point of ${questionsLenght}', two: 'Last result - ${savedScore} points of ${questionsLenght}', few: 'Last result - ${savedScore} points of ${questionsLenght}', many: 'Last result - ${savedScore} points of ${questionsLenght}', other: 'Last result - ${savedScore} points of ${questionsLenght}')}";

  static m2(score, questions) => "Your score - ${score} of ${questions}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "addUser" : MessageLookupByLibrary.simpleMessage("Add user"),
    "cancel" : MessageLookupByLibrary.simpleMessage("Cancel"),
    "categotyChoice" : MessageLookupByLibrary.simpleMessage("Select a category:"),
    "changeUser" : MessageLookupByLibrary.simpleMessage("Change user"),
    "currentUser" : MessageLookupByLibrary.simpleMessage("Current user:"),
    "enterName" : MessageLookupByLibrary.simpleMessage("Enter name"),
    "helloMessage" : m0,
    "information" : MessageLookupByLibrary.simpleMessage("Information"),
    "lastResult" : m1,
    "lastResults" : MessageLookupByLibrary.simpleMessage("Last results"),
    "nameIsTaken" : MessageLookupByLibrary.simpleMessage("This name is taken"),
    "nullify" : MessageLookupByLibrary.simpleMessage("Nullify"),
    "questionsAll" : MessageLookupByLibrary.simpleMessage("General questions"),
    "questionsFilms" : MessageLookupByLibrary.simpleMessage("Movies of the USSR"),
    "questionsSpace" : MessageLookupByLibrary.simpleMessage("Space"),
    "questionsWeb" : MessageLookupByLibrary.simpleMessage("Sector 13"),
    "registrationDate" : MessageLookupByLibrary.simpleMessage("Registration date:"),
    "reset" : MessageLookupByLibrary.simpleMessage("To the main page (the result will be reset)"),
    "resetLeaderBoard" : MessageLookupByLibrary.simpleMessage("Reset"),
    "result" : m2,
    "search" : MessageLookupByLibrary.simpleMessage("Search"),
    "selectUser" : MessageLookupByLibrary.simpleMessage("Select user"),
    "title" : MessageLookupByLibrary.simpleMessage("Funny Quiz"),
    "titleAppbar" : MessageLookupByLibrary.simpleMessage("Quiz without cash prizes "),
    "toMainPage" : MessageLookupByLibrary.simpleMessage("To the main page"),
    "userList" : MessageLookupByLibrary.simpleMessage("Users"),
    "userListEmpty" : MessageLookupByLibrary.simpleMessage("User list is empty"),
    "userResult" : MessageLookupByLibrary.simpleMessage("Result:")
  };
}
