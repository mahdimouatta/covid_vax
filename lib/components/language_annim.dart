import 'package:flutter/material.dart';
import 'package:smart_flare/smart_flare.dart';

abstract class FlareAnimation {
  static Widget lang(var from, var to) {
    switch (from) {
      case 'ar':
        switch (to) {
          case 'fr':
            return SmartFlareActor(
              width: 300,
              height: 300,
              filename: 'assets/flare/ar_fr_eng.flr',
              startingAnimation: 'artofr',
            );
            break;
          case 'en':
            return SmartFlareActor(
              width: 300,
              height: 300,
              filename: 'assets/flare/ar_fr_eng.flr',
              startingAnimation: 'artoen',
            );
            break;
          default:
            return SmartFlareActor(
              width: 300,
              height: 300,
              filename: 'assets/flare/ar_fr_eng.flr',
              startingAnimation: 'ar',
            );
            break;
        }
        break;
      case 'fr':
        switch (to) {
          case 'ar':
            return SmartFlareActor(
              width: 300,
              height: 300,
              filename: 'assets/flare/ar_fr_eng.flr',
              startingAnimation: 'frtoar',
            );
            break;
          case 'en':
            return SmartFlareActor(
              width: 300,
              height: 300,
              filename: 'assets/flare/ar_fr_eng.flr',
              startingAnimation: 'frtoen',
            );
            break;
          default:
            return SmartFlareActor(
              width: 300,
              height: 300,
              filename: 'assets/flare/ar_fr_eng.flr',
              startingAnimation: 'fr',
            );
            break;
        }
        break;
      default:
        switch (to) {
          case 'ar':
            return SmartFlareActor(
              width: 300,
              height: 300,
              filename: 'assets/flare/ar_fr_eng.flr',
              startingAnimation: 'entoar',
            );
            break;
          case 'fr':
            return SmartFlareActor(
              width: 300,
              height: 300,
              filename: 'assets/flare/ar_fr_eng.flr',
              startingAnimation: 'entofr',
            );
            break;
          default:
            return SmartFlareActor(
              width: 300,
              height: 300,
              filename: 'assets/flare/ar_fr_eng.flr',
              startingAnimation: 'en',
            );
            break;
        }
        break;
    }
  }
}
