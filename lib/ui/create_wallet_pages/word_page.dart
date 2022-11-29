import 'package:algo_x/locators/app_colors.dart';
import 'package:algo_x/widgets/app_button.dart';
import 'package:algo_x/widgets/app_text.dart';
import 'package:flutter/material.dart';

class WordPage extends StatelessWidget {
  final PageController pageController;
  final int wordNumber;
  final String word;

  const WordPage({
    super.key,
    required this.pageController,
    required this.wordNumber,
    required this.word,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Row(
              children: const [
                AppText(
                  text: 'Palabra:',
                  textAlign: TextAlign.left,
                  size: 30,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                  color: AppColors.background2,
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 50),
                child: Column(
                  children: [
                    AppText(
                      text: '$wordNumber - $word',
                      size: 26,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: AppButton(
                  text: 'Siguiente',
                  onPressed: () => pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.fastOutSlowIn),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
