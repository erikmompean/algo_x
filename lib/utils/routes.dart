import 'package:crypto_x/bloc/home_screen_bloc/home_screen_bloc.dart';
import 'package:crypto_x/locators/app_locator.dart';
import 'package:crypto_x/services/purestake_service.dart';
import 'package:crypto_x/ui/home_screen.dart';
import 'package:crypto_x/ui/not_found_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Routes {
  static const String home = '/home';
  static const String start = '/start_wallet';

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
}
