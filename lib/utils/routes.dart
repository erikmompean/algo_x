import 'package:algo_x/bloc/recover_account_scren_bloc/recover_account_screen_bloc.dart';
import 'package:algo_x/bloc/send_money_screen_bloc/send_money_screen_bloc.dart';
import 'package:algo_x/bloc/send_money_screen_bloc/send_money_event.dart';
import 'package:algo_x/bloc/create_wallet_screen_bloc/create_wallet_screen_bloc.dart';
import 'package:algo_x/bloc/create_wallet_screen_bloc/create_wallet_screen_event.dart';
import 'package:algo_x/bloc/home_screen_bloc/home_screen_bloc.dart';
import 'package:algo_x/bloc/home_screen_bloc/home_screen_event.dart';
import 'package:algo_x/bloc/start_wallet_screen_bloc/start_screen_bloc.dart';
import 'package:algo_x/bloc/transaction_preview_bloc/transaction_preview_screen_bloc.dart';
import 'package:algo_x/locators/app_locator.dart';
import 'package:algo_x/repositories/encrypted_prefernces_repository.dart';
import 'package:algo_x/services/algo_explorer_service.dart';
import 'package:algo_x/services/purestake_service.dart';
import 'package:algo_x/ui/qr_scanner_screen.dart';
import 'package:algo_x/ui/qr_screen.dart';
import 'package:algo_x/ui/recover_account_screen.dart';
import 'package:algo_x/ui/screen_bundles/transaction_preview_bundle.dart';
import 'package:algo_x/ui/send_money_screen.dart';
import 'package:algo_x/ui/create_wallet_screen.dart';
import 'package:algo_x/ui/home_screen.dart';
import 'package:algo_x/ui/not_found_screen.dart';
import 'package:algo_x/ui/start_screen.dart';
import 'package:algo_x/ui/transaction_preview_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Routes {
  static const String home = '/home';
  static const String createWallet = '/create_wallet';
  static const String start = '/start';
  static const String addMoney = '/add_money';
  static const String qrScreen = '/qr_screen';
  static const String transacctionPreviewScreen =
      '/transacction_preview_screen';
  static const String qrScannerScreen = '/qr_scanner_screen';
  static const String recoverAccountScreen = '/recover_account_screen';

  static Route generateAppRoute(RouteSettings routeSettings) {
    var routePath = _getRoutePath(routeSettings);
    switch (routePath) {
      case home:
        return PageRouteBuilder(
            pageBuilder: (context, _, __) => BlocProvider<HomeScreenBloc>(
                  create: (_) => HomeScreenBloc(
                    AppLocator.locate<PureStakeService>(),
                    AppLocator.locate<EncryptedPreferencesRepository>(),
                    AppLocator.locate<AlgoExplorerService>(),
                  )..add(HomeInitEvent()),
                  child: const HomeScreen(),
                ));
      case start:
        return PageRouteBuilder(
          pageBuilder: (context, _, __) => BlocProvider<StartScreenBloc>(
            create: (_) =>
                StartScreenBloc(AppLocator.locate<PureStakeService>()),
            child: const StartScreen(),
          ),
          transitionsBuilder: transition,
        );
      case createWallet:
        return PageRouteBuilder(
          pageBuilder: (context, _, __) => BlocProvider<CreateWalletScreenBloc>(
            create: (_) => CreateWalletScreenBloc(
                AppLocator.locate<PureStakeService>(),
                AppLocator.locate<EncryptedPreferencesRepository>())
              ..add(CreateWalletInitEvent()),
            child: CreateWalletScreen(),
          ),
          transitionsBuilder: transition,
        );
      case addMoney:
        return PageRouteBuilder(
          pageBuilder: (context, _, __) => BlocProvider<SendMoneyScreenBloc>(
            create: (_) => SendMoneyScreenBloc(
              AppLocator.locate<PureStakeService>(),
              AppLocator.locate<EncryptedPreferencesRepository>(),
              AppLocator.locate<AlgoExplorerService>(),
            )..add(SendMoneyInitEvent()),
            child: SendMoneyScreen(),
          ),
          transitionsBuilder: transition,
        );
      case transacctionPreviewScreen:
        final TransactionPreviewBundle bundle =
            routeSettings.arguments as TransactionPreviewBundle;
        return PageRouteBuilder(
          pageBuilder: (context, _, __) =>
              BlocProvider<TransactionPreviewScreenBloc>(
            create: (_) => TransactionPreviewScreenBloc(
              AppLocator.locate<PureStakeService>(),
              AppLocator.locate<EncryptedPreferencesRepository>(),
              AppLocator.locate<AlgoExplorerService>(),
              bundle.address,
              bundle.amount,
            ),
            child: const TransactionPreviewScreen(),
          ),
          transitionsBuilder: transition,
        );
      case recoverAccountScreen:
        return PageRouteBuilder(
          pageBuilder: (context, _, __) =>
              BlocProvider<RecoverAccountScreenBloc>(
            create: (_) => RecoverAccountScreenBloc(
              AppLocator.locate<PureStakeService>(),
              AppLocator.locate<EncryptedPreferencesRepository>(),
            ),
            child: RecoverAccountScreen(),
          ),
          transitionsBuilder: transition,
        );
      case qrScreen:
        return PageRouteBuilder(
          pageBuilder: (context, _, __) =>
              QrScreen(address: routeSettings.arguments as String),
          transitionsBuilder: transition,
        );
      case qrScannerScreen:
        return PageRouteBuilder(
          pageBuilder: (context, _, __) => const QRViewExample(),
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
