class TransacctionDto {
  final String id;
  final String sender;
  final String receiver;
  final int amount;
  final int fee;
  final int timeStamp;

  TransacctionDto({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.amount,
    required this.fee,
    required this.timeStamp,
  });

  static TransacctionDto fromJson(Map<String, dynamic> json) {
    return TransacctionDto(
      id: json['id'],
      sender: json['sender'],
      receiver: json['payment-transaction']['receiver'],
      amount: json['payment-transaction']['amount'],
      fee: json['fee'],
      timeStamp: json['round-time'],
    );
  }
}
