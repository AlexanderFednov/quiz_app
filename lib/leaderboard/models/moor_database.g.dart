// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class MoorResult extends DataClass implements Insertable<MoorResult> {
  final int id;
  final String name;
  final int result;
  final int questionsLenght;
  final double rightResultsPercent;
  final Category category;
  final DateTime resultDate;
  const MoorResult(
      {required this.id,
      required this.name,
      required this.result,
      required this.questionsLenght,
      required this.rightResultsPercent,
      required this.category,
      required this.resultDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['result'] = Variable<int>(result);
    map['questions_lenght'] = Variable<int>(questionsLenght);
    map['right_results_percent'] = Variable<double>(rightResultsPercent);
    {
      final converter = $MoorResultsTable.$converter0;
      map['category'] = Variable<int>(converter.toSql(category));
    }
    map['result_date'] = Variable<DateTime>(resultDate);
    return map;
  }

  MoorResultsCompanion toCompanion(bool nullToAbsent) {
    return MoorResultsCompanion(
      id: Value(id),
      name: Value(name),
      result: Value(result),
      questionsLenght: Value(questionsLenght),
      rightResultsPercent: Value(rightResultsPercent),
      category: Value(category),
      resultDate: Value(resultDate),
    );
  }

  factory MoorResult.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MoorResult(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      result: serializer.fromJson<int>(json['result']),
      questionsLenght: serializer.fromJson<int>(json['questionsLenght']),
      rightResultsPercent:
          serializer.fromJson<double>(json['rightResultsPercent']),
      category: serializer.fromJson<Category>(json['category']),
      resultDate: serializer.fromJson<DateTime>(json['resultDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'result': serializer.toJson<int>(result),
      'questionsLenght': serializer.toJson<int>(questionsLenght),
      'rightResultsPercent': serializer.toJson<double>(rightResultsPercent),
      'category': serializer.toJson<Category>(category),
      'resultDate': serializer.toJson<DateTime>(resultDate),
    };
  }

  MoorResult copyWith(
          {int? id,
          String? name,
          int? result,
          int? questionsLenght,
          double? rightResultsPercent,
          Category? category,
          DateTime? resultDate}) =>
      MoorResult(
        id: id ?? this.id,
        name: name ?? this.name,
        result: result ?? this.result,
        questionsLenght: questionsLenght ?? this.questionsLenght,
        rightResultsPercent: rightResultsPercent ?? this.rightResultsPercent,
        category: category ?? this.category,
        resultDate: resultDate ?? this.resultDate,
      );
  @override
  String toString() {
    return (StringBuffer('MoorResult(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('result: $result, ')
          ..write('questionsLenght: $questionsLenght, ')
          ..write('rightResultsPercent: $rightResultsPercent, ')
          ..write('category: $category, ')
          ..write('resultDate: $resultDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, result, questionsLenght,
      rightResultsPercent, category, resultDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MoorResult &&
          other.id == this.id &&
          other.name == this.name &&
          other.result == this.result &&
          other.questionsLenght == this.questionsLenght &&
          other.rightResultsPercent == this.rightResultsPercent &&
          other.category == this.category &&
          other.resultDate == this.resultDate);
}

class MoorResultsCompanion extends UpdateCompanion<MoorResult> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> result;
  final Value<int> questionsLenght;
  final Value<double> rightResultsPercent;
  final Value<Category> category;
  final Value<DateTime> resultDate;
  const MoorResultsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.result = const Value.absent(),
    this.questionsLenght = const Value.absent(),
    this.rightResultsPercent = const Value.absent(),
    this.category = const Value.absent(),
    this.resultDate = const Value.absent(),
  });
  MoorResultsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int result,
    required int questionsLenght,
    required double rightResultsPercent,
    required Category category,
    required DateTime resultDate,
  })  : name = Value(name),
        result = Value(result),
        questionsLenght = Value(questionsLenght),
        rightResultsPercent = Value(rightResultsPercent),
        category = Value(category),
        resultDate = Value(resultDate);
  static Insertable<MoorResult> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? result,
    Expression<int>? questionsLenght,
    Expression<double>? rightResultsPercent,
    Expression<int>? category,
    Expression<DateTime>? resultDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (result != null) 'result': result,
      if (questionsLenght != null) 'questions_lenght': questionsLenght,
      if (rightResultsPercent != null)
        'right_results_percent': rightResultsPercent,
      if (category != null) 'category': category,
      if (resultDate != null) 'result_date': resultDate,
    });
  }

  MoorResultsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<int>? result,
      Value<int>? questionsLenght,
      Value<double>? rightResultsPercent,
      Value<Category>? category,
      Value<DateTime>? resultDate}) {
    return MoorResultsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      result: result ?? this.result,
      questionsLenght: questionsLenght ?? this.questionsLenght,
      rightResultsPercent: rightResultsPercent ?? this.rightResultsPercent,
      category: category ?? this.category,
      resultDate: resultDate ?? this.resultDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (result.present) {
      map['result'] = Variable<int>(result.value);
    }
    if (questionsLenght.present) {
      map['questions_lenght'] = Variable<int>(questionsLenght.value);
    }
    if (rightResultsPercent.present) {
      map['right_results_percent'] =
          Variable<double>(rightResultsPercent.value);
    }
    if (category.present) {
      final converter = $MoorResultsTable.$converter0;
      map['category'] = Variable<int>(converter.toSql(category.value));
    }
    if (resultDate.present) {
      map['result_date'] = Variable<DateTime>(resultDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MoorResultsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('result: $result, ')
          ..write('questionsLenght: $questionsLenght, ')
          ..write('rightResultsPercent: $rightResultsPercent, ')
          ..write('category: $category, ')
          ..write('resultDate: $resultDate')
          ..write(')'))
        .toString();
  }
}

