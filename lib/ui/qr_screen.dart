import 'package:algo_x/locators/app_colors.dart';
import 'package:algo_x/widgets/app_text.dart';
import 'package:algo_x/widgets/app_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrScreen extends StatelessWidget {
  final String address;
  const QrScreen({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const AppTopBar(
              title: 'Mi QR',
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              decoration: BoxDecoration(
                  color: AppColors.background2,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: QrImage(
                  data: address,
                  foregroundColor: AppColors.primary,
                  version: QrVersions.auto,
                  size: 240,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              decoration: BoxDecoration(
                  color: AppColors.background2,
                  borderRadius: BorderRadius.circular(10)),
              constraints: const BoxConstraints(maxWidth: 500),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        AppText(
                          text: 'Información',
                          textAlign: TextAlign.left,
                          size: 22,
                          fontWeight: FontWeight.w400,
                        ),
                        Icon(
                          Icons.info_outline_rounded,
                          color: Colors.white,
                          size: 26,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const AppText(
                      text:
                          'Este QR muestra tu dirección. Enséñala a tu pagador para que pueda obtenerla más fácilmente.',
                      color: AppColors.text2,
                      size: 18,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
