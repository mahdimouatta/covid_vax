import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:covidvax/languages/languages.dart';
import 'package:covidvax/theme/style.dart' as style;
import 'package:covidvax/models/countryData.dart';
import 'package:intl/intl.dart';
import 'package:covidvax/services/appConfig.dart';
import 'package:covidvax/screens/homePage.dart';
import 'package:google_fonts/google_fonts.dart';

class ChartPage extends StatelessWidget {
  final CountryData country;
  final Map<String, double> data;

  ChartPage({Key key, this.country, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppConfig _ac = AppConfig(context);

    return Container(
      decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [Color(0xff5A2776), Color(0xffFAB292)])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          margin: EdgeInsets.only(top: 20, right: 20, left: 10),
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: _ac.rHP(2),
                ),
                Text(
                  Languages.of(context).applicationName,
                  style: GoogleFonts.lemonada(
                    textStyle: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Text(
                  country.name,
                  style: GoogleFonts.caveat(
                    textStyle: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: _ac.rHP(3),
                ),
                SizedBox(
                  height: _ac.rHP(30),
                  width: 600,
                  child: LineChart(
                    sampleData1(),
                    swapAnimationDuration: Duration(milliseconds: 250),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _createCardInfos(context),
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()),
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
                                Languages.of(context).previous,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 25),
                              ),
                              onPressed: () async {
                                Navigator.pop(
                                  context,
                                );
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

  LineChartData sampleData1() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          getTooltipItems: (touchedSpots) {
            List<LineTooltipItem> list = new List<LineTooltipItem>();
            for (var i in touchedSpots) {
              list.add(LineTooltipItem(
                  NumberFormat.decimalPattern()
                          .format(double.parse(i.y.toString())) +
                      "  " +
                      data.keys.elementAt(i.x.toInt()),
                  TextStyle(
                    color: Color(0xff5A2776),
                  )));
            }
            return list;
          },
          tooltipBgColor: Colors.white,
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: true,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
          getTitles: (value) {
            if (value.toInt() == 0) {
              return data.keys.first;
            } else if (value.toInt() == data.keys.length - 1) {
              return data.keys.last;
            } else
              return "";
          },
          margin: 10,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
          interval:
              data.values.reduce((curr, next) => curr > next ? curr : next),
          getTitles: (value) {
            var source =
                data.values.reduce((curr, next) => curr > next ? curr : next);
            if (value.toInt() == source.toInt()) {
              return NumberFormat.compact()
                  .format(double.parse(source.toString()));
            } else if (value.toInt() == 0) {
              return "0";
            } else
              return "";
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(
            color: Colors.white,
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
      maxX: data.keys.length.toDouble(),
      maxY: data.values.reduce((curr, next) => curr > next ? curr : next),
      minY: 0,
      lineBarsData: linesBarData1(),
    );
  }

  List<FlSpot> getSpots() {
    List<FlSpot> spots = new List<FlSpot>();
    double i = 0;
    for (var value in data.values) {
      spots.add(FlSpot(i, value.toDouble()));
      i++;
    }
    return spots;
  }

  List<LineChartBarData> linesBarData1() {
    final LineChartBarData lineChartBarData1 = LineChartBarData(
      spots: getSpots(),
      isCurved: true,
      colors: [
        Colors.white12,
        Colors.white10,
        Colors.white,
      ],
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: true,
        colors: [
          Color(0x44FAB292),
          Color(0x66FAB292),
          Color(0x99AF60A6),
          Color(0xFFAF60A6),
          Color(0xDD5A2776),
          Color(0xFF5A2776),
        ],
      ),
    );
    return [lineChartBarData1];
  }

  createCardNumElt(String title, String content) {
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
        height: 15,
      ),
      Text(
        NumberFormat.decimalPattern().format(double.parse(content)),
        style: TextStyle(color: Colors.white, fontSize: 18),
        textAlign: TextAlign.center,
      ),
    ]);
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
        height: 15,
      ),
      Text(
        content,
        style: TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      ),
    ]);
  }

  _createCardInfos(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: Column(
          children: [
            Card(
              color: Color(0x44FAB292),
              shadowColor: Color(0x445A2776),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: [
                        Row(),
                        SizedBox(
                          height: 15,
                        ),
                        createCardElt(Languages.of(context).lastDate,
                            data.keys.last.toString()),
                        SizedBox(
                          height: 15,
                        ),
                        createCardNumElt(
                            Languages.of(context).totalVaccinations,
                            data.values
                                .reduce(
                                    (curr, next) => curr > next ? curr : next)
                                .toString()),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  int max(a, b) {
    return a > b ? a : b;
  }
}
