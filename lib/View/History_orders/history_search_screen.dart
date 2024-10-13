import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:smart_rabbit_second_app/Controllers/driver_order_controller.dart';
import 'package:smart_rabbit_second_app/Utilities/responsive_function.dart';
import 'package:smart_rabbit_second_app/View/History_orders/widgets/oder_history_item.dart';

class HistorySearchScreen extends StatelessWidget {
  final DriverOrdersController controller = Get.find();

  HistorySearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'.tr),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          SearchBarHistory(controller: controller),
          Obx(() {
            if (controller.searchResults.isEmpty) {
              // Show "Not Found" when no results
              return NotFoundPart();
            } else {
              // Search Results
              return SearchResults(controller: controller);
            }
          }),
        ],
      ),
    );
  }
}

class SearchResults extends StatelessWidget {
  const SearchResults({
    super.key,
    required this.controller,
  });

  final DriverOrdersController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Expanded(
        child: ListView.builder(
          itemBuilder: (context, index) {
            final order = controller.searchResults[index];
            return OrderHistoryItem(
              order: order,
              cardHeight: responsiveSize(context, 80, 100),
              count: index + 1,
              isWallet: true,
            );
          },
          itemCount: controller.searchResults.length,
        ),
      ),
    );
  }
}

class NotFoundPart extends StatelessWidget {
  const NotFoundPart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/rafiki.svg'),
              const SizedBox(height: 20),
              Text(
                'Not Found'.tr,
                style: TextStyle(fontSize: 3.sw, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Sorry the keyword you entered cannot be '
                          'found. Please check again or search with another keyword.'
                      .tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 2.7.sw),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchBarHistory extends StatelessWidget {
  const SearchBarHistory({
    super.key,
    required this.controller,
  });

  final DriverOrdersController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: responsiveSize(context, 3.sw, 15.sw),
        vertical: 3.sw,
      ),
      child: TextField(
        onChanged: (value) => controller.searchOrders(value),
        decoration: InputDecoration(
          hintText: 'Enter receiver name or order id', //TODO:localization
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey.shade200,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontFamily: GoogleFonts.nunito().fontFamily,
          ),
        ),
        style: TextStyle(
          color: Colors.grey,
          fontFamily: GoogleFonts.nunito().fontFamily,
        ),
      ),
    );
  }
}
