import 'package:drift/drift.dart';

// this will generate a table called "games" for us. The rows of that table will
// be represented by a class called "Game".
class Games extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  IntColumn get maxCount => integer()();
  TextColumn get address => text().nullable()();
  TextColumn get latitude => text().nullable()();
  TextColumn get longitude => text().nullable()();
  TextColumn get date => text()();
  TextColumn get image => text().nullable()();
}