import 'package:algorand_dart/algorand_dart.dart';
import 'package:crypto_x/bloc/bloc_files/bloc.dart';
import 'package:crypto_x/services/purestake_service.dart';
import 'package:crypto_x/utils.dart';

class HomeScreenBloc implements Bloc {
  final String apiKey = 'kPDlC2B5S18AwENiuk0NH7mr7iD707vG2zKMdHRV';
  final String apiUrl = 'https://testnet-algorand.api.purestake.io/ps2';

  Algorand? _algorand;
  Account? account1;
  Account? account2;
  String? _transactionID;
  PureStakeService pureStakeService;
  HomeScreenBloc(this.pureStakeService);

  Future<void> initializeAlgorand() async {
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

  Future<void> createWallet() async {
    if (_algorand != null) {
      var account = await _algorand!.createAccount();
      var seedPhrase = await account.seedPhrase;
      var private = await account.keyPair.extractPrivateKeyBytes();
      print('address: ${account.address}');
      print('seedPhrase: ${seedPhrase.toString()}');
      print('publicKey: ${account.publicKey}');
      print('publicAddress: ${account.publicAddress}');
      print('private: ${private.toString()}');
    } else {
      print('error');
    }
  }

  Future<void> loadAccounts() async {
    loadFirstAccount();
    loadSecondAccount();
  }

  Future<void> loadFirstAccount() async {
    if (_algorand != null) {
      account1 = account1 = await _algorand!
          .loadAccountFromSeed(Utils.firstAccountPrivateBinaryKey);
      _printAccount(account1!);
    } else {
      print('error');
    }
  }

  Future<void> loadSecondAccount() async {
    if (_algorand != null) {
      account2 = await _algorand!
          .loadAccountFromSeed(Utils.secondAccountPrivateBinaryKey);
      _printAccount(account2!);
    } else {
      print('error');
    }
  }

  Future<void> sendTransaction() async {
    if (_algorand != null) {
      _transactionID = await _algorand!.sendPayment(
          account: account1!,
          recipient: account2!.address,
          amount: Algo.toMicroAlgos(3));
      print('transactionId: $_transactionID');
    } else {
      print('error');
    }
  }

  void debug() {
    print('DEBUUUG');
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

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
