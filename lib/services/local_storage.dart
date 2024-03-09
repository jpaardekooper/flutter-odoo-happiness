import 'dart:convert';

import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  final String _sessionKey = "TOKEN";

  final SharedPreferences sharedPreferences;
  String? token;

  LocalStorage(this.sharedPreferences);

  Future<void> saveOdooSession(OdooSession session) {
    String value = jsonEncode(session);
    return sharedPreferences.setString(_sessionKey, value);
  }

  OdooSession? getOdooSession() {
    final storedSession = sharedPreferences.getString(_sessionKey);

    return storedSession != null
        ? OdooSession.fromJson(jsonDecode(storedSession))
        : null;
  }

  Future<void> clearOdooSession() {
    return sharedPreferences.remove(_sessionKey);
  }
}
