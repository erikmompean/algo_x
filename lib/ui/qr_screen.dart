import 'package:algo_x/locators/app_colors.dart';
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
        child: Stack(
          children: [
            const Align(
              alignment: Alignment.topCenter,
              child: AppTopBar(
                title: 'Mi QR',
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.background2,
                  borderRadius: BorderRadius.circular(10)
                ),
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
            ),
          ],
        ),
      ),
    );
  }
}
