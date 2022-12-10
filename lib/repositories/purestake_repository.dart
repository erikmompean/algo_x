import 'package:algorand_dart/algorand_dart.dart';
import 'package:flutter/foundation.dart';

class PureStakeRepository {
  final String apiKey = 'kPDlC2B5S18AwENiuk0NH7mr7iD707vG2zKMdHRV';
  final String apiUrl = 'https://testnet-algorand.api.purestake.io/ps2';

  late Algorand _algorand;

  PureStakeRepository() {
    _initializeAlgorand();
  }

  Future<void> _initializeAlgorand() async {
    final algodClient = AlgodClient(
      apiUrl: PureStake.TESTNET_ALGOD_API_URL,
      apiKey: apiKey,
      tokenKey: PureStake.API_TOKEN_HEADER,
    );

    final indexerClient = IndexerClient(
      apiUrl: PureStake.TESTNET_INDEXER_API_URL,
      apiKey: apiKey,
      tokenKey: PureStake.API_TOKEN_HEADER,
    );

    _algorand = Algorand(
      algodClient: algodClient,
      indexerClient: indexerClient,
    );
  }

  Future<Account> createWallet() async {
    var account = await _algorand.createAccount();
    var seedPhrase = await account.seedPhrase;
    var private = await account.keyPair.extractPrivateKeyBytes();

    print('address: ${account.address}');
    print('seedPhrase: ${seedPhrase.toString()}');
    print('publicKey: ${account.publicKey}');
    print('publicAddress: ${account.publicAddress}');
    print('private: ${private.toString()}');

    return account;
  }

  Future<Account> loadAccount(List<int> binaryKey) async {
    var account = await _algorand.loadAccountFromSeed(binaryKey);
    var seedPhrase = await account.seedPhrase;
    var private = await account.keyPair.extractPrivateKeyBytes();

    print('address: ${account.address}');
    print('seedPhrase: ${seedPhrase.toString()}');
    print('publicKey: ${account.publicKey}');
    print('publicAddress: ${account.publicAddress}');
    print('private: ${private.toString()}');
    return account;
  }

  Future<String> sendTransaction(
      Account account, Uint8List address, int microAlgos) async {
    var transactionID = await _algorand.sendPayment(
      account: account,
      recipient: Address(publicKey: address),
      amount: microAlgos,
    );
    print('transactionId: $transactionID');

    return transactionID;
  }

  Future<TransactionParams> getSuggestedTransactionParams() async {
    return _algorand.getSuggestedTransactionParams();
  }

  Future<bool?> checkValidAccount(String address) async {
    try {
      AccountInformation accountInformation =
          await _algorand.getAccountByAddress(address);
    } catch (ex) {
      if (ex is AlgorandException) {
        return false;
      }
    }

    return true;
  }
}
