import 'package:algo_x/locators/app_colors.dart';
import 'package:algo_x/widgets/app_button.dart';
import 'package:algo_x/widgets/app_text.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  final PageController pageController;
  const FirstPage({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Stack(
        children: [
          const Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: AppText(
                text: 'Es hora de crear tu cartera.',
                textAlign: TextAlign.center,
                size: 22,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                SizedBox(
                  height: 20,
                ),
                AppText(
                  text: 'Primero vamos con tu frase de recuperación.',
                  color: AppColors.secondary,
                  textAlign: TextAlign.center,
                  size: 20,
                ),
                SizedBox(
                  height: 10,
                ),
                AppText(
                  text:
                      ' Esta tendrá una serie de 25 palabras super secretas que no debes compartir con nadie.',
                  color: AppColors.secondary,
                  textAlign: TextAlign.center,
                  size: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                AppText(
                  text: '¡Apúntalas en orden!',
                  textAlign: TextAlign.center,
                  size: 25,
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: AppButton(
                text: 'Entendido',
                onPressed: () => pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
