import 'package:crypto_x/bloc/splash_screen_bloc/splash_screen_bloc.dart';
import 'package:crypto_x/bloc/splash_screen_bloc/splash_screen_event.dart';
import 'package:crypto_x/bloc/splash_screen_bloc/splash_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SplashScreenBloc>(context);

    // bloc.initialize().then((value) {
    //   Navigator.of(context).push(
    //     MaterialPageRoute(
    //       builder: (context) => BlocProvider<StartScreenBloc>(
    //         create: (_) =>
    //             StartScreenBloc(AppLocator.locate<PureStakeService>()),
    //         child: const StartScreen(),
    //       ),
    //     ),
    //   );
    // });
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocListener(
        bloc: bloc,
        listener: (context, state) {
          if (state is SplashFinishedLoadingState) {
            bloc.add(SplashLoadingFinishedEvent());
          }
        },
        child: Center(
          child: LoadingAnimationWidget.halfTriangleDot(
              color: Colors.orange, size: 50),
        ),
      ),
    );
  }
}
