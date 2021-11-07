// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class MoorResult extends DataClass implements Insertable<MoorResult> {
  final int id;
  final String name;
  final int result;
  final int questionsLenght;
  final double rightResultsPercent;
  final Category category;
  final DateTime resultDate;
  MoorResult(
      {required this.id,
      required this.name,
      required this.result,
      required this.questionsLenght,
      required this.rightResultsPercent,
      required this.category,
      required this.resultDate});
  factory MoorResult.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return MoorResult(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      result: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}result'])!,
      questionsLenght: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}questions_lenght'])!,
      rightResultsPercent: const RealType().mapFromDatabaseResponse(
          data['${effectivePrefix}right_results_percent'])!,
      category: $MoorResultsTable.$converter0.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}category']))!,
      resultDate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}result_date'])!,
    );
  }
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
      map['category'] = Variable<int>(converter.mapToSql(category)!);
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
    serializer ??= moorRuntimeOptions.defaultSerializer;
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
    serializer ??= moorRuntimeOptions.defaultSerializer;
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
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              result.hashCode,
              $mrjc(
                  questionsLenght.hashCode,
                  $mrjc(rightResultsPercent.hashCode,
                      $mrjc(category.hashCode, resultDate.hashCode)))))));
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
    Expression<Category>? category,
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
      map['category'] = Variable<int>(converter.mapToSql(category.value)!);
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
  final GeneratedDatabase _db;
  final String? _alias;
  $MoorResultsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _resultMeta = const VerificationMeta('result');
  late final GeneratedColumn<int?> result = GeneratedColumn<int?>(
      'result', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _questionsLenghtMeta =
      const VerificationMeta('questionsLenght');
  late final GeneratedColumn<int?> questionsLenght = GeneratedColumn<int?>(
      'questions_lenght', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _rightResultsPercentMeta =
      const VerificationMeta('rightResultsPercent');
  late final GeneratedColumn<double?> rightResultsPercent =
      GeneratedColumn<double?>('right_results_percent', aliasedName, false,
          typeName: 'REAL', requiredDuringInsert: true);
  final VerificationMeta _categoryMeta = const VerificationMeta('category');
  late final GeneratedColumnWithTypeConverter<Category, int?> category =
      GeneratedColumn<int?>('category', aliasedName, false,
              typeName: 'INTEGER', requiredDuringInsert: true)
          .withConverter<Category>($MoorResultsTable.$converter0);
  final VerificationMeta _resultDateMeta = const VerificationMeta('resultDate');
  late final GeneratedColumn<DateTime?> resultDate = GeneratedColumn<DateTime?>(
      'result_date', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
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
    return MoorResult.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $MoorResultsTable createAlias(String alias) {
    return $MoorResultsTable(_db, alias);
  }

  static TypeConverter<Category, int> $converter0 =
      const EnumIndexConverter<Category>(Category.values);
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $MoorResultsTable moorResults = $MoorResultsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [moorResults];
}