class $MoorResultsTable extends MoorResults
    with TableInfo<$MoorResultsTable, MoorResult> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MoorResultsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _resultMeta = const VerificationMeta('result');
  @override
  late final GeneratedColumn<int> result = GeneratedColumn<int>(
      'result', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _questionsLenghtMeta =
      const VerificationMeta('questionsLenght');
  @override
  late final GeneratedColumn<int> questionsLenght = GeneratedColumn<int>(
      'questions_lenght', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _rightResultsPercentMeta =
      const VerificationMeta('rightResultsPercent');
  @override
  late final GeneratedColumn<double> rightResultsPercent =
      GeneratedColumn<double>('right_results_percent', aliasedName, false,
          type: DriftSqlType.double, requiredDuringInsert: true);
  final VerificationMeta _categoryMeta = const VerificationMeta('category');
  @override
  late final GeneratedColumnWithTypeConverter<Category, int> category =
      GeneratedColumn<int>('category', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<Category>($MoorResultsTable.$converter0);
  final VerificationMeta _resultDateMeta = const VerificationMeta('resultDate');
  @override
  late final GeneratedColumn<DateTime> resultDate = GeneratedColumn<DateTime>(
      'result_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        result,
        questionsLenght,
        rightResultsPercent,
        category,
        resultDate
      ];
  @override
  String get aliasedName => _alias ?? 'moor_results';
  @override
  String get actualTableName => 'moor_results';
  @override
  VerificationContext validateIntegrity(Insertable<MoorResult> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('result')) {
      context.handle(_resultMeta,
          result.isAcceptableOrUnknown(data['result']!, _resultMeta));
    } else if (isInserting) {
      context.missing(_resultMeta);
    }
    if (data.containsKey('questions_lenght')) {
      context.handle(
          _questionsLenghtMeta,
          questionsLenght.isAcceptableOrUnknown(
              data['questions_lenght']!, _questionsLenghtMeta));
    } else if (isInserting) {
      context.missing(_questionsLenghtMeta);
    }
    if (data.containsKey('right_results_percent')) {
      context.handle(
          _rightResultsPercentMeta,
          rightResultsPercent.isAcceptableOrUnknown(
              data['right_results_percent']!, _rightResultsPercentMeta));
    } else if (isInserting) {
      context.missing(_rightResultsPercentMeta);
    }
    context.handle(_categoryMeta, const VerificationResult.success());
    if (data.containsKey('result_date')) {
      context.handle(
          _resultDateMeta,
          resultDate.isAcceptableOrUnknown(
              data['result_date']!, _resultDateMeta));
    } else if (isInserting) {
      context.missing(_resultDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MoorResult map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MoorResult(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      result: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}result'])!,
      questionsLenght: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}questions_lenght'])!,
      rightResultsPercent: attachedDatabase.options.types.read(
          DriftSqlType.double,
          data['${effectivePrefix}right_results_percent'])!,
      category: $MoorResultsTable.$converter0.fromSql(attachedDatabase
          .options.types
          .read(DriftSqlType.int, data['${effectivePrefix}category'])!),
      resultDate: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}result_date'])!,
    );
  }

  @override
  $MoorResultsTable createAlias(String alias) {
    return $MoorResultsTable(attachedDatabase, alias);
  }

  static TypeConverter<Category, int> $converter0 =
      const EnumIndexConverter<Category>(Category.values);
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(e);
  late final $MoorResultsTable moorResults = $MoorResultsTable(this);
  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [moorResults];
}
