import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'moor_database.g.dart';

class MoorResults extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get result => integer()();
  IntColumn get questionsLenght => integer()();
  RealColumn get rightResultsPercent => real()();
  IntColumn get categoryNumber => integer()();
  DateTimeColumn get resultDate => dateTime()();
}

@UseMoor(tables: [MoorResults])
class MyDatabase extends _$MyDatabase {
  MyDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite', logStatements: true,));

  @override
  int get schemaVersion => 1;

  Future<List<MoorResult>> getAllMoorResults() => select(moorResults).get();

  Stream<List<MoorResult>> watchAllResults() => select(moorResults).watch();

  Future insertMoorResult(MoorResult moorResult) =>
      into(moorResults).insert(moorResult);

  Future updateMoorResult(MoorResult moorResult) =>
      update(moorResults).replace(moorResult);

  Future deleteMoorResult(MoorResult moorResult) =>
      delete(moorResults).delete(moorResult);

  Future<void> clearMyDatabase() {
    return transaction(() async {
      for (var table in allTables) {
        await delete(table).go();
      }
    });
  }
}
