import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:covidvax/languages/languages.dart';
import 'package:covidvax/theme/style.dart' as style;
import 'package:flag/flag.dart';
import 'package:covidvax/models/countryData.dart';
import 'package:intl/intl.dart';
import 'package:covidvax/services/appConfig.dart';

class ChartPage extends StatelessWidget {
  final CountryData country;
  final Map<String, double> data;

  ChartPage({Key key, this.country, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppConfig _ac = AppConfig(context);

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
                    height: _ac.rHP(2),
                  ),
                  Text(
                    Languages.of(context).applicationName,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: style.appTheme4().primaryColor),
                  ),
                  Flag(
                    country != null
                        ? country.code != null
                            ? country.code
                                .substring(0, max(0, country.code.length - 1))
                            : ""
                        : "",
                    height: _ac.rHP(20),
                    width: _ac.rHP(50),
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
                  _createCardInfos(context),
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
                  TextStyle(color: style.appTheme4().hintColor)));
            }
            return list;
          },
          tooltipBgColor: style.appTheme4().scaffoldBackgroundColor,
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
            color: style.appTheme4().hintColor,
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
            color: style.appTheme4().hintColor,
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
            color: Colors.black,
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
      colors: [Colors.red, Colors.deepOrange, Colors.yellow, Colors.green],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: true,
      ),
      belowBarData: BarAreaData(
        show: true,
        colors: [Colors.red, Colors.deepOrange, Colors.yellow, Colors.green],
      ),
    );
    return [lineChartBarData1];
  }

  createCardNumElt(String title, String content) {
    return Column(children: [
      Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(color: style.appTheme4().hintColor, fontSize: 20),
      ),
      SizedBox(
        height: 15,
      ),
      Text(
        NumberFormat.decimalPattern().format(double.parse(content)),
        textAlign: TextAlign.center,
      ),
    ]);
  }

  createCardElt(String title, String content) {
    return Column(children: [
      Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(color: style.appTheme4().hintColor, fontSize: 20),
      ),
      SizedBox(
        height: 15,
      ),
      Text(
        content,
        textAlign: TextAlign.center,
      ),
    ]);
  }

  _createCardInfos(BuildContext context) {
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
                              .reduce((curr, next) => curr > next ? curr : next)
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
    );
  }

  int max(a, b) {
    return a > b ? a : b;
  }
}
