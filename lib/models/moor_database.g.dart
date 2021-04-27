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
  final int categoryNumber;
  final DateTime resultDate;
  MoorResult(
      {@required this.id,
      @required this.name,
      @required this.result,
      @required this.questionsLenght,
      @required this.rightResultsPercent,
      @required this.categoryNumber,
      @required this.resultDate});
  factory MoorResult.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return MoorResult(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      result: intType.mapFromDatabaseResponse(data['${effectivePrefix}result']),
      questionsLenght: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}questions_lenght']),
      rightResultsPercent: doubleType.mapFromDatabaseResponse(
          data['${effectivePrefix}right_results_percent']),
      categoryNumber: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}category_number']),
      resultDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}result_date']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || result != null) {
      map['result'] = Variable<int>(result);
    }
    if (!nullToAbsent || questionsLenght != null) {
      map['questions_lenght'] = Variable<int>(questionsLenght);
    }
    if (!nullToAbsent || rightResultsPercent != null) {
      map['right_results_percent'] = Variable<double>(rightResultsPercent);
    }
    if (!nullToAbsent || categoryNumber != null) {
      map['category_number'] = Variable<int>(categoryNumber);
    }
    if (!nullToAbsent || resultDate != null) {
      map['result_date'] = Variable<DateTime>(resultDate);
    }
    return map;
  }

  MoorResultsCompanion toCompanion(bool nullToAbsent) {
    return MoorResultsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      result:
          result == null && nullToAbsent ? const Value.absent() : Value(result),
      questionsLenght: questionsLenght == null && nullToAbsent
          ? const Value.absent()
          : Value(questionsLenght),
      rightResultsPercent: rightResultsPercent == null && nullToAbsent
          ? const Value.absent()
          : Value(rightResultsPercent),
      categoryNumber: categoryNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryNumber),
      resultDate: resultDate == null && nullToAbsent
          ? const Value.absent()
          : Value(resultDate),
    );
  }

  factory MoorResult.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return MoorResult(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      result: serializer.fromJson<int>(json['result']),
      questionsLenght: serializer.fromJson<int>(json['questionsLenght']),
      rightResultsPercent:
          serializer.fromJson<double>(json['rightResultsPercent']),
      categoryNumber: serializer.fromJson<int>(json['categoryNumber']),
      resultDate: serializer.fromJson<DateTime>(json['resultDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'result': serializer.toJson<int>(result),
      'questionsLenght': serializer.toJson<int>(questionsLenght),
      'rightResultsPercent': serializer.toJson<double>(rightResultsPercent),
      'categoryNumber': serializer.toJson<int>(categoryNumber),
      'resultDate': serializer.toJson<DateTime>(resultDate),
    };
  }

  MoorResult copyWith(
          {int id,
          String name,
          int result,
          int questionsLenght,
          double rightResultsPercent,
          int categoryNumber,
          DateTime resultDate}) =>
      MoorResult(
        id: id ?? this.id,
        name: name ?? this.name,
        result: result ?? this.result,
        questionsLenght: questionsLenght ?? this.questionsLenght,
        rightResultsPercent: rightResultsPercent ?? this.rightResultsPercent,
        categoryNumber: categoryNumber ?? this.categoryNumber,
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
          ..write('categoryNumber: $categoryNumber, ')
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
                      $mrjc(categoryNumber.hashCode, resultDate.hashCode)))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is MoorResult &&
          other.id == this.id &&
          other.name == this.name &&
          other.result == this.result &&
          other.questionsLenght == this.questionsLenght &&
          other.rightResultsPercent == this.rightResultsPercent &&
          other.categoryNumber == this.categoryNumber &&
          other.resultDate == this.resultDate);
}

class MoorResultsCompanion extends UpdateCompanion<MoorResult> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> result;
  final Value<int> questionsLenght;
  final Value<double> rightResultsPercent;
  final Value<int> categoryNumber;
  final Value<DateTime> resultDate;
  const MoorResultsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.result = const Value.absent(),
    this.questionsLenght = const Value.absent(),
    this.rightResultsPercent = const Value.absent(),
    this.categoryNumber = const Value.absent(),
    this.resultDate = const Value.absent(),
  });
  MoorResultsCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    @required int result,
    @required int questionsLenght,
    @required double rightResultsPercent,
    @required int categoryNumber,
    @required DateTime resultDate,
  })  : name = Value(name),
        result = Value(result),
        questionsLenght = Value(questionsLenght),
        rightResultsPercent = Value(rightResultsPercent),
        categoryNumber = Value(categoryNumber),
        resultDate = Value(resultDate);
  static Insertable<MoorResult> custom({
    Expression<int> id,
    Expression<String> name,
    Expression<int> result,
    Expression<int> questionsLenght,
    Expression<double> rightResultsPercent,
    Expression<int> categoryNumber,
    Expression<DateTime> resultDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (result != null) 'result': result,
      if (questionsLenght != null) 'questions_lenght': questionsLenght,
      if (rightResultsPercent != null)
        'right_results_percent': rightResultsPercent,
      if (categoryNumber != null) 'category_number': categoryNumber,
      if (resultDate != null) 'result_date': resultDate,
    });
  }

  MoorResultsCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<int> result,
      Value<int> questionsLenght,
      Value<double> rightResultsPercent,
      Value<int> categoryNumber,
      Value<DateTime> resultDate}) {
    return MoorResultsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      result: result ?? this.result,
      questionsLenght: questionsLenght ?? this.questionsLenght,
      rightResultsPercent: rightResultsPercent ?? this.rightResultsPercent,
      categoryNumber: categoryNumber ?? this.categoryNumber,
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
    if (categoryNumber.present) {
      map['category_number'] = Variable<int>(categoryNumber.value);
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
          ..write('categoryNumber: $categoryNumber, ')
          ..write('resultDate: $resultDate')
          ..write(')'))
        .toString();
  }
}

