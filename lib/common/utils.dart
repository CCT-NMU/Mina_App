import 'package:flutter/material.dart';

class Utils {
  DateTime normalizedDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  EdgeInsets responsiveHorizontalPadding(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width < 600) {
      // Mobile
      return const EdgeInsets.symmetric(horizontal: 16);
    } else if (width < 1200) {
      // Tablet
      return const EdgeInsets.symmetric(horizontal: 32);
    } else {
      // Desktop
      return const EdgeInsets.symmetric(horizontal: 100);
    }
  }
}
