import 'package:algo_x/locators/app_colors.dart';
import 'package:algo_x/widgets/app_text.dart';
import 'package:flutter/material.dart';

class AppExpandableText extends StatefulWidget {
  const AppExpandableText({super.key});

  @override
  State<AppExpandableText> createState() => AppExpandableTextState();
}

class AppExpandableTextState extends State<AppExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: AppColors.background2,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (() => setState(() => isExpanded = !isExpanded)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Icon(Icons.keyboard_arrow_down, color: AppColors.primary,),
                    AppText(
                      text: 'Prueba',
                      size: 20,
                    ),
                    Icon(Icons.keyboard_arrow_down, color: AppColors.primary,),
                  ],
                ),
              ),
              Visibility(
                visible: isExpanded,
                child: const AppText(
                  text: 'Prueba2',
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
