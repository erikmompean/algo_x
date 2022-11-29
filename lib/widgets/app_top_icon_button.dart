import 'package:algo_x/locators/app_colors.dart';
import 'package:flutter/material.dart';

class AppTopIconButton extends StatelessWidget {
  final IconData icon;
  final Function()? onTap;
  const AppTopIconButton({super.key, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => onTap != null ? onTap!() : null,
        child: Container(
          height: 50,
          width: 50,
          decoration: const BoxDecoration(
            color: AppColors.background2,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 30,
            color: Colors.white70,
          ),
        ),
      ),
    );
  }
}
