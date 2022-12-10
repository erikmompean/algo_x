import 'package:algo_x/locators/app_colors.dart';
import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final double? size;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final int? maxLines;
  final bool? softWrap;
  const AppText({
    super.key,
    required this.text,
    this.textOverflow,
    this.size,
    this.softWrap,
    this.maxLines,
    this.fontWeight,
    this.color,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: textOverflow,
      maxLines: maxLines,
      softWrap: softWrap,
      style: TextStyle(
        fontSize: size,
        color: color ?? AppColors.text,
        fontWeight: fontWeight ?? FontWeight.w600,
      ),
    );
  }
}
