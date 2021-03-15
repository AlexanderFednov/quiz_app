// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questionList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionList _$QuestionListFromJson(Map<String, dynamic> json) {
  return QuestionList(
    (json['question'] as List)
        ?.map((e) => e == null
            ? null
            : QuestionInside.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$QuestionListToJson(QuestionList instance) =>
    <String, dynamic>{
      'question': instance.question,
    };

QuestionInside _$QuestionInsideFromJson(Map<String, dynamic> json) {
  return QuestionInside(
    json['questionText'] as String,
    (json['answers'] as List)
        ?.map((e) =>
            e == null ? null : Answers.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$QuestionInsideToJson(QuestionInside instance) =>
    <String, dynamic>{
      'questionText': instance.questionText,
      'answers': instance.answers,
    };

Answers _$AnswersFromJson(Map<String, dynamic> json) {
  return Answers(
    json['text'] as String,
    json['result'] as bool,
    json['code'] as String,
  );
}

Map<String, dynamic> _$AnswersToJson(Answers instance) => <String, dynamic>{
      'text': instance.text,
      'result': instance.result,
      'code': instance.code,
    };
