import 'package:equatable/equatable.dart';
import 'package:quiz_app/models/question_list.dart';

class QuestionsModel extends Equatable {
  final List<Question> questionsGeneral;
  final List<Question> questionsMovies;
  final List<Question> questionsSpace;
  final List<Question> questionsWeb;

  QuestionsModel({
    this.questionsGeneral = const [],
    this.questionsMovies = const [],
    this.questionsSpace = const [],
    this.questionsWeb = const [],
  });

  QuestionsModel copyWith({
    List<Question>? questionsGeneral,
    List<Question>? questionsMovies,
    List<Question>? questionsSpace,
    List<Question>? questionsWeb,
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
