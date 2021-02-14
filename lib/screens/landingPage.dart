import 'package:covidvax/languages/languages.dart';
import 'package:covidvax/languages/locale_constant.dart';
import 'package:covidvax/models//language_data.dart';
import 'package:covidvax/screens/countrieSelectionPage.dart';
import 'package:covidvax/services/appConfig.dart';
import 'package:covidvax/theme/style.dart' as style;
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  AppConfig _ac;

  @override
  Widget build(BuildContext context) {
    _ac = AppConfig(context);
    return MaterialApp(
      home: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.fill)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            margin: EdgeInsets.only(
                top: _ac.rHP(5), left: _ac.rHP(4), right: _ac.rHP(4)),
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: _ac.rHP(3),
                  ),
                  Text(
                    Languages.of(context).applicationName,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: style.appTheme4().primaryColor,
                    ),
                  ),
                  SizedBox(
                    height: _ac.rHP(3),
                  ),
                  Text(
                    Languages.of(context).landingText,
                    style: TextStyle(
                        fontSize: 16, color: style.appTheme4().accentColor),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: _ac.rHP(3)),
                  Text(
                    Languages.of(context).landingText2,
                    style: TextStyle(
                        fontSize: 16, color: style.appTheme4().accentColor),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: _ac.rHP(50),
                  ),
                  _createLanguageDropDown(),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: style.appTheme4().scaffoldBackgroundColor,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            },
            child: Icon(
              Icons.play_circle_outline,
              color: style.appTheme4().buttonColor,
              size: 45.0,
            ),
            elevation: 5,
          ),
        ),
      ),
    );
  }

  _createLanguageDropDown() {
    return DropdownButton<LanguageData>(
      icon: Icon(
        Icons.arrow_drop_down,
        color: style.appTheme4().hintColor,
        size: 35,
      ),
      iconSize: 30,
      hint: Row(
        children: [
          Icon(
            Icons.language,
            color: style.appTheme4().hintColor,
          ),
          SizedBox(width: 10),
          Text(
            Languages.of(context).chooseLanguage,
            style: TextStyle(fontSize: 25, color: style.appTheme4().hintColor),
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
                    style: TextStyle(color: style.appTheme4().hintColor),
                  )
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
