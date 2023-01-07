import 'package:algo_x/bloc/transaction_preview_bloc/transaction_preview_event.dart';
import 'package:algo_x/bloc/transaction_preview_bloc/transaction_preview_state.dart';
import 'package:algo_x/repositories/encrypted_prefernces_repository.dart';
import 'package:algo_x/services/algo_explorer_service.dart';
import 'package:algo_x/utils/extends/string_extension.dart';
import 'package:algo_x/utils/navigation_service.dart';
import 'package:algo_x/utils/routes.dart';
import 'package:algorand_dart/algorand_dart.dart';
import 'package:algo_x/services/purestake_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionPreviewScreenBloc
    extends Bloc<TransactionPreviewScreenEvent, TransactionPreviewScreenState> {
  Account? account;

  final PureStakeService _pureStakeService;
  final EncryptedPreferencesRepository _encryptedPreferencesRepository;
  final AlgoExplorerService _algoExplorerService;
  final String _address;
  final int _amount;

  String get address => _address;
  String get amount => _amount.toAlgorandString();

  TransactionPreviewScreenBloc(
      this._pureStakeService,
      this._encryptedPreferencesRepository,
      this._algoExplorerService,
      this._address,
      this._amount)
      : super(TransactionPreviewInitState()) {
    on<TransactionPreviewBackPageEvent>(
        (event, emit) => _backPagePressed(event, emit));
    on<TransactionPreviewOnSendPressed>(
        (event, emit) => _onSendPressed(event, emit));
    on<TransactionPreviewOnCancelPressed>(
        (event, emit) => _onCancelPressed(event, emit));
  }

  Future<void> _backPagePressed(TransactionPreviewBackPageEvent event,
      Emitter<TransactionPreviewScreenState> emit) async {
    emit(TransactionPreviewGoBackState());
  }

  Future<void> _onSendPressed(TransactionPreviewOnSendPressed event,
      Emitter<TransactionPreviewScreenState> emit) async {
    emit(TransactionPreviewLoadingState());

    try {
      var privateKeys = await _encryptedPreferencesRepository.retrieveAccount();

      account = await _pureStakeService.loadAccount(privateKeys!);
      var transactionId = await _pureStakeService.sendTransaction(
          account!, Address.decodeAddress(_address), _amount);
      emit(TransactionPreviewAcceptedPaymentState(transactionId));
      await Future.delayed(const Duration(seconds: 3));
      NavigationService.instance.navigateAndSetRoot(Routes.home);
    } catch (ex) {
      emit(TransactionPreviewErrorState());
    }
  }

  Future<void> _onCancelPressed(TransactionPreviewOnCancelPressed event,
      Emitter<TransactionPreviewScreenState> emit) async {
    NavigationService.instance.goBack();
  }

  bool _validateAddress(String address) {
    return true;
  }
}
