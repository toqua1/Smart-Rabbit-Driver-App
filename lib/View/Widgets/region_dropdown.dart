import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';
import '../../Controllers/address_controller.dart';
import '../../Models/region_address_model.dart';

class RegionDropdown extends StatelessWidget {
  final AddressController _addressController;
  // final TextEditingController _regionSearchController;

  const RegionDropdown({super.key,
    required AddressController addressController,
    // required TextEditingController regionSearchController,
  })  : _addressController = addressController ;
        // _regionSearchController = regionSearchController;

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => DropdownButtonHideUnderline(
        child: DropdownButton2<Region>(
          style: TextStyle(color: Theme.of(context).primaryColor),
          isExpanded: true,
          hint: Row(
            children: [
              SvgPicture.asset('assets/Vector.svg'),
              const SizedBox(width: 15),
              Text(
                'In which region?'.tr,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          items: _addressController.regions.map((region) {
            return DropdownMenuItem<Region>(
              value: region,
              child: Text(
                Get.locale?.languageCode == 'ar'
                    ? region.nameAr
                    : region.nameEn,
                style: const TextStyle(fontSize: 14),
              ),
            );
          }).toList(),
          value: _addressController.selectedRegion.value,
          onChanged: (Region? value) {
            if (value != null) {
              if (_addressController.selectedRegion.value == value) {
                _addressController.selectedRegion.value = null;
                // _addressController.cities.clear();
              } else {
                _addressController.selectRegion(value);
                // _addressController.fetchAllCities(value.regionId);
              }
            }
          },
          buttonStyleData: _dropdownButtonStyle(context),
          dropdownStyleData: _dropdownStyle(),
          iconStyleData: _iconStyle(context),
          menuItemStyleData: _menuItemStyle(),
          // dropdownSearchData: DropdownSearchData(
          //   searchController: _regionSearchController,
          //   searchInnerWidgetHeight: 50,
          //   searchInnerWidget: Container(
          //     height: 50,
          //     padding: const EdgeInsets.only(
          //       top: 8,
          //       bottom: 4,
          //       right: 8,
          //       left: 8,
          //     ),
          //     child: TextFormField(
          //       expands: true,
          //       maxLines: null,
          //       controller: _regionSearchController,
          //       decoration: InputDecoration(
          //         isDense: true,
          //         contentPadding: const EdgeInsets.symmetric(
          //           horizontal: 10,
          //           vertical: 8,
          //         ),
          //         hintText: 'Search for a region...',
          //         hintStyle: const TextStyle(fontSize: 12),
          //         suffixIcon: const Icon(Icons.search_rounded),
          //         border: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(8),
          //         ),
          //         focusedBorder: OutlineInputBorder(
          //           borderSide: BorderSide(
          //             color: Theme.of(context).primaryColor, width: 2.0,
          //           ),
          //           borderRadius: BorderRadius.circular(10),
          //         ),
          //       ),
          //     ),
          //   ),
          //   searchMatchFn: (item, searchValue) {
          //     return item.value!.nameEn.contains(searchValue);
          //   },
          // ),
          // onMenuStateChange: (isOpen) {
          //   if (!isOpen) {
          //     _regionSearchController.clear();
          //   }
          // },
        ),
      ),
    );
  }


  ButtonStyleData _dropdownButtonStyle(BuildContext context) {
    return ButtonStyleData(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      elevation: 2,
    );
  }

  DropdownStyleData _dropdownStyle() {
    return DropdownStyleData(
      maxHeight: 250,
      scrollbarTheme: ScrollbarThemeData(
        radius:const Radius.circular(15),
        thickness: WidgetStateProperty.all(6)
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16)
      ),
    );
  }

  IconStyleData _iconStyle(BuildContext context) {
    return IconStyleData(
      icon: const Icon(Iconsax.arrow_up_2),
      openMenuIcon: const Icon(Iconsax.arrow_down_1),
      iconSize: 17,
      iconEnabledColor: Theme.of(context).primaryColor,
      iconDisabledColor: Colors.grey,
    );
  }

  MenuItemStyleData _menuItemStyle() {
    return const MenuItemStyleData(
      height: 40,
    );
  }
}