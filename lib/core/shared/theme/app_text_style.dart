import 'package:flutter/material.dart';
import 'package:trips_simulator/core/shared/theme/color_style.dart';
import 'package:trips_simulator/core/shared/theme/fonts_app_style.dart';

class AppTextStyle {
  static TextStyle text = const TextStyle(
    fontSize: 16,
    fontFamily: FontAppStyle.montserrat,
    fontWeight: FontWeight.w400,
    color: AppColors.black50,
  );

  static TextStyle textButton = const TextStyle(
    fontSize: 18,
    fontFamily: FontAppStyle.montserrat,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
  );

  static TextStyle textTitleCommon = const TextStyle(
    fontSize: 14,
    fontFamily: FontAppStyle.montserrat,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
  );

  static TextStyle textCardService = const TextStyle(
    fontSize: 12,
    fontFamily: FontAppStyle.montserrat,
    fontWeight: FontWeight.w600,
    color: AppColors.blackTitle,
  );
}
