import 'package:flutter/cupertino.dart';
import 'package:responsive_builder/responsive_builder.dart';

double responsiveSize(BuildContext context, double mobileSize, double tabletSize) {
  return getValueForScreenType<double>(
    context: context,
    mobile: mobileSize,
    tablet: tabletSize,
  );
}