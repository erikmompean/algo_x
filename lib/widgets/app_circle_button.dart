import 'package:algo_x/locators/app_colors.dart';
import 'package:flutter/material.dart';

class AppCircleButton extends StatelessWidget {
  final IconData icon;
  final double size;
  final double padding;
  final Color? color;
  final FontWeight fontWeight;
  final void Function()? onPressed;

  const AppCircleButton({
    super.key,
    required this.icon,
    this.size = 20,
    this.padding = 12,
    this.fontWeight = FontWeight.w400,
    this.color,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: EdgeInsets.all(padding),
        backgroundColor: AppColors.primary,
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: size,
      ),
    );
  }
}
