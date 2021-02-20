import 'dart:io';

import 'package:covidvax/models/countryData.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "covidvax.db";
  static final _databaseVersion = 1;

  static final table = 'countries';

  static final columnCode = 'code';
  static final columnName = 'name';
  static final columnVaccines = 'vaccines';
  static final columnSourceUrl = 'sourceUrl';
  static final columnSourceName = 'sourceName';
  static final columnDate = 'date';

  // make this a singleton class
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    var documentsDirectory = await getDatabasesPath();
    String path = join(documentsDirectory, _databaseName);
//    await deleteDatabase(path);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE if not exists $table (
            $columnCode TEXT ,
            $columnName TEXT PRIMARY KEY,
            $columnDate TEXT ,
            $columnSourceName TEXT ,
            $columnSourceUrl TEXT ,
            $columnVaccines TEXT
          )
          ''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(CountryData countryData) async {
    print("insert insert");
    Database db = await instance.database;
    return await db.insert(table, countryData.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<CountryData>> queryAllRows() async {
    print("fetch fetch");
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('countries');
    return List.generate(maps.length, (i) {
      return CountryData(
        code: maps[i]['code'],
        name: maps[i]['name'],
        date: maps[i]['date'],
        vaccines: maps[i]['vaccines'],
        sourceName: maps[i]['sourceName'],
        sourceUrl: maps[i]['sourceUrl'],
      );
    });
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnName];
    return await db
        .update(table, row, where: '$columnName = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnName = ?', whereArgs: [id]);
  }
}
