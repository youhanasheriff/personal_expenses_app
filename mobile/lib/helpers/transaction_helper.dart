import '../local_storage/shared_preferences.dart';
import '../models/transaction.dart';

class HelpTransaction {
  List<Transaction> deleteTransaction(List<Transaction> txs, String id) {
    List<Transaction> _temp = [];
    txs.forEach((data) {
      if (data.id != id) {
        _temp.add(data);
      }
    });
    TransactionSharedPreferences.setTransactions(_temp);
    return _temp;
  }
}
