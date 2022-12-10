import 'package:algo_x/locators/app_colors.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final double textSize;
  final double padding;
  final Color? color;
  final FontWeight fontWeight;
  final void Function()? onPressed;

  const AppButton({
    super.key,
    required this.text,
    this.textSize = 20,
    this.padding = 12,
    this.fontWeight = FontWeight.w400,
    this.color,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: TextButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        padding: EdgeInsets.all(padding),
        textStyle: TextStyle(fontSize: textSize, fontWeight: fontWeight),
        shape: const StadiumBorder(),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Text(
          text,
          style: const TextStyle(color: AppColors.text),
        ),
      ),
    );
  }
}
