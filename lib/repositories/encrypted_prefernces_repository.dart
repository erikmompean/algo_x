import 'dart:convert';

import 'package:algorand_dart/algorand_dart.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

class EncryptedPreferencesRepository {
  final EncryptedSharedPreferences _encryptedPreferences =
      EncryptedSharedPreferences();

  Future<void> saveAccount(Account account) async {
    var privateKeys = await account.keyPair.extractPrivateKeyBytes();
    await _encryptedPreferences.setString(
        'priv_keys', jsonEncode({'privateKey': privateKeys}));
  }

  Future<void> removeAccount() async {
    await _encryptedPreferences.remove('priv_keys');
  }

  Future<List<int>?> retrieveAccount() async {
    var value = await _encryptedPreferences.getString('priv_keys');

    if (value.isEmpty) {
      return null;
    }

    var list = jsonDecode(value)['privateKey'];

    if (list == null) {
      return null;
    }
    return list.cast<int>();
  }
}
