import 'package:crypto_x/bloc/bloc_utils/comon_states.dart';
import 'package:crypto_x/bloc/splash_screen_bloc/splash_screen_event.dart';
import 'package:crypto_x/utils/app_navigator.dart';
import 'package:crypto_x/utils/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreenBloc extends  Bloc<SplashScreenEvent, States> {
  SplashScreenBloc() : super(InitialState()) {
    on<LoadingFinished>();
  }

  @override
  States get initialState => InitialState();
  
  Future<void> initialize() async {}

  void _onLoadingFinished() {
    AppNavigator.push(Routes.home);
  }
  
  @override
  void dispose() {
    // TODO: implement dispose
  }
}
