import 'package:algo_x/models/account_information_explorer.dart';
import 'package:algo_x/models/transaction_explorer.dart';
import 'package:algorand_dart/algorand_dart.dart';

abstract class HomeScreenState {}

class HomeLoadingState extends HomeScreenState {}

class HomeInitState extends HomeScreenState {}

class HomeErrorState extends HomeScreenState {}

class HomeAccountInformationLoadedState extends HomeScreenState {
  Account account;
  AccountInformationExplorer accountInformation;
  List<TransactionExplorer> transactions;
  HomeAccountInformationLoadedState(
    this.account,
    this.accountInformation,
    this.transactions,
  );
}
