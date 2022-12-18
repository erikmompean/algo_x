import 'package:algo_x/bloc/start_wallet_screen_bloc/start_screen_event.dart';
import 'package:algo_x/bloc/start_wallet_screen_bloc/start_screen_state.dart';
import 'package:algo_x/services/purestake_service.dart';
import 'package:algo_x/utils/navigator_service.dart';
import 'package:algo_x/utils/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartScreenBloc extends Bloc<StartScreenEvent, StartState> {
  PureStakeService pureStakeService;
  StartScreenBloc(this.pureStakeService) : super(InitiatlStartState()) {
    on<StartScreenCreatePressed>(
        (event, emit) => _onCreatedPressed(event, emit));
    on<StartScrenRecoverAccountPressed>(
        (event, emit) => _onIHaveExistingAccounPressed(event, emit));
  }

  Future<void> _onCreatedPressed(
      StartScreenCreatePressed event, Emitter<StartState> emit) async {
    await NavigationService.instance.navigateTo(Routes.createWallet);
  }

  Future<void> _onIHaveExistingAccounPressed( 
      StartScrenRecoverAccountPressed event, Emitter<StartState> emit) async {
    NavigationService.instance.navigateTo(Routes.recoverAccountScreen);
  }
}
