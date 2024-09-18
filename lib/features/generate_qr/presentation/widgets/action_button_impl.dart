import 'package:flutter/material.dart';

class ActionButtonImpl extends StatelessWidget {
  const ActionButtonImpl({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.title,
  });
  final Function()? onPressed;
  final Widget icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 34),
      child: ElevatedButton.icon(
        icon: icon,
        onPressed: onPressed,
        label: Text(title),
      ),
    );
  }
}
