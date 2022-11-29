import 'package:algo_x/locators/app_colors.dart';
import 'package:algo_x/utils/navigator_service.dart';
import 'package:algo_x/widgets/app_text.dart';
import 'package:flutter/material.dart';

import 'app_top_icon_button.dart';

class AppTopBar extends StatelessWidget {
  final List<Widget>? rightChildrens;
  final bool hasBackButton;
  const AppTopBar({super.key, this.rightChildrens, this.hasBackButton = true});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                children: [
                  Visibility(
                    visible: hasBackButton,
                    child: AppTopIconButton(
                      icon: Icons.keyboard_arrow_left,
                      onTap: () => NavigationService.instance.goback(),
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(
              child: AppText(
                text: 'Crear Cartera',
                textAlign: TextAlign.center,
                color: AppColors.text,
                size: 18,
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: rightChildrens ?? [],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
