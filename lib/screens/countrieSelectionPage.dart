import 'package:covidvax/components/countryPopUpItem.dart';
import 'package:covidvax/components/customPopupMenuButton.dart';
import 'package:covidvax/languages/languages.dart';
import 'package:covidvax/models/countryData.dart';
import 'package:covidvax/screens/chartsPage.dart';
import 'package:covidvax/services/apiLogic.dart' as API;
import 'package:covidvax/services/appConfig.dart';
import 'package:covidvax/services/databaseHelper.dart';
import 'package:covidvax/theme/style.dart' as style;
import 'package:fl_chart/fl_chart.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_placeholder_textlines/flutter_placeholder_textlines.dart';

class Home extends StatefulWidget {
  static void setCountry(BuildContext context, CountryData countryData) {
    var state = context.findAncestorStateOfType<HomeState>();
    state.setCountry(countryData);
  }

  @override
  State<StatefulWidget> createState() => HomeState();
}

TextEditingController controllerVille = new TextEditingController();

class HomeState extends State<Home> {
  AppConfig _ac;
  List<CountryData> a = [];
  final dbHelper = DatabaseHelper.instance;
  var url =
      'https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/vaccinations/country_data/United Arab Emirates.csv';
  CountryData _country = new CountryData();

  @override
  Widget build(BuildContext context) {
    _ac = AppConfig(context);
    return MaterialApp(
      home: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/back2.png"),
                fit: BoxFit.fill)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            margin: EdgeInsets.all(30),
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: _ac.rHP(1),
                  ),
                  Flag(
                    _country != null
                        ? _country.code != null
                            ? _country.code
                                .substring(0, max(0, _country.code.length - 1))
                            : ""
                        : "",
                    height: _ac.rHP(20),
                    width: 200,
                  ),
                  Text(
                    Languages.of(context).chooseCountry,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: style.appTheme4().primaryColor),
                  ),
                  SizedBox(
                    height: _ac.rHP(1),
                  ),
                  _createLanguageDropDownTest3(),
                  SizedBox(
                    height: _ac.rHP(1),
                  ),
                  Text(
                    Languages.of(context).information,
                    style: TextStyle(
                        fontSize: 30, color: style.appTheme4().accentColor),
                    textAlign: TextAlign.center,
                  ),
                  _createCardInfos(),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: style.appTheme4().scaffoldBackgroundColor,
            onPressed: () {
              Navigator.pop(
                context,
              );
            },
            child: Icon(
              Icons.arrow_back,
              color: style.appTheme4().buttonColor,
              size: 45.0,
            ),
            elevation: 5,
          ),
        ),
      ),
    );
  }

  void setCountry(CountryData country) {
    setState(() {
      _country = country;
    });
  }

  _createLanguageDropDownTest2() {
    return FutureBuilder(
      future: API.getCountriesInfos().then((value) => a = value),
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.only(left: 10),
          child: new Row(
            children: <Widget>[
              new Expanded(
                  child: new TextField(
                      style: TextStyle(color: style.appTheme4().hintColor),
                      enabled: false,
                      controller: controllerVille)),
              new CustomPopupMenuButton<CountryData>(
                height: _ac.rHP(25),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Color(0xFF19AAB1),
                  size: 35,
                ),
                onSelected: (CountryData value) {
                  controllerVille.text = value.name;
                  setCountry(value);
                },
                itemBuilder: (BuildContext context) {
                  return a.map<PopupMenuItem<CountryData>>((CountryData value) {
                    return new PopupMenuItem(
                        child: new CountryPopUpItem(
                            name: value.name, code: value.code),
                        value: value);
                  }).toList();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  _createLanguageDropDownTest3() {
    if (a.length == 0) {
      return FutureBuilder(
        future: dbHelper.queryAllRows().then((value) => a = value),
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.only(left: 10),
            child: new CustomPopupMenuButton<CountryData>(
              height: _ac.rHP(50),
              child: Row(
                children: [
                  new Expanded(
                      child: new TextField(
                          style: TextStyle(
                              color: style.appTheme4().hintColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                          enabled: false,
                          controller: controllerVille)),
                  const Icon(
                    Icons.arrow_drop_down,
                    color: Color(0xFF19AAB1),
                    size: 35,
                  ),
                ],
              ),
              onSelected: (CountryData value) {
                controllerVille.text = value.name;
                setCountry(value);
              },
              itemBuilder: (BuildContext context) {
                return a.map<PopupMenuItem<CountryData>>((CountryData value) {
                  return new PopupMenuItem(
                      child: new CountryPopUpItem(
                          name: value.name, code: value.code),
                      value: value);
                }).toList();
              },
            ),
          );
        },
      );
    } else
      return Padding(
        padding: const EdgeInsets.only(left: 10),
        child: new CustomPopupMenuButton<CountryData>(
          height: _ac.rHP(50),
          child: Row(
            children: [
              new Expanded(
                  child: new TextField(
                      style: TextStyle(
                          color: style.appTheme4().hintColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                      enabled: false,
                      controller: controllerVille)),
              const Icon(
                Icons.arrow_drop_down,
                color: Color(0xFF19AAB1),
                size: 35,
              ),
            ],
          ),
          onSelected: (CountryData value) {
            controllerVille.text = value.name;
            setCountry(value);
          },
          itemBuilder: (BuildContext context) {
            return a.map<PopupMenuItem<CountryData>>((CountryData value) {
              return new PopupMenuItem(
                  child:
                      new CountryPopUpItem(name: value.name, code: value.code),
                  value: value);
            }).toList();
          },
        ),
      );
  }

  _createCardInfos() {
    if (_country.name != null) {
      return Center(
        child: Column(
          children: [
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: _ac.rHP(2),
                        ),
                        createCardElt(
                            Languages.of(context).vaccines, _country.vaccines),
                        SizedBox(
                          height: _ac.rHP(2),
                        ),
                        createCardElt(Languages.of(context).sourcesName,
                            _country.sourceName),
                        SizedBox(
                          height: _ac.rHP(2),
                        ),
                        createCardElt(Languages.of(context).sourcesURL,
                            _country.sourceUrl),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton.icon(
                        icon: Icon(
                          Icons.insert_chart,
                          color: style.appTheme4().dividerColor,
                        ),
                        label: Text(
                          Languages.of(context).more,
                          style: TextStyle(
                              fontSize: 20,
                              color: style.appTheme4().dividerColor),
                        ),
                        onPressed: () async {
                          Map<String, double> totalVaccinations =
                              await API.getVaccinatedData(_country.name);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChartPage(
                                      country: _country,
                                      data: totalVaccinations,
                                    )),
                          );
                        },
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Center(
        child: Card(
          margin: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    _createEmptyCardElt(Languages.of(context).vaccines),
                    SizedBox(
                      height: _ac.rHP(1),
                    ),
                    _createEmptyCardElt(Languages.of(context).sourcesName),
                    SizedBox(
                      height: _ac.rHP(1),
                    ),
                    _createEmptyCardElt(Languages.of(context).sourcesURL),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  createCardElt(String title, String content) {
    return Column(children: [
      Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(color: style.appTheme4().hintColor, fontSize: 20),
      ),
      SizedBox(
        height: _ac.rHP(1),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Text(
          content,
          textAlign: TextAlign.center,
        ),
      ),
    ]);
  }

  _createEmptyCardElt(String title) {
    return Column(children: [
      Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(color: style.appTheme4().hintColor, fontSize: 20),
      ),
      _buildAnimated(),
    ]);
  }

  _buildAnimated() {
    return Container(
      width: _ac.rWP(350),
      child: PlaceholderLines(
        align: TextAlign.center,
        count: 2,
        animate: true,
        color: Colors.grey,
      ),
    );
  }

  LineChartData sampleData1() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'SEPT';
              case 7:
                return 'OCT';
              case 12:
                return 'DEC';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '1m';
              case 2:
                return '2m';
              case 3:
                return '3m';
              case 4:
                return '5m';
            }
            return '';
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xff4e4965),
            width: 4,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 0,
      maxX: 14,
      maxY: 4,
      minY: 0,
      lineBarsData: linesBarData1(),
    );
  }

  List<LineChartBarData> linesBarData1() {
    final LineChartBarData lineChartBarData1 = LineChartBarData(
      spots: [
        FlSpot(1, 1),
        FlSpot(3, 1.5),
        FlSpot(5, 1.4),
        FlSpot(7, 3.4),
        FlSpot(10, 2),
        FlSpot(12, 2.2),
        FlSpot(13, 1.8),
      ],
      isCurved: true,
      colors: [
        const Color(0xff4af699),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    return [lineChartBarData1];
  }

  int max(a, b) {
    return a > b ? a : b;
  }
}
