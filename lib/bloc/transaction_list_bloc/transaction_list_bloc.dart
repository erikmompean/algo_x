import 'package:algo_x/bloc/transaction_list_bloc/transaction_list_event.dart';
import 'package:algo_x/bloc/transaction_list_bloc/transaction_list_state.dart';
import 'package:algo_x/models/account_information_explorer.dart';
import 'package:algo_x/models/transaction_explorer.dart';
import 'package:algo_x/repositories/encrypted_prefernces_repository.dart';
import 'package:algo_x/services/algo_explorer_service.dart';
import 'package:algo_x/services/purestake_service.dart';
import 'package:algorand_dart/algorand_dart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionListBloc
    extends Bloc<TransactionListEvent, TransactionListState> {
  final AlgoExplorerService _algoExplorerService;
  final PureStakeService _pureStakeService;
  final EncryptedPreferencesRepository _encryptedPreferencesRepository;

  Account? _account;
  AccountInformationExplorer? accountInformation;
  List<TransactionExplorer>? _transactions;

  TransactionListBloc(
    this._algoExplorerService,
    this._pureStakeService,
    this._encryptedPreferencesRepository,
  ) : super(TransactionListInitialState()) {
    on<TransactionListInitEvent>((event, emit) => _initialize(event, emit));
  }

  Future<void> _initialize(TransactionListInitEvent event,
      Emitter<TransactionListState> emit) async {
    emit(TransactionListLoadingState());
    final privateKeys = await _encryptedPreferencesRepository.retrieveAccount();
    _account = await _pureStakeService.loadAccount(privateKeys!);
    accountInformation = await _algoExplorerService
        .retrieveAccountInformation(_account!.publicAddress);

    _transactions = await _algoExplorerService
        .retrieveTransacctions(_account!.publicAddress);

    emit(TransactionListIdleState(_transactions!, _account!));
  }
}
