import 'package:flutter/material.dart';
import 'package:qr_reader/core/utils/colors.dart';

class GenerateQrContentContainer extends StatelessWidget {
  const GenerateQrContentContainer({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        color: Colors.black54,
        border: Border.symmetric(
          horizontal: BorderSide(
            color: AppColors.primary,
          ),
        ),
      ),
      child: child,
    );
  }
}
