import 'package:covidvax/models/countryData.dart';
import 'package:sqflite/sqflite.dart';

Future<void> insertCountryData(CountryData countryData, database) async {
  // Get a reference to the database.
  final Database db = await database;

  await db.insert(
    'country',
    countryData.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<CountryData>> countries(database) async {
  // Get a reference to the database.
  final Database db = await database;

  // Query the table for all The Dogs.
  final List<Map<String, dynamic>> maps = await db.query('dogs');
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
