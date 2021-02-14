class CountryData {
  String name;
  String code;
  String date;
  String vaccines;
  String sourceName;
  String sourceUrl;
  String totalVaccinations;
  String peopleVaccinated;
  String peopleFullyVaccinated;

  CountryData({
    this.name,
    this.date,
    this.vaccines,
    this.sourceUrl,
    this.totalVaccinations,
    this.peopleVaccinated,
    this.peopleFullyVaccinated,
    this.code,
    this.sourceName,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'date': date,
      'vaccines': vaccines,
      'sourceUrl': sourceUrl,
      'code': code,
      'sourceName': sourceName,
    };
  }
}