class $MoorResultsTable extends MoorResults
    with TableInfo<$MoorResultsTable, MoorResult> {
  final GeneratedDatabase _db;
  final String _alias;
  $MoorResultsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _resultMeta = const VerificationMeta('result');
  GeneratedIntColumn _result;
  @override
  GeneratedIntColumn get result => _result ??= _constructResult();
  GeneratedIntColumn _constructResult() {
    return GeneratedIntColumn(
      'result',
      $tableName,
      false,
    );
  }

  final VerificationMeta _questionsLenghtMeta =
      const VerificationMeta('questionsLenght');
  GeneratedIntColumn _questionsLenght;
  @override
  GeneratedIntColumn get questionsLenght =>
      _questionsLenght ??= _constructQuestionsLenght();
  GeneratedIntColumn _constructQuestionsLenght() {
    return GeneratedIntColumn(
      'questions_lenght',
      $tableName,
      false,
    );
  }

  final VerificationMeta _rightResultsPercentMeta =
      const VerificationMeta('rightResultsPercent');
  GeneratedRealColumn _rightResultsPercent;
  @override
  GeneratedRealColumn get rightResultsPercent =>
      _rightResultsPercent ??= _constructRightResultsPercent();
  GeneratedRealColumn _constructRightResultsPercent() {
    return GeneratedRealColumn(
      'right_results_percent',
      $tableName,
      false,
    );
  }

  final VerificationMeta _categoryNumberMeta =
      const VerificationMeta('categoryNumber');
  GeneratedIntColumn _categoryNumber;
  @override
  GeneratedIntColumn get categoryNumber =>
      _categoryNumber ??= _constructCategoryNumber();
  GeneratedIntColumn _constructCategoryNumber() {
    return GeneratedIntColumn(
      'category_number',
      $tableName,
      false,
    );
  }

  final VerificationMeta _resultDateMeta = const VerificationMeta('resultDate');
  GeneratedDateTimeColumn _resultDate;
  @override
  GeneratedDateTimeColumn get resultDate =>
      _resultDate ??= _constructResultDate();
  GeneratedDateTimeColumn _constructResultDate() {
    return GeneratedDateTimeColumn(
      'result_date',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        result,
        questionsLenght,
        rightResultsPercent,
        categoryNumber,
        resultDate
      ];
  @override
  $MoorResultsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'moor_results';
  @override
  final String actualTableName = 'moor_results';
  @override
  VerificationContext validateIntegrity(Insertable<MoorResult> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('result')) {
      context.handle(_resultMeta,
          result.isAcceptableOrUnknown(data['result'], _resultMeta));
    } else if (isInserting) {
      context.missing(_resultMeta);
    }
    if (data.containsKey('questions_lenght')) {
      context.handle(
          _questionsLenghtMeta,
          questionsLenght.isAcceptableOrUnknown(
              data['questions_lenght'], _questionsLenghtMeta));
    } else if (isInserting) {
      context.missing(_questionsLenghtMeta);
    }
    if (data.containsKey('right_results_percent')) {
      context.handle(
          _rightResultsPercentMeta,
          rightResultsPercent.isAcceptableOrUnknown(
              data['right_results_percent'], _rightResultsPercentMeta));
    } else if (isInserting) {
      context.missing(_rightResultsPercentMeta);
    }
    if (data.containsKey('category_number')) {
      context.handle(
          _categoryNumberMeta,
          categoryNumber.isAcceptableOrUnknown(
              data['category_number'], _categoryNumberMeta));
    } else if (isInserting) {
      context.missing(_categoryNumberMeta);
    }
    if (data.containsKey('result_date')) {
      context.handle(
          _resultDateMeta,
          resultDate.isAcceptableOrUnknown(
              data['result_date'], _resultDateMeta));
    } else if (isInserting) {
      context.missing(_resultDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MoorResult map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return MoorResult.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $MoorResultsTable createAlias(String alias) {
    return $MoorResultsTable(_db, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $MoorResultsTable _moorResults;
  $MoorResultsTable get moorResults => _moorResults ??= $MoorResultsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [moorResults];
}
