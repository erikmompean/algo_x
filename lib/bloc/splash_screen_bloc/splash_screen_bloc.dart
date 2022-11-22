import 'package:crypto_x/bloc/bloc_utils/comon_states.dart';
import 'package:crypto_x/bloc/splash_screen_bloc/splash_screen_event.dart';
import 'package:crypto_x/bloc/splash_screen_bloc/splash_screen_state.dart';
import 'package:crypto_x/utils/navigator_service.dart';
import 'package:crypto_x/utils/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  SplashScreenBloc() : super(SplashInitState()) {
    on<SplashScreenInitEvent>(_initialize);
    on<SplashLoadingFinishedEvent>(_onLoadingFinished);
  }

  @override
  States get initialState => InitialState();

  Future<void> _initialize(
      SplashScreenEvent event, Emitter<SplashScreenState> emit) async {
    emit(SplashFinishedLoadingState());
  }

  void _onLoadingFinished(
      SplashLoadingFinishedEvent event, Emitter<States> emit) {
    NavigationService.instance.navigateTo(Routes.start);
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
