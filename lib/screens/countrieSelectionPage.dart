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
import 'package:flutter/material.dart';
import 'package:flutter_placeholder_textlines/flutter_placeholder_textlines.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nima/nima_actor.dart';

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
  bool _noCountryChoosen = false;
  AppConfig _ac;
  List<CountryData> a = [];
  final dbHelper = DatabaseHelper.instance;
  CountryData _country = new CountryData();
  @override
  Widget build(BuildContext context) {
    _ac = AppConfig(context);
    return Container(
      decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [Color(0xff5A2776), Color(0xffFAB292)])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          margin: EdgeInsets.all(30),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 5),
                SizedBox(
                  child: NimaActor("assets/nima/logo.nima",
                      alignment: Alignment.center,
                      fit: BoxFit.contain,
                      animation: "anim1"),
                  height: 140,
                ),
                Text(
                  _noCountryChoosen == true
                      ? Languages.of(context).chooseCountry
                      : "",
                  style: TextStyle(
                      color: Colors.red[900],
                      fontSize: 20,
                      fontWeight: FontWeight.w900),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _createLanguageDropDownTest(),
                      Text(
                        Languages.of(context).information,
                        style: GoogleFonts.lemonada(
                          textStyle: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      _createCardInfos(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                                gradient: LinearGradient(colors: [
                                  Color(0xff5A2776),
                                  Color(0xffEF5370)
                                ])),
                            width: 140,
                            height: 50,
                            child: FlatButton(
                              child: Text(
                                Languages.of(context).home,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 25),
                              ),
                              onPressed: () {
                                Navigator.pop(
                                  context,
                                );
                              },
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                                gradient: LinearGradient(colors: [
                                  Color(0xffEF5370),
                                  Color(0xffFAB292)
                                ])),
                            width: 140,
                            height: 50,
                            child: FlatButton(
                              child: Text(
                                Languages.of(context).more,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 25),
                              ),
                              onPressed: () async {
                                if (_country.name != null) {
                                  Map<String, double> totalVaccinations =
                                      await API
                                          .getVaccinatedData(_country.name);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChartPage(
                                              country: _country,
                                              data: totalVaccinations,
                                            )),
                                  );
                                } else {
                                  setState(() {
                                    _noCountryChoosen = true;
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void setCountry(CountryData country) {
    setState(() {
      _country = country;
      _noCountryChoosen = false;
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

  _createLanguageDropDownTest() {
    return FutureBuilder<List<CountryData>>(
      future: dbHelper.queryAllRows().then((value) => a = value),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (a == null) {
          return DropdownButton(items: null, onChanged: null);
        } else {
          List<CountryData> items2 = new List<CountryData>.from(a);
          return Container(
            child: DropdownButton<CountryData>(
              dropdownColor: Colors.white,
              iconSize: 40,
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.white,
                size: 45,
              ),
              underline: Container(
                height: 2,
                color: Colors.white,
                margin: EdgeInsets.only(top: 10),
              ),
              hint: Row(
                children: [
                  Icon(
                    Icons.language,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10),
                  Text(
                    _country.name == null
                        ? Languages.of(context).chooseCountry
                        : _country.name,
                    style: GoogleFonts.lemonada(
                      textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
              items: items2
                  .map<DropdownMenuItem<CountryData>>(
                    (e) => DropdownMenuItem<CountryData>(
                      value: e,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            e.name,
                            style: GoogleFonts.lemonada(
                              textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff5A2776)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (CountryData value) {
                setCountry(value);
              },
            ),
          );
        }
      },
    );
  }

  _createCardInfos() {
    if (_country.name != null) {
      return Container(
        color: Colors.transparent,
        child: Center(
          child: Card(
            color: Color(0x44FAB292),
            shadowColor: Color(0x445A2776),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  child: Column(
                    children: [
                      SizedBox(
                        height: _ac.rHP(2),
                        width: 6000,
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
                      createCardElt(
                          Languages.of(context).sourcesURL, _country.sourceUrl),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container(
        color: Colors.transparent,
        child: Center(
          child: Card(
            color: Color(0x44FAB292),
            shadowColor: Color(0x445A2776),
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
        ),
      );
    }
  }

  createCardElt(String title, String content) {
    return Column(children: [
      Text(
        title,
        textAlign: TextAlign.center,
        style: GoogleFonts.lemonada(
          textStyle: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      SizedBox(
        height: _ac.rHP(1),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Text(
          content,
          style: TextStyle(color: Colors.white),
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
        style: GoogleFonts.lemonada(
          textStyle: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
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
        color: Color(0xffFAB292),
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
