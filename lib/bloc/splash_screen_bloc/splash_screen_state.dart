import 'package:algo_x/bloc/bloc_utils/comon_states.dart';

abstract class SplashScreenState extends States {}

class SplashFinishedLoadingState extends SplashScreenState {
  final bool isFirstTime;

  SplashFinishedLoadingState(this.isFirstTime);
}

class SplashInitState extends SplashScreenState {}
