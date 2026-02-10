import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFFE8713A);      // Orange from reference
  static const Color primaryDark = Color(0xFFD4612E);
  static const Color primaryLight = Color(0xFFFFF3ED);
  static const Color secondary = Color(0xFF2D2D2D);
  static const Color background = Color(0xFFF8F8F8);
  static const Color white = Colors.white;
  static const Color black = Color(0xFF1A1A1A);
  static const Color grey = Color(0xFF9E9E9E);
  static const Color lightGrey = Color(0xFFEEEEEE);
  static const Color green = Color(0xFF4CAF50);
  static const Color red = Color(0xFFE53935);
  static const Color starYellow = Color(0xFFFFC107);
}

class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );
  static const TextStyle subheading = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );
  static const TextStyle body = TextStyle(
    fontSize: 14,
    color: AppColors.black,
  );
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    color: AppColors.grey,
  );
  static const TextStyle price = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );
}
