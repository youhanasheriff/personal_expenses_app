import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/transaction.dart';

class TransactionSharedPreferences {
  static SharedPreferences? _preferences;
  static const _keyListTransaction = "UserTransactionList";
  static const _keyCurrency = "currency";
  static const _keyPIN = "securityPIN";
  static const _keyIsPINActive = "PINActive";
  static const _keyLang = "lang";

  static Future init() async {
    return _preferences = await SharedPreferences.getInstance();
  }

  static Future setTransactions(List<Transaction> transList) async {
    if (transList == []) {
      return [];
    }
    List<Object> _tempTransList = [];

    transList.forEach((data) {
      Object _tempTrans = data.toJson();
      _tempTransList.add(_tempTrans);
    });

    String userTransactionList = jsonEncode(_tempTransList); //json data

    return await _preferences!
        .setString(_keyListTransaction, userTransactionList);
  }

  static getTransactions() {
    String _temp = _preferences!.getString(_keyListTransaction) ?? "";
    if ((_temp == "")) {
      return <Transaction>[];
    } else {
      List<Transaction> _tempTrans = [];
      List<dynamic> _tempTObj = jsonDecode(_temp);
      _tempTObj.forEach((data) {
        Transaction _finalTrans = Transaction.fromJson(data);
        _tempTrans.add(_finalTrans);
      });
      return _tempTrans;
    }
  }

  static getCurrency() {
    return _preferences!.getString(_keyCurrency) ?? "\$";
  }

  static Future setCurrency(String cSimbol) async {
    return await _preferences!.setString(_keyCurrency, cSimbol);
  }

  static getSecurityPIN() {
    return _preferences!.getString(_keyPIN);
  }

  static Future setSecurityPIN(String pin) async {
    return await _preferences!.setString(_keyPIN, pin);
  }

  static Future setIsPINActive(bool isActive) async {
    if (isActive) {
      return await _preferences!
          .setString(_keyIsPINActive, isActive.toString());
    } else {
      return await _preferences!
          .setString(_keyIsPINActive, isActive.toString());
    }
  }

  static getIsPINActive() {
    return _preferences!.getString(_keyIsPINActive);
  }

  static setLang(String lang) async {
    return await _preferences!.setString(_keyLang, lang);
  }

  static getLang() {
    return _preferences!.getString(_keyLang);
  }
}
