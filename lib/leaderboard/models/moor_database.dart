// import 'package:moor/moor.dart';
// import 'package:moor_flutter/moor_flutter.dart';

import 'package:drift/drift.dart';

import '../../registration/models/hive_user_data.dart';

import 'dart:io';

import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'moor_database.g.dart';

class MoorResults extends Table {
  IntColumn? get id => integer().autoIncrement()();
  TextColumn? get name => text()();
  IntColumn? get result => integer()();
  IntColumn? get questionsLenght => integer()();
  RealColumn? get rightResultsPercent => real()();
  IntColumn? get category => intEnum<Category>()();
  DateTimeColumn? get resultDate => dateTime()();
}

@DriftDatabase(tables: [MoorResults])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<MoorResult>> getAllMoorResults() => select(moorResults).get();

  Stream<List<MoorResult>> watchAllResults() => select(moorResults).watch();

  Future insertMoorResult(MoorResult moorResult) =>
      into(moorResults).insert(moorResult);

  Future insertMoorResultCompanion(MoorResultsCompanion moorResultCompanion) =>
      into(moorResults).insert(moorResultCompanion);

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

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

/////////////////////////////////////////////
///
///
///
// import 'package:moor/moor.dart';
// import 'package:moor_flutter/moor_flutter.dart';

// import '../../registration/models/hive_user_data.dart';

// part 'moor_database.g.dart';

// class MoorResults extends Table {
//   IntColumn? get id => integer().autoIncrement()();
//   TextColumn? get name => text()();
//   IntColumn? get result => integer()();
//   IntColumn? get questionsLenght => integer()();
//   RealColumn? get rightResultsPercent => real()();
//   IntColumn? get category => intEnum<Category>()();
//   DateTimeColumn? get resultDate => dateTime()();
// }

// @UseMoor(tables: [MoorResults])
// class MyDatabase extends _$MyDatabase {
//   MyDatabase()
//       : super(FlutterQueryExecutor.inDatabaseFolder(
//           path: 'db.sqlite',
//           logStatements: true,
//         ));

//   @override
//   int get schemaVersion => 1;

//   Future<List<MoorResult>> getAllMoorResults() => select(moorResults).get();

//   Stream<List<MoorResult>> watchAllResults() => select(moorResults).watch();

//   Future insertMoorResult(MoorResult moorResult) =>
//       into(moorResults).insert(moorResult);

//   Future insertMoorResultCompanion(MoorResultsCompanion moorResultCompanion) =>
//       into(moorResults).insert(moorResultCompanion);

//   Future updateMoorResult(MoorResult moorResult) =>
//       update(moorResults).replace(moorResult);

//   Future deleteMoorResult(MoorResult moorResult) =>
//       delete(moorResults).delete(moorResult);

//   Future<void> clearMyDatabase() {
//     return transaction(() async {
//       for (var table in allTables) {
//         await delete(table).go();
//       }
//     });
//   }
// }
