import 'package:equatable/equatable.dart';
import 'package:quiz_app/models/question_list.dart';

class QuestionsModel extends Equatable {
  final List<QuestionInside> questionsGeneral;
  final List<QuestionInside> questionsMovies;
  final List<QuestionInside> questionsSpace;
  final List<QuestionInside> questionsWeb;

  QuestionsModel({
    this.questionsGeneral = const [],
    this.questionsMovies = const [],
    this.questionsSpace = const [],
    this.questionsWeb = const [],
  });

  QuestionsModel copyWith({
    List<QuestionInside>? questionsGeneral,
    List<QuestionInside>? questionsMovies,
    List<QuestionInside>? questionsSpace,
    List<QuestionInside>? questionsWeb,
  }) {
    return QuestionsModel(
      questionsGeneral: questionsGeneral ?? this.questionsGeneral,
      questionsMovies: questionsMovies ?? this.questionsMovies,
      questionsSpace: questionsSpace ?? this.questionsSpace,
      questionsWeb: questionsWeb ?? this.questionsWeb,
    );
  }

  @override
  List<Object?> get props => [
        questionsGeneral,
        questionsMovies,
        questionsSpace,
        questionsWeb,
      ];
}
