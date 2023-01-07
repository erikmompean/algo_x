import 'dart:convert';

import 'package:algo_x/dtos/account_information_dto.dart';
import 'package:algo_x/dtos/transtactions_dto.dart';
import 'package:algo_x/models/account_information_explorer.dart';
import 'package:algo_x/models/transaction_explorer.dart';
import 'package:http/http.dart';

class AlgoExplorerService {
  final nodeUri = 'node.testnet.algoexplorerapi.io';
  final indexerUri = 'algoindexer.testnet.algoexplorerapi.io';

  Future<AccountInformationExplorer?> retrieveAccountInformation(
      String address) async {
    final uri = Uri.https(nodeUri, 'v2/accounts/$address');
    var response = await get(uri);

    var dto = AccountInformationDto.fromJson(jsonDecode(response.body));

    return AccountInformationExplorer(address: dto.address, amount: dto.amount);
  }

  Future<List<TransactionExplorer>?> retrieveTransacctions(String address,
      {int? limit}) async {
    Uri uri;
    if (limit != null) {
      Map<String, dynamic> queryParameters = {
        'limit': limit.toString(),
      };
      uri = Uri.https(
        indexerUri,
        'v2/accounts/$address/transactions',
        queryParameters,
      );
    } else {
      uri = Uri.https(
        indexerUri,
        'v2/accounts/$address/transactions',
      );
    }

    var response = await get(
      uri,
    );

    var dto = TransacctionsDto.fromJson(jsonDecode(response.body));

    var transacctions = dto.transactions
        .map((e) => TransactionExplorer(
              id: e.id,
              sender: e.sender,
              receiver: e.receiver,
              amount: e.amount,
              fee: e.fee,
              timestamp: e.timeStamp,
            ))
        .toList();

    return transacctions;
  }
}
