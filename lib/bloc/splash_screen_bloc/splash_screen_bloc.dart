import 'package:algo_x/bloc/bloc_utils/comon_states.dart';
import 'package:algo_x/bloc/splash_screen_bloc/splash_screen_event.dart';
import 'package:algo_x/bloc/splash_screen_bloc/splash_screen_state.dart';
import 'package:algo_x/locators/app_locator.dart';
import 'package:algo_x/repositories/encrypted_prefernces_repository.dart';
import 'package:algo_x/utils/navigation_service.dart';
import 'package:algo_x/utils/routes.dart';
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
    AppLocator.setup();

    List<int>? privateKeys =
        await AppLocator.locate<EncryptedPreferencesRepository>()
            .retrieveAccount();

    emit(SplashFinishedLoadingState(privateKeys == null));
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
