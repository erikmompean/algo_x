class TransactionExplorer {
  final String id;
  final String sender;
  final String receiver;
  final int amount;
  final int fee;
  final int timestamp;

  TransactionExplorer({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.amount,
    required this.fee,
    required this.timestamp,
  });

  DateTime getTime() {
    return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  }

  bool imSender(String myAddress) {
    return myAddress == sender;
  }

  String transactionSendToString(String myAddress) {
    if (imSender(myAddress)) {
      return 'to: $receiver';
    } else {
      return 'from: $sender';
    }
  }
}
