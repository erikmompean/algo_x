import 'dart:convert';

import 'package:algorand_dart/algorand_dart.dart';
import 'package:crypto_x/repositories/encrypted_prefernces_repository.dart';

class EncryptedPreferencesService {
  final EncryptedPreferencesRepository _encryptedPreferencesRepository;

  EncryptedPreferencesService(this._encryptedPreferencesRepository);

  Future<void> saveAccount(Account account) async {
    await _encryptedPreferencesRepository
        .saveAccount(jsonEncode(account.keyPair.extractPrivateKeyBytes()));
  }

  Future<String> retrieveAccount() {
    return _encryptedPreferencesRepository.retrieveAccount();
  }
}
