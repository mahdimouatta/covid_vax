import 'languages.dart';

class LanguageFR extends Languages {
  @override
  String get applicationName => "Vaccination covid 19 ";

  @override
  String get landingText =>
      "Sur cette application, vous trouverez des informations et des chiffres sur l'avancement de la compagne de vaccination autour du monde.";

  String get landingText2 =>
      "Les données utilisées sont collectées par \"Our World in Data\".";

  @override
  String get chooseLanguage => "Choisir une langue";

  @override
  String get chooseCountry => "Choisir un pays";

  @override
  String get sourcesName => "Source";

  @override
  String get vaccines => "Vaccin approuvé";

  @override
  String get totalVaccinations => "Nombre total de vaccinations";

  @override
  String get information => "Informations";

  @override
  String get more => "plus";

  @override
  String get sourcesURL => "URL de la source";

  @override
  String get toVisiteTheWebsite => "pour visiter l'URL";

  @override
  String get clickHere => "click ici";

  @override
  String get lastDate => "Date de la dernière extraction";
}
