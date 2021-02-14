import 'package:flutter/material.dart';

abstract class Languages {
  static Languages of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  String get applicationName;

  String get landingText;

  String get landingText2;

  String get chooseLanguage;

  String get chooseCountry;

  String get totalVaccinations;

  String get vaccines;

  String get sourcesName;

  String get sourcesURL;

  String get information;

  String get more;

  String get toVisiteTheWebsite;

  String get clickHere;

  String get lastDate;
}
