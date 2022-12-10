class AccountInformationDto {
  String address;
  int amount;

  AccountInformationDto({required this.address, required this.amount});

  static AccountInformationDto fromJson(Map<String, dynamic> json) {
    return AccountInformationDto(
      address: json['address'],
      amount: json['amount'],
    );
  }
}
