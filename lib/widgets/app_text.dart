import 'package:crypto_x/locators/app_colors.dart';
import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final double? size;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  const AppText({
    super.key,
    required this.text,
    this.size,
    this.fontWeight,
    this.color,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: size,
        color: color ?? AppColors.primary,
        fontWeight: fontWeight ?? FontWeight.w600,
      ),
    );
  }
}
