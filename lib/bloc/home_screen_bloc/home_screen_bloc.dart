import 'package:algorand_dart/algorand_dart.dart';
import 'package:crypto_x/bloc/home_screen_bloc/home_screen_event.dart';
import 'package:crypto_x/bloc/home_screen_bloc/home_screen_state.dart';
import 'package:crypto_x/services/purestake_service.dart';
import 'package:crypto_x/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final String apiKey = 'kPDlC2B5S18AwENiuk0NH7mr7iD707vG2zKMdHRV';
  final String apiUrl = 'https://testnet-algorand.api.purestake.io/ps2';

  Algorand? _algorand;
  Account? account1;
  Account? account2;
  String? _transactionID;
  PureStakeService pureStakeService;
  HomeScreenBloc(this.pureStakeService) : super(HomeScreenState());

  Future<void> createWallet() async {
    var account = await pureStakeService.createWallet();
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

  @override
  Future<void> initialize() {
    // TODO: implement initialize
    throw UnimplementedError();
  }
}
