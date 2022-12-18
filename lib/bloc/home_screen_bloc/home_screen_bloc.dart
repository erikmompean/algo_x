import 'dart:async';

import 'package:algo_x/models/account_information_explorer.dart';
import 'package:algo_x/models/transaction_explorer.dart';
import 'package:algo_x/repositories/encrypted_prefernces_repository.dart';
import 'package:algo_x/services/algo_explorer_service.dart';
import 'package:algo_x/utils/navigator_service.dart';
import 'package:algo_x/utils/routes.dart';
import 'package:algorand_dart/algorand_dart.dart';
import 'package:algo_x/bloc/home_screen_bloc/home_screen_event.dart';
import 'package:algo_x/bloc/home_screen_bloc/home_screen_state.dart';
import 'package:algo_x/services/purestake_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  Account? _account;
  List<TransactionExplorer>? _transactions;
  Timer? _timer;
  final PureStakeService _pureStakeService;
  final EncryptedPreferencesRepository _encryptedPreferencesRepository;
  final AlgoExplorerService _algoExplorerService;
  AccountInformationExplorer? accountInformation;
  HomeScreenBloc(this._pureStakeService, this._encryptedPreferencesRepository,
      this._algoExplorerService)
      : super(HomeInitState()) {
    on<HomeInitEvent>((event, emit) => _initialize(event, emit));
    on<HomeAddMoneyEvent>((event, emit) => _addMoney(event, emit));
    on<HomeSetupEvent>((event, emit) => _onSetup(event, emit));
    on<HomeOnExistPressed>((event, emit) => _onExistPressed(event, emit));
  }

  Future<void> _initialize(
      HomeInitEvent event, Emitter<HomeScreenState> emit) async {
    var privateKeys = await _encryptedPreferencesRepository.retrieveAccount();

    _account = await _pureStakeService.loadAccount(privateKeys!);
    await _setup();
    var bloc = this;

    _timer ??= Timer.periodic(
        const Duration(seconds: 10),
        (Timer t) async =>
            await _setup().then((value) => bloc.add(HomeSetupEvent())));

    emit(HomeAccountInformationLoadedState(
        _account!, accountInformation!, _transactions ?? []));
  }

  _onSetup(HomeSetupEvent event, Emitter<HomeScreenState> emit) async {
    await _setup();

    emit(HomeAccountInformationLoadedState(
        _account!, accountInformation!, _transactions ?? []));
  }

  _onExistPressed(
      HomeOnExistPressed event, Emitter<HomeScreenState> emit) async {
    _encryptedPreferencesRepository.removeAccount();

    NavigationService.instance.navigateAndSetRoot(Routes.start);
  }

  Future<void> _setup() async {
    accountInformation = await _algoExplorerService
        .retrieveAccountInformation(_account!.publicAddress);

    _transactions = await _algoExplorerService
        .retrieveTransacctions(_account!.publicAddress);
  }

  Future<void> _addMoney(
      HomeAddMoneyEvent event, Emitter<HomeScreenState> emit) async {
    NavigationService.instance.navigateTo(Routes.addMoney);
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    _timer = null;
    return super.close();
  }
}
