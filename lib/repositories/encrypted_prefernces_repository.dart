import 'dart:convert';

import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

class EncryptedPreferencesRepository {
  final EncryptedSharedPreferences _encryptedPreferences =
      EncryptedSharedPreferences();

  Future<void> saveAccount(String privateKey) async {
    await _encryptedPreferences.setString('priv_keys', jsonEncode(privateKey));
  }

  Future<String?> retrieveAccount() async {
    var value = await _encryptedPreferences.getString('priv_keys');
    return value.isEmpty ? null : value;
  }
}
