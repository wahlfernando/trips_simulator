import 'package:flutter/material.dart';
import 'package:trips_simulator/core/shared/theme/color_style.dart';

class AppTextStyle {
  static TextStyle text = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.black50,
  );

  static TextStyle textCard = const TextStyle(
    fontSize: 12,
    color: AppColors.black,
    fontWeight: FontWeight.w500,
  );

  static TextStyle titleCustonBar = const TextStyle(
    color: AppColors.blackTitle,
    fontSize: 30,
    fontWeight: FontWeight.w700,
  );

  static TextStyle textButton = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
  );

  static TextStyle textTitleCommon = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
  );

  static TextStyle numberCard = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );
}
