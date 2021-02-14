import 'package:covidvax/models/countryData.dart';
import 'package:covidvax/screens/landingPage.dart';
import 'package:covidvax/screens/countrieSelectionPage.dart';
import 'package:flutter/material.dart';
import './theme/style.dart';
import './languages/locale_constant.dart';
import 'languages/localisations_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:covidvax/services/apiLogic.dart' as API;
import 'package:covidvax/services/databaseHelper.dart';

Future<void> main() async {
  runApp(MyHomePage());
  final dbHelper = DatabaseHelper.instance;
  List<CountryData> list = await API.getCountriesInfos();
  list.forEach((country) {
    dbHelper.insert(country);
  });
}

class MyHomePage extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MyHomePageState>();
    state.setLocale(newLocale);
  }

  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Locale _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() async {
    getLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  var url =
      'https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/vaccinations/country_data/United Arab Emirates.csv';
  var a;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme4(),
      builder: (context, child) {
        return MediaQuery(
          child: child,
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        );
      },
      locale: _locale,
      supportedLocales: [Locale('en', ''), Locale('ar', ''), Locale('fr', '')],
      localizationsDelegates: [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale?.languageCode == locale?.languageCode &&
              supportedLocale?.countryCode == locale?.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales?.first;
      },
      home: LandingPage(),
    );
  }
}
