abstract class CreateWalletState {}

class CreateWalletInitState extends CreateWalletState {}

class CreateWalletIdle extends CreateWalletState {
  final List<String> seedPhrase;

  CreateWalletIdle(this.seedPhrase);
}
