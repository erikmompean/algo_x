import 'dart:convert';

import 'package:algorand_dart/algorand_dart.dart';
import 'package:algo_x/repositories/encrypted_prefernces_repository.dart';

class EncryptedPreferencesService {
  final EncryptedPreferencesRepository _encryptedPreferencesRepository;

  EncryptedPreferencesService(this._encryptedPreferencesRepository);

  Future<void> saveAccount(Account account) async {
    await _encryptedPreferencesRepository
        .saveAccount(jsonEncode(await account.keyPair.extractPrivateKeyBytes()));
  }

  Future<String?> retrieveAccount() async {
    return await _encryptedPreferencesRepository.retrieveAccount();
  }
}
