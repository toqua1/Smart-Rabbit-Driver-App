import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:smart_rabbit_second_app/Utilities/responsive_function.dart';
import '../../Controllers/wallet_controller.dart';
import '../../Utilities/app_styles.dart';
import '../Home/widgets/order_item.dart';

class SearchScreen extends StatelessWidget {
  final WalletHistoryController controller = Get.find();

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'.tr),
        centerTitle: true,
      ),
      // Ensure the body resizes when the keyboard appears
      resizeToAvoidBottomInset: true,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                // Search Bar
                SearchBarWallet(controller: controller),
                const SizedBox(height: 20),
              ],
            ),
          ),
          // Divider
          SliverToBoxAdapter(
            child: DividerPart(controller: controller),
          ),
          SliverToBoxAdapter(
            child: const Divider(indent: 25, endIndent: 25),
          ),
          SliverToBoxAdapter(
            child: const SizedBox(height: 10),
          ),
          Obx(() {
            if (controller.searchText.isEmpty) {
              // Show recent searches when search bar is empty
              if (controller.recentSearches.isEmpty) {
                return SliverFillRemaining(
                  child: Center(
                    child: Text(
                      'No recent searches'.tr,
                      style: TextStyle(fontSize: 3.sw),
                    ),
                  ),
                );
              } else {
                // Recent Searches
                return RecentSearches(controller: controller);
              }
            } else if (controller.searchResults.isEmpty) {
              // Show "Not Found" when no results
              return const SliverFillRemaining(child: NotFoundPart());
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

  final WalletHistoryController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final order = controller.searchResults[index];
            return OrderItem(
              order: order,
              cardHeight: responsiveSize(context, 80, 100),
              count: index + 1,
              isWallet: true,
            );
          },
          childCount: controller.searchResults.length,
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
    return Center(
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
    );
  }
}

class RecentSearches extends StatelessWidget {
  const RecentSearches({
    super.key,
    required this.controller,
  });

  final WalletHistoryController controller;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final order = controller.recentSearches[index];
          return OrderItem(
            order: order,
            cardHeight: responsiveSize(context, 80, 100),
            count: index + 1,
            isWallet: true,
          );
        },
        childCount: controller.recentSearches.length,
      ),
    );
  }
}

class DividerPart extends StatelessWidget {
  const DividerPart({
    super.key,
    required this.controller,
  });

  final WalletHistoryController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: controller.searchText.isEmpty
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent'.tr,
                    style: Styles.styleBold16Black,
                  ),
                  TextButton(
                      onPressed: () => controller.clearSearchHistory(),
                      child: Text(
                        'Clear All'.tr,
                        style: Styles.styleBold16Black,
                      )),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${'Results for '.tr} \"${controller.searchText.value}\"',
                    style: Styles.styleBold16Black,
                  ),
                  TextButton(
                      onPressed: () => controller.clearSearchHistory(),
                      child: Text(
                        '${'found '.tr} \"${controller.searchResults.length}\"',
                        style: Styles.style14GreyBold,
                      )),
                ],
              ),
      ),
    );
  }
}

class SearchBarWallet extends StatelessWidget {
  const SearchBarWallet({
    super.key,
    required this.controller,
  });

  final WalletHistoryController controller;

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
          hintText: 'Enter Order ID'.tr,
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
