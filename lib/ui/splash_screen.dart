import 'package:crypto_x/bloc/bloc_files/bloc_provider.dart';
import 'package:crypto_x/bloc/home_screen_bloc.dart';
import 'package:crypto_x/bloc/splash_screen_bloc.dart';
import 'package:crypto_x/locators/app_locator.dart';
import 'package:crypto_x/services/purestake_service.dart';
import 'package:crypto_x/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SplashScreenBloc>(context);

    bloc.initialize().then((value) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => BlocProvider<HomeScreenBloc>(
            bloc: HomeScreenBloc(AppLocator.locate<PureStakeService>()),
            child: const HomeScreen(), 
          ),
        ),
      );
    });
    return Center(
      child: LoadingAnimationWidget.halfTriangleDot(
          color: Colors.orange, size: 50),
    );
  }
}
