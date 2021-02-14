import 'package:flutter/material.dart';

import 'language_ar.dart';
import 'language_en.dart';
import 'language_fr.dart';
import 'languages.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<Languages> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'ar', 'fr'].contains(locale.languageCode);

  @override
  Future<Languages> load(Locale locale) => _load(locale);

  static Future<Languages> _load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
        return LanguageEn();
      case 'ar':
        return LanguageAR();
      case 'fr':
        return LanguageFR();
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate<Languages> old) => false;
}
