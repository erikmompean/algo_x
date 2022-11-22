import 'package:algorand_dart/algorand_dart.dart';
import 'package:crypto_x/bloc/create_wallet_screen_bloc/create_wallet_screen_event.dart';
import 'package:crypto_x/bloc/create_wallet_screen_bloc/create_wallet_screen_state.dart';
import 'package:crypto_x/services/encrypted_preferences_service.dart';
import 'package:crypto_x/services/purestake_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateWalletScreenBloc
    extends Bloc<CreateWalletEvent, CreateWalletState> {
  Account? _account;

  // Account get account => _account ?? createWallet();
  final PureStakeService _pureStakeService;
  final EncryptedPreferencesService _encryptedPreferencesService;

  CreateWalletScreenBloc(
      this._pureStakeService, this._encryptedPreferencesService)
      : super(CreateWalletInitState()) {
    on<CreateWalletInitEvent>(_onCreatedPressed);
    on<FinishedCreateEvent>(_onFinish);
  }

  Future<void> _onCreatedPressed(
      CreateWalletInitEvent event, Emitter<CreateWalletState> emit) async {
    emit(CreateWalletInitState());
    _account = await _createWallet();

    var seedPhrase = await _account!.seedPhrase;
    emit(CreateWalletIdle(seedPhrase));
  }

  Future<Account> _createWallet() async {
    return await _pureStakeService.createWallet();
  }

  Future<void> _onFinish(
      FinishedCreateEvent event, Emitter<CreateWalletState> emit) async {
    emit(CreateWalletInitState());
    await _encryptedPreferencesService.saveAccount(_account!);
    emit(FinishedCreateAccountState());
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
