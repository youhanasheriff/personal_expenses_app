import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_app/translations/locale_keys.g.dart';
import './local_storage/shared_preferences.dart';
import './models/localization.dart';
import './models/transaction.dart';
import './widgets/charts.dart';
import './widgets/new_transaction.dart';
import './widgets/user_transactions.dart';

class MyHomePage extends StatefulWidget {
  // String titleInput;
  // String amountInput;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Transaction> _userTransactions = [];
  String currencySimbol = "\$";

  @override
  void initState() {
    super.initState();

    var _temp = TransactionSharedPreferences.getTransactions();
    if (!(_temp == []) && !(_temp == "")) {
      _userTransactions = [..._temp];
    }

    String _tempSimbol = TransactionSharedPreferences.getCurrency();
    currencySimbol = _tempSimbol;
  }

  List<Transaction> get _recentTxs {
    return _userTransactions.where((tx) {
      return tx.date!.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(
      //Add transaction called from new_transaction.dart
      String? txTitle,
      double? txAmount,
      DateTime? selectedDate) {
    if (txTitle == null ||
        txAmount == null ||
        txAmount <= 0 ||
        selectedDate == null) {
      return;
    }

    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: selectedDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
      TransactionSharedPreferences.setTransactions(_userTransactions);
    });

    Navigator.of(context).pop();
  }

  void _clearAllTxs() {
    setState(() {
      _userTransactions = [];
    });
    TransactionSharedPreferences.setTransactions(_userTransactions);
  }

  void _deleteTx(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
    TransactionSharedPreferences.setTransactions(_userTransactions);
  }

  void showCard(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  void _changeLanguage(lang) {
    context.setLocale(Locale(lang.languageCode));
  }

  void currencySimbolFuntion(currency) {
    setState(() {
      currencySimbol = currency.currencySimbol;
    });
    TransactionSharedPreferences.setCurrency(currencySimbol);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  ClipOval(
                    child: CircleAvatar(
                      radius: 50,
                      child: Image.asset(
                        "assets/logo/app_logo.png",
                        fit: BoxFit.cover,
                        width: 90,
                        height: 90,
                      ),
                      backgroundColor: Color(0xff571d0c),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    LocaleKeys.app_name.tr(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              height: 200,
              color: Theme.of(context).primaryColor,
            ),
            ListTile(
              //Change Languages....
              onTap: () {
                Navigator.pop(context);
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SimpleDialog(
                        title: Text(LocaleKeys.languages.tr()),
                        children: Languages.languageList().map((lang) {
                          return ListTile(
                            leading: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                lang.flag,
                                style: TextStyle(fontSize: 22),
                              ),
                            ),
                            title: Text(
                              lang.name,
                              style: TextStyle(fontSize: 18),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                              _changeLanguage(lang);
                            },
                          );
                        }).toList(),
                      );
                    });
              },
              leading: Icon(
                Icons.language,
                color: Colors.black,
              ),
              title: Text(LocaleKeys.languages.tr()),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SimpleDialog(
                        title: Text(LocaleKeys.currency.tr()),
                        children: CurrencySimbols.simbolsList().map((currency) {
                          return ListTile(
                            title: Text(currency.name),
                            onTap: () {
                              Navigator.pop(context);
                              currencySimbolFuntion(currency);
                            },
                          );
                        }).toList(),
                      );
                    });
              },
              leading: Icon(
                Icons.money,
                color: Colors.black,
              ),
              title: Text(LocaleKeys.currency.tr()),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(LocaleKeys.app_name.tr()),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: double.infinity,
                child: Card(
                  margin: EdgeInsets.all(10),
                  color: Theme.of(context).primaryColorLight,
                  child: Charts(_recentTxs, currencySimbol),
                  elevation: 5,
                ),
              ),
              UserTransactions(
                  _userTransactions, _deleteTx, _clearAllTxs, currencySimbol),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showCard(context);
        },
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}
