import 'package:algo_x/bloc/start_wallet_screen_bloc/start_screen_bloc.dart';
import 'package:algo_x/bloc/start_wallet_screen_bloc/start_screen_event.dart';
import 'package:algo_x/locators/app_colors.dart';
import 'package:algo_x/widgets/app_button.dart';
import 'package:algo_x/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AppText(
            text: 'Bienvenido a Algo X',
            size: 26,
          ),
          const SizedBox(
            height: 20,
          ),
          const AppText(
            text: '¿Como empezamos?',
            color: Colors.grey,
            size: 20,
          ),
          const SizedBox(
            height: 50,
          ),
          AppButton(
            text: 'Crear una Cartera',
            onPressed: () =>
                context.read<StartScreenBloc>().add(CreatePressed()),
          ),
          const SizedBox(height: 20),
          const AppButton(text: 'Ya tengo una Cartera'),
        ],
      )),
    );
  }
}
