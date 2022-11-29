import 'package:algo_x/bloc/create_wallet_screen_bloc/create_wallet_screen_bloc.dart';
import 'package:algo_x/bloc/create_wallet_screen_bloc/create_wallet_screen_event.dart';
import 'package:algo_x/bloc/home_screen_bloc/home_screen_bloc.dart';
import 'package:algo_x/bloc/start_wallet_screen_bloc/start_screen_bloc.dart';
import 'package:algo_x/locators/app_locator.dart';
import 'package:algo_x/services/encrypted_preferences_service.dart';
import 'package:algo_x/services/purestake_service.dart';
import 'package:algo_x/ui/create_wallet_screen.dart';
import 'package:algo_x/ui/home_screen.dart';
import 'package:algo_x/ui/not_found_screen.dart';
import 'package:algo_x/ui/start_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Routes {
  static const String home = '/home';
  static const String createWallet = '/create_wallet';
  static const String start = '/start';

  static Route generateAppRoute(RouteSettings routeSettings) {
    var routePath = _getRoutePath(routeSettings);
    switch (routePath) {
      case home:
        return PageRouteBuilder(
            pageBuilder: (context, _, __) => BlocProvider<HomeScreenBloc>(
                  create: (_) =>
                      HomeScreenBloc(AppLocator.locate<PureStakeService>()),
                  child: const HomeScreen(),
                ));
      case start:
        return PageRouteBuilder(
            pageBuilder: (context, _, __) => BlocProvider<StartScreenBloc>(
                  create: (_) =>
                      StartScreenBloc(AppLocator.locate<PureStakeService>()),
                  child: const StartScreen(),
                ));
      case createWallet:
        return PageRouteBuilder(
          pageBuilder: (context, _, __) => BlocProvider<CreateWalletScreenBloc>(
            create: (_) => CreateWalletScreenBloc(
                AppLocator.locate<PureStakeService>(),
                AppLocator.locate<EncryptedPreferencesService>())
              ..add(CreateWalletInitEvent()),
            child: CreateWalletScreen(),
          ),
          transitionsBuilder: transition,
        );
    }

    return PageRouteBuilder(
        pageBuilder: (context, _, __) => const NotFoundScreen());
  }

  static String? _getRoutePath(RouteSettings settings) {
    if (settings.name != null && settings.name!.contains('?')) {
      return settings.name!.substring(0, settings.name!.indexOf('?'));
    }

    return settings.name;
  }

  static Widget transition(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    const begin = Offset(0.0, 1.0);
    const end = Offset.zero;
    const curve = Curves.ease;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }
}
