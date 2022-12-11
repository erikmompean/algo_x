import 'package:algo_x/bloc/send_money_screen_bloc/send_money_event.dart';
import 'package:algo_x/bloc/send_money_screen_bloc/send_money_state.dart';
import 'package:algo_x/models/account_information_explorer.dart';
import 'package:algo_x/repositories/encrypted_prefernces_repository.dart';
import 'package:algo_x/services/algo_explorer_service.dart';
import 'package:algo_x/ui/screen_bundles/transaction_preview_bundle.dart';
import 'package:algo_x/utils/navigator_service.dart';
import 'package:algo_x/utils/routes.dart';
import 'package:algorand_dart/algorand_dart.dart';
import 'package:algo_x/services/purestake_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendMoneyScreenBloc
    extends Bloc<SendMoneyScreenEvent, SendMoneyScreenState> {
  Account? _account;
  AccountInformationExplorer? _accountInfo;

  final PureStakeService _pureStakeService;
  final EncryptedPreferencesRepository _encryptedPreferencesRepository;
  final AlgoExplorerService _algoExplorerService;

  SendMoneyScreenBloc(this._pureStakeService,
      this._encryptedPreferencesRepository, this._algoExplorerService)
      : super(SendMoneyInitState()) {
    on<SendMoneyInitEvent>((event, emit) => _initialize(event, emit));
    on<SendMoneyToAmountPagePressedEvent>(
        (event, emit) => _onToAmountButtonPressed(event, emit));
    on<SendMoneyBackPageEvent>((event, emit) => _backPagePressed(event, emit));
    on<SendMoneyFinalStepPressedEvent>(
        (event, emit) => _finalStep(event, emit));
    on<SendMoneyQRFoundEvent>((event, emit) => _qrFoundEvent(event, emit));
  }

  Future<void> _initialize(
      SendMoneyInitEvent event, Emitter<SendMoneyScreenState> emit) async {
    var privateKeys = await _encryptedPreferencesRepository.retrieveAccount();

    _account = await _pureStakeService.loadAccount(privateKeys!);
    _accountInfo = await _algoExplorerService
        .retrieveAccountInformation(_account!.publicAddress);
  }

  Future<void> _backPagePressed(
      SendMoneyBackPageEvent event, Emitter<SendMoneyScreenState> emit) async {
    emit(SendMoneyGoBackState());
  }

  Future<void> _finalStep(SendMoneyFinalStepPressedEvent event,
      Emitter<SendMoneyScreenState> emit) async {
    try {
      if (event.address.isNotEmpty && event.amount.isNotEmpty) {
        var amount = double.parse(event.amount);
        var toSend = Algo.toMicroAlgos(amount);

        if (_accountInfo!.amount < toSend) {
          emit(SendMoneyAmountErrorState(
              errorMessage: 'No tienes suficiente dinero'));
        } else {
          NavigationService.instance.navigateTo(
              Routes.transacctionPreviewScreen,
              args: TransactionPreviewBundle(
                  address: event.address, amount: toSend));
        }
      } else {
        emit(SendMoneyAmountErrorState(
            errorMessage: 'Debes rellenar el campo Cantidad'));
      }
    } catch (ex) {
      emit(SendMoneyErrorState());
    }
  }

  Future<void> _qrFoundEvent(
      SendMoneyQRFoundEvent event, Emitter<SendMoneyScreenState> emit) async {
    emit(SendMoneyQrUpdateState(event.qrCode));
  }

  Future<void> _onToAmountButtonPressed(SendMoneyToAmountPagePressedEvent event,
      Emitter<SendMoneyScreenState> emit) async {
    bool isValidAddress = _validateAddress(event.address);
    if (event.currentPage == 0 && event.address.isNotEmpty) {
      emit(SendMoneyAddresPagePassedState());
    } else if (event.address.isEmpty) {
      emit(SendMoneyAddressEmtpyErrorState());
    }
  }

  bool _validateAddress(String address) {
    return true;
  }
}
