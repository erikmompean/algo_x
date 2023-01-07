import 'package:algo_x/models/transaction_explorer.dart';
import 'package:algorand_dart/algorand_dart.dart';

class TransactionListState {}

class TransactionListInitialState extends TransactionListState {}

class TransactionListLoadingState extends TransactionListState {}

class TransactionListIdleState extends TransactionListState {
  final List<TransactionExplorer> transacctions;
  final Account account;
  TransactionListIdleState(this.transacctions, this.account);
}

class TransactionListErrorState extends TransactionListState {}
