abstract class SendMoneyScreenState {}

class SendMoneyLoadingState extends SendMoneyScreenState {}

class SendMoneyInitState extends SendMoneyScreenState {}

class SendMoneyGoBackState extends SendMoneyScreenState {}

class SendMoneyAddresPagePassedState extends SendMoneyScreenState {}

class SendMoneyQrUpdateState extends SendMoneyScreenState {
  final String qrCode;

  SendMoneyQrUpdateState(this.qrCode);
}

class SendMoneyErrorState extends SendMoneyScreenState {}

class SendMoneyAddressEmtpyErrorState extends SendMoneyScreenState {}

class SendMoneyAmountErrorState extends SendMoneyScreenState {
  final String errorMessage;

  SendMoneyAmountErrorState({required this.errorMessage});
}
