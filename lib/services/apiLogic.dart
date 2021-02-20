import 'package:covidvax/models/countryData.dart';
import 'package:csv/csv.dart' as csv;
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

Future<List<List>> getData(country) async {
  String url =
      "https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/vaccinations/country_data/$country.csv";
  var response = await http.get(url);
  if (response.statusCode == 200) {
    List<List<dynamic>> myCSV = csv.CsvToListConverter(eol: "\n")
        .convert(response.body.toString(), eol: "\n");
    return myCSV;
  } else {
    return null;
  }
}

Future<Map<String, double>> getVaccinatedData(country) async {
  String url =
      "https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/vaccinations/country_data/$country.csv";
  Map<String, double> totalVaccinations = new Map<String, double>();
  var response = await http.get(url);
  if (response.statusCode == 200) {
    List<List<dynamic>> myCSV = csv.CsvToListConverter(eol: "\n")
        .convert(response.body.toString(), eol: "\n");

    for (int i = 1; i < myCSV.length; i++) {
      double value =
          myCSV[i][4] != "" ? double.parse(myCSV[i][4].toString()) : 0;
      totalVaccinations[myCSV[i][1]] = value;
    }
  }

  return totalVaccinations;
}

Future<String> getLastData(country) async {
  String url =
      "https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/vaccinations/country_data/$country.csv";
  var response = await http.get(url);
  if (response.statusCode == 200) {
    List<List<dynamic>> myCSV = csv.CsvToListConverter(eol: "\n")
        .convert(response.body.toString(), eol: "\n");
    return myCSV.last[4].toString();
  } else {
    return null;
  }
}

Future<List<CountryData>> getCountriesInfos() async {
  var url =
      "https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/vaccinations/locations.csv";
  var response = await http.get(url);
  if (response.statusCode == 200) {
    List<List<dynamic>> myCSV = csv.CsvToListConverter(eol: "\n")
        .convert(response.body.toString(), eol: "\n");
    List<CountryData> listOut = new List<CountryData>();

    for (var i = 1; i < myCSV.length; i++) {
      List<dynamic> list = myCSV[i];
      List<String> _vaccinesList = list[2].toString().split(",");
      String _vaccines = "✦ ";
      for (var i in _vaccinesList) {
        _vaccines += i + " ✦ ";
      }
      var url1 = list[5].toString();
      var sourceUrl = url1.split("/")[0] + "//" + url1.split("/")[2] + "/";
      CountryData data = new CountryData(
          name: list[0],
          code: list[1],
          vaccines: _vaccines,
          date: list[3],
          sourceName: list[4],
          sourceUrl: sourceUrl);
      listOut.add(data);
    }
    return listOut;
  } else {
    return null;
  }
}

Future<List<String>> getCountriesList() async {
  var url =
      "https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/vaccinations/locations.csv";
  var response = await http.get(url);
  if (response.statusCode == 200) {
    List<List<dynamic>> myCSV = csv.CsvToListConverter(eol: "\n")
        .convert(response.body.toString(), eol: "\n");
    List<String> listOut = new List<String>();
    for (var i = 1; i < 5; i++) {
      listOut.add(myCSV[i][0]);
    }
    return listOut;
  } else {
    return null;
  }
}

Future<List<List>> getWorldVaccinatedData(country) async {
  String url =
      "https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/vaccinations/vaccinations.csv";
  List<List> worldData = new List<List>();
  var response = await http.get(url);
  if (response.statusCode == 200) {
    List<List<dynamic>> myCSV = csv.CsvToListConverter(eol: "\n")
        .convert(response.body.toString(), eol: "\n");

    int i = myCSV.length - 1;
    while (myCSV[i][0] == "World") {
      worldData.add(myCSV[i]);
    }
  }
  return worldData;
}
