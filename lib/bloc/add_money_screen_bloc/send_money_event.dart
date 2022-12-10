abstract class SendMoneyScreenEvent {}

class SendMoneyInitEvent extends SendMoneyScreenEvent {}

class SendMoneyBackPageEvent extends SendMoneyScreenEvent {}

class SendMoneyToAmountPagePressedEvent extends SendMoneyScreenEvent {
  final int currentPage;
  final String address;
  final String amount;

  SendMoneyToAmountPagePressedEvent({
    required this.currentPage,
    required this.address,
    required this.amount,
  });

  @override
  String toString() {
    return '$address, $amount, $currentPage';
  }
}
class SendMoneyFinalStepPressedEvent extends SendMoneyScreenEvent {
  final int currentPage;
  final String address;
  final String amount;

  SendMoneyFinalStepPressedEvent({
    required this.currentPage,
    required this.address,
    required this.amount,
  });

  @override
  String toString() {
    return '$address, $amount, $currentPage';
  }
}
