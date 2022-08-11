// import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
// import '/generated/l10n.dart';

part 'hive_user_data.g.dart';

@HiveType(typeId: 0)
class UserData extends HiveObject {
  @HiveField(0)
  String userName;
  @HiveField(1)
  int userResult;
  @HiveField(2)
  bool isCurrentUser;
  @HiveField(3)
  DateTime registerDate;
  @HiveField(4)
  List<UserResult>? userResults = [];

  double get rightAnswersPercentAll {
    var sumAnswers = 0;
    var sumQuestions = 0;

    userResults!.forEach((element) {
      sumAnswers = sumAnswers + element.score!;
      sumQuestions = sumQuestions + element.questionsLenght!;
    });

    return 100 / sumQuestions * sumAnswers;
  }

  UserData({
    this.userName = '',
    this.userResult = 0,
    this.isCurrentUser = false,
    required this.registerDate,
    this.userResults,
  });
}

@HiveType(typeId: 1)
class UserResult extends HiveObject {
  @HiveField(0)
  int? score;
  @HiveField(1)
  int? questionsLenght;
  @HiveField(2)
  DateTime? resultDate;
  @HiveField(3)
  Category? category;

  double get rightAnswersPercent => 100 / questionsLenght! * score!;

  String get textOfCategory {
    switch (category) {
      case Category.generalQuestions:
        return 'General questions';

      case Category.moviesOfUSSSR:
        return 'Movies of the USSR';

      case Category.space:
        return 'Space';

      case Category.sector13:
        return 'Sector 13';

      default:
        return '';
    }
  }

  UserResult({
    this.score = 0,
    this.questionsLenght = 0,
    this.resultDate,
    this.category,
  });
}

@HiveType(typeId: 2)
enum Category {
  @HiveField(0)
  generalQuestions,
  @HiveField(1)
  moviesOfUSSSR,
  @HiveField(2)
  space,
  @HiveField(3)
  sector13,
}
