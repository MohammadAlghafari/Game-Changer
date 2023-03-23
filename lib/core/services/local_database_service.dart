// To open the database, add these imports to the existing file defining the
// database class. They are used to open the database.
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'game_table.dart';

part 'local_database_service.g.dart';

@DriftDatabase(tables: [
  Games,
])
class MyDatabase extends _$MyDatabase {
  // we tell the database where to store the data with this constructor
  MyDatabase._privateConstructor() : super(_openConnection());

  static final MyDatabase _instance = MyDatabase._privateConstructor();

  factory MyDatabase() {
    return _instance;
  }

  // you should bump this number whenever you change or add a table definition.
  // Migrations are covered later in the documentation.
  @override
  int get schemaVersion => 1;

  ///[getGamesFromDB] to retrive games from db
  Future<List<Game>> getGamesFromDB() {
    return select(games).get();
  }

  ///[insertOrUpdateGamesIntoDB] to insert or update if exist game into db
  Future<int> insertOrUpdateGamesIntoDB(Game game) {
    return into(games).insertOnConflictUpdate(game);
  }

  ///[deleteGameFromDB] to delete the maching game from db
  Future<int> deleteGameFromDB(int gameId) {
    return (delete(games)..where((game) => game.id.equals(gameId))).go();
  }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
