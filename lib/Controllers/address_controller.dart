import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../API/local_data_service.dart';
import '../Models/region_address_model.dart';

class AddressController extends GetxController {
  final LocalDataService localDataService = LocalDataService();

  // var cities = <City>[].obs;
  var regions = <Region>[].obs;
  // var districts = <District>[].obs;

  // var selectedCity = Rxn<City>();
  var selectedRegion = Rxn<Region>();
  // var selectedDistrict = Rxn<District>();

  var fullCurrentAddress = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllRegions();
  }
  //
  // void updateFullAddress() {
  //   fullCurrentAddress.value =
  //   '${buildingNumController.text}, '
  //       '${streetNameController.text}, '
  //       '${nationalNumController.text}, '
  //       '${selectedDistrict.value?.nameEn}, '
  //       '${selectedCity.value?.nameEn}, '
  //       '${selectedRegion.value?.nameEn}';
  // }

  // Method to reset fields when screen is re-entered
  void resetFields() {
    // selectedCity.value = null;
    selectedRegion.value = null;
    // selectedDistrict.value = null;
    // cities.clear();
    // districts.clear();
    // regions.clear();

    fullCurrentAddress.value = '';
  }

  // Future<void> fetchAllCities(int regionId) async {
  //   try {
  //     cities.value =await localDataService.loadCities(regionId);
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to load cities');
  //      
  //   }
  // }

  Future<void> fetchAllRegions() async {
    try {
      regions.value = await localDataService.loadRegions();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load regions');
       
    }
  }

  // Future<void> fetchAllDistricts(int cityId) async {
  //   try {
  //     districts.value =await localDataService.loadDistricts(cityId);
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to load districts');
  //      
  //   }
  // }

  // void selectCity(City city) {
  //   selectedCity.value = city;
  //   fetchAllDistricts(city.cityId); // Fetch districts based on selected city
  // }

  void selectRegion(Region region) {
    selectedRegion.value = region;
    // fetchAllCities(region.regionId); // Fetch cities based on selected region
  }

//   void selectDistrict(District district) {
//     selectedDistrict.value = district;
//   }
}