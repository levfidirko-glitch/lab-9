import 'package:flutter/material.dart';
import 'package:flutter_application_1/constant/app_colors.dart';

class AppTextStyles {
  static final TextStyle px12Blue = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.bold,
    color: AppColors.secondary,
    fontSize: 12,
  );

  static final TextStyle superSmall = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w400,
    color: AppColors.lightGreyColor,
    fontSize: 14,
  );

  static final TextStyle px10Blue = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w400,
    color: AppColors.azure,
    fontSize: 10,
  );
}
