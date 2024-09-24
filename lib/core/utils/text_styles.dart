import 'package:flutter/material.dart';
import 'package:qr_reader/core/utils/colors.dart';

abstract class AppTextStyles {
  static const TextStyle primary24W600 = TextStyle(
    color: AppColors.primary,
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle white24W500 = TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.w500,
  );
}
