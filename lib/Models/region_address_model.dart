
class Region {
  final int regionId;
  final int capitalCityId;
  final String code;
  final String nameAr;
  final String nameEn;
  final int population;

  Region({required this.regionId, required this.capitalCityId, required this.code, required this.nameAr, required this.nameEn, required this.population});

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(
      regionId: json['region_id'],
      capitalCityId: json['capital_city_id'],
      code: json['code'],
      nameAr: json['name_ar'],
      nameEn: json['name_en'],
      population: json['population'],
    );
  }
}