import 'package:algo_x/bloc/splash_screen_bloc/splash_screen_bloc.dart';
import 'package:algo_x/bloc/splash_screen_bloc/splash_screen_event.dart';
import 'package:algo_x/ui/splash_screen.dart';
import 'package:algo_x/utils/navigator_service.dart';
import 'package:algo_x/utils/routes.dart';
import 'package:algo_x/utils/scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Algo X',
      scrollBehavior: AppScrollBehavior(),
      navigatorKey: NavigationService.instance.navigationKey,
      onGenerateRoute: Routes.generateAppRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<SplashScreenBloc>(
        create: (_) => SplashScreenBloc()..add(SplashScreenInitEvent()),
        child: const SplashScreen(),
      ),
    );
  }
}
