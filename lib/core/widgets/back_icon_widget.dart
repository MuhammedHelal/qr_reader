import 'package:flutter/material.dart';
import 'package:qr_reader/core/utils/colors.dart';

class BackIconWidget extends StatelessWidget {
  const BackIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: AppColors.blackGreyish,
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: Colors.black26,
            ),
          ],
        ),
        child: const Icon(
          size: 25,
          color: AppColors.primary,
          Icons.arrow_back_ios_new,
        ),
      ),
    );
  }
}
