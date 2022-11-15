import 'package:crypto_x/bloc/splash_screen_bloc/splash_screen_bloc.dart';
import 'package:crypto_x/locators/app_locator.dart';
import 'package:crypto_x/ui/splash_screen.dart';
import 'package:crypto_x/utils/app_navigator.dart';
import 'package:crypto_x/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      navigatorKey: AppNavigator.navigatorKey,
      onGenerateRoute: Routes.generateAppRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<SplashScreenBloc>(
        create: (_) => SplashScreenBloc(),
        child: const SplashScreen(),
      ),
    );
  }
}
