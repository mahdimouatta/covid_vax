import 'package:covidvax/languages/languages.dart';
import 'package:covidvax/languages/locale_constant.dart';
import 'package:covidvax/models//language_data.dart';
import 'package:covidvax/screens/countrieSelectionPage.dart';
import 'package:covidvax/services/appConfig.dart';
import 'package:covidvax/theme/style.dart' as style;
import 'package:covidvax/components/clipper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  AppConfig _ac;

  @override
  Widget build(BuildContext context) {
    _ac = AppConfig(context);
    return Scaffold(
      backgroundColor: Color(0xff5A2776),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipPath(
                  clipper: WaveClipper2(),
                  child: Container(
                    child: Column(),
                    width: double.infinity,
                    height: 450,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0x44FAB292), Color(0x44EF5370)])),
                  ),
                ),
                ClipPath(
                  clipper: WaveClipper3(),
                  child: Container(
                    child: Column(),
                    width: double.infinity,
                    height: 450,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0x88FAB292), Color(0x88EF5370)])),
                  ),
                ),
                ClipPath(
                  clipper: WaveClipper1(),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          height: 350,
                          child: Image.asset(
                            "assets/images/logo.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                    width: double.infinity,
                    height: 450,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0xff5A2776), Color(0xffFAB292)])),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin:
                        EdgeInsets.only(left: _ac.rHP(4), right: _ac.rHP(4)),
                    child: _createLanguageDropDown(),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        gradient: LinearGradient(
                            colors: [Color(0xffEF5370), Color(0xffFAB292)])),
                    width: 150,
                    height: 60,
                    child: FlatButton(
                      child: Text(
                        Languages.of(context).next,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 25),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _createLanguageDropDown() {
    return DropdownButton<LanguageData>(
      icon: Icon(
        Icons.arrow_drop_down,
        color: Colors.white,
        size: 45,
      ),
      iconSize: 40,
      hint: Row(
        children: [
          Icon(
            Icons.language,
            color: Colors.white,
            size: 25,
          ),
          SizedBox(width: 10),
          Text(
            Languages.of(context).chooseLanguage,
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
        ],
      ),
      onChanged: (LanguageData language) {
        changeLanguage(context, language.languageCode);
      },
      items: LanguageData.languageList()
          .map<DropdownMenuItem<LanguageData>>(
            (e) => DropdownMenuItem<LanguageData>(
              value: e,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    e.flag,
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(
                    e.name,
                    style: TextStyle(color: Color(0xff5A2776), fontSize: 25),
                  )
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
