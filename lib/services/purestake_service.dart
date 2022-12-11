import 'package:algorand_dart/algorand_dart.dart';
import 'package:algo_x/repositories/purestake_repository.dart';
import 'package:flutter/foundation.dart';

class PureStakeService {
  final PureStakeRepository repository;
  PureStakeService(this.repository);

  Future<Account> createWallet() async {
    return repository.createWallet();
  }

  Future<Account> loadAccount(List<int> binaryKey) async {
    return repository.loadAccount(binaryKey);
  }

  Future<String> sendTransaction(Account account, Uint8List address, int microAlgos) async {
    return await repository.sendTransaction(account, address, microAlgos);
  }

  Future<TransactionParams> getSuggestedTransactionParams() async {
    return repository.getSuggestedTransactionParams();
  }

  Future<bool?> checkValidAccount(String address) async {
    return repository.checkValidAccount(address);
  }
}
