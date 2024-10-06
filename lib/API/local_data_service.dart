import 'dart:convert';
import 'package:flutter/services.dart' as rootBundle;
import '../Models/region_address_model.dart';

class LocalDataService {

  Future<List<Region>> loadRegions() async {
    try {
      final jsonString = await rootBundle.rootBundle.loadString
        ('assets/json_files/regions_lite.json');
      final List<dynamic> regionJson = json.decode(jsonString) as List<dynamic>;
      return regionJson.map((json) => Region.fromJson(json as Map<String,
          dynamic>)).toList();
    } catch (e) {
       
      throw Exception('Error loading regions');
    }
  }
  //
  // Future<List<City>> loadCities(int regionId) async {
  //   try {
  //     final jsonString = await rootBundle.rootBundle.loadString('assets/json_files/cities.json');
  //     final List<dynamic> cityJson = json.decode(jsonString) as List<dynamic>;
  //     List<City> filteredCities = cityJson
  //         .map((json) => City.fromJson(json as Map<String, dynamic>))
  //         .where((city) => city.regionId == regionId)
  //         .toList();
  //     return filteredCities;
  //   } catch (e) {
  //      
  //     throw Exception('Error loading cities');
  //   }
  // }
  //
  // Future<List<District>> loadDistricts(int cityId) async {
  //   try {
  //     final jsonString = await rootBundle.rootBundle.loadString('assets/json_files/districts_lite.json');
  //     final List<dynamic> districtJson = json.decode(jsonString) as List<dynamic>;
  //     List<District> filteredDistricts = districtJson
  //         .map((json) => District.fromJson(json as Map<String, dynamic>))
  //         .where((district) => district.cityId == cityId)
  //         .toList();
  //     return filteredDistricts ;
  //   } catch (e) {
  //      
  //     throw Exception('Error loading districts');
  //   }
  // }

}