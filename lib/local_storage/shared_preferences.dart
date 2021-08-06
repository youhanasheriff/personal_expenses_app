import 'dart:convert';

import '../models/transaction.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionSharedPreferences {
  static SharedPreferences? _preferences;
  static const _keyListTransaction = "UserTransactionList";
  static const _keyCurrency = "currency";

  static Future init() async {
    return _preferences = await SharedPreferences.getInstance();
  }

  static Future setTransactions(List<Transaction> transList) async {
    if (transList == []) {
      return [];
    }
    List<Object> _tempTransList = [];
    Object _tempTrans = {};

    transList.forEach((data) {
      String id, title, amount, date;
      id = data.id!;
      title = data.title!;
      amount = data.amount!.toString();
      date = data.date!.toIso8601String();
      _tempTrans = {
        "id": id,
        "title": title,
        "amount": amount,
        "date": date,
      };
      _tempTransList.add(_tempTrans);
    });

    String userTransactionList = jsonEncode(_tempTransList); //json data

    return await _preferences!
        .setString(_keyListTransaction, userTransactionList);
  }

  static getTransactions() {
    String _temp = _preferences!.getString(_keyListTransaction) ?? "";
    if ((_temp == "")) {
      return "";
    } else {
      List<Transaction> _tempTrans = [];
      List<dynamic> _tempTObj = jsonDecode(_temp);

      _tempTObj.forEach((data) {
        String id, title;
        double amount;
        DateTime? date;
        id = data["id"];
        title = data["title"];
        amount = double.parse(data["amount"]);
        date = DateTime.tryParse(data["date"]);

        Transaction _finalTrans =
            Transaction(id: id, title: title, amount: amount, date: date);
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
}
