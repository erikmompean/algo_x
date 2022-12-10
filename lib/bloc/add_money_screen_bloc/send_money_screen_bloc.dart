import 'package:algo_x/bloc/add_money_screen_bloc/send_money_event.dart';
import 'package:algo_x/bloc/add_money_screen_bloc/send_money_state.dart';
import 'package:algo_x/models/transaction_explorer.dart';
import 'package:algo_x/repositories/encrypted_prefernces_repository.dart';
import 'package:algo_x/services/algo_explorer_service.dart';
import 'package:algorand_dart/algorand_dart.dart';
import 'package:algo_x/services/purestake_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendMoneyScreenBloc
    extends Bloc<SendMoneyScreenEvent, SenndMoneyScreenState> {
  Account? account;
  List<TransactionExplorer>? transactions;

  final PureStakeService _pureStakeService;
  final EncryptedPreferencesRepository _encryptedPreferencesRepository;
  final AlgoExplorerService _algoExplorerService;

  SendMoneyScreenBloc(this._pureStakeService,
      this._encryptedPreferencesRepository, this._algoExplorerService)
      : super(SendMoneyInitState()) {
    on<SendMoneyInitEvent>((event, emit) => _initialize(event, emit));
    on<SendMoneyToAmountPagePressedEvent>(
        (event, emit) => _onToAmountButtonPressed(event, emit));
    on<SendMoneyBackPageEvent>(
        (event, emit) => _backPagePressed(event, emit));
    on<SendMoneyFinalStepPressedEvent>(
        (event, emit) => _finalStep(event, emit));
  }

  Future<void> _initialize(
      SendMoneyInitEvent event, Emitter<SenndMoneyScreenState> emit) async {
    var privateKeys = await _encryptedPreferencesRepository.retrieveAccount();

    account = await _pureStakeService.loadAccount(privateKeys!);
  }

  Future<void> _backPagePressed(
      SendMoneyBackPageEvent event, Emitter<SenndMoneyScreenState> emit) async {
    emit(SendMoneyGoBackState());
  }

  Future<void> _finalStep(SendMoneyFinalStepPressedEvent event,
      Emitter<SenndMoneyScreenState> emit) async {
    if (event.address.isNotEmpty && event.amount.isNotEmpty) {
      var accountInfo = await _algoExplorerService
          .retrieveAccountInformation(account!.publicAddress);

      var toSend = Algo.toMicroAlgos(double.parse(event.amount));

      if (accountInfo!.amount < toSend) {
        emit(SendMoneyInsuficientAmountState());
      } else {
        _pureStakeService.sendTransaction(
            account!, Address.decodeAddress(event.address), toSend);
      }
    }
  }

  Future<void> _onToAmountButtonPressed(SendMoneyToAmountPagePressedEvent event,
      Emitter<SenndMoneyScreenState> emit) async {
    // print(event.toString());
    bool isValidAddress = _validateAddress(event.address);
    if (event.currentPage == 0 && event.address.isNotEmpty) {
      emit(SendMoneyAddresPagePassedState());
    } else if (event.address.isEmpty) {
      emit(SendMoneyAddressEmtpyErrorState());
    }
  }

  Future<void> _printAccount(Account printAccount) async {
    var seedPhrase = await printAccount.seedPhrase;
    var private = await printAccount.keyPair.extractPrivateKeyBytes();
    print('address: ${printAccount.address}');
    print('seedPhrase: ${seedPhrase.toString()}');
    print('publicKey: ${printAccount.publicKey}');
    print('publicAddress: ${printAccount.publicAddress}');
    print('private: ${private.toString()}');
    print('----------------------------------------------');
  }

  bool _validateAddress(String address) {
    return true;
  }
}

// Future<void> sendTransaction() async {
//   if (_algorand != null) {
//     _transactionID = await _algorand!.sendPayment(
//         account: account1!,
//         recipient: account2!.address,
//         amount: Algo.toMicroAlgos(3));
//     print('transactionId: $_transactionID');
//   } else {
//     print('error');
//   }
// }
