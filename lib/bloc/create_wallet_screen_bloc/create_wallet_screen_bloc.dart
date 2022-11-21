import 'package:algorand_dart/algorand_dart.dart';
import 'package:crypto_x/bloc/create_wallet_screen_bloc/create_wallet_screen_event.dart';
import 'package:crypto_x/bloc/create_wallet_screen_bloc/create_wallet_screen_state.dart';
import 'package:crypto_x/services/purestake_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateWalletScreenBloc
    extends Bloc<CreateWalletEvent, CreateWalletState> {
  Account? _account;

  // Account get account => _account ?? createWallet();
  PureStakeService pureStakeService;
  CreateWalletScreenBloc(this.pureStakeService)
      : super(CreateWalletInitState()) {
    on<CreateWalletInitEvent>(_onCreatedPressed);
  }

  Future<void> _onCreatedPressed(
      CreateWalletInitEvent event, Emitter<CreateWalletState> emit) async {
    emit(CreateWalletInitState());
    _account = await _createWallet();

    var seedPhrase = await _account!.seedPhrase;
    emit(CreateWalletIdle(seedPhrase));
  }

  Future<Account> _createWallet() async {
    return await pureStakeService.createWallet();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
