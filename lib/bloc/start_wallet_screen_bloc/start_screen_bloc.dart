import 'package:crypto_x/bloc/start_wallet_screen_bloc/start_screen_event.dart';
import 'package:crypto_x/bloc/start_wallet_screen_bloc/start_screen_state.dart';
import 'package:crypto_x/services/purestake_service.dart';
import 'package:crypto_x/utils/navigator_service.dart';
import 'package:crypto_x/utils/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartScreenBloc extends Bloc<StartScreenEvent, StartState> {
  PureStakeService pureStakeService;
  StartScreenBloc(this.pureStakeService) : super(InitiatlStartState()) {
    on<CreatePressed>((event, emit) => _onCreatedPressed(event, emit));
    on<IHaveExistingAccountPressed>((event, emit) => null);
  }

  Future<void> initialize() async {}

  Future<void> _onCreatedPressed(CreatePressed event, Emitter<StartState> emit) async {
    await NavigationService.instance.navigateTo(Routes.createWallet);
  }

  void _onIHaveExistinAccounPressed(
      CreatePressed event, Emitter<StartScreenEvent> emit) {}
}
