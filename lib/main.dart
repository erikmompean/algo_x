import 'package:crypto_x/bloc/bloc_files/bloc_provider.dart';
import 'package:crypto_x/bloc/splash_screen_bloc.dart';
import 'package:crypto_x/locators/app_locator.dart';
import 'package:crypto_x/ui/splash_screen.dart';
import 'package:flutter/material.dart';


void main() {
  AppLocator.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto X',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<SplashScreenBloc>(
        bloc: SplashScreenBloc(),
        child: const SplashScreen(),
      ),
    );
  }
}
