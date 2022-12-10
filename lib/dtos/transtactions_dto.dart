import 'package:algo_x/dtos/transaction_dto.dart';

class TransacctionsDto {
  List<TransacctionDto> transactions;

  TransacctionsDto({
    required this.transactions,
  });

  static TransacctionsDto fromJson(Map<String, dynamic> json) {
    List<dynamic> transactions = json['transactions'];

    return TransacctionsDto(
        transactions:
            transactions.map((e) => TransacctionDto.fromJson(e)).toList());
  }
}
