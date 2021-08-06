import 'package:flutter/material.dart';
import 'package:flutter_app/models/transaction.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_app/translations/locale_keys.g.dart';
import 'package:intl/intl.dart';
import './transaction_list.dart';

class UserTransactions extends StatefulWidget {
  final txs;
  final deleteTx;
  final Function clearTxs;
  final String currencySimbol;
  UserTransactions(this.txs, this.deleteTx, this.clearTxs, this.currencySimbol);

  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  List<Transaction> filteredList = [];
  String? _selectedDate;
  int txsListState = 0;

  @override
  void initState() {
    filteredList = widget.txs;
    super.initState();
  }

  void _datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        // setState(() {
        filteredList = widget.txs;
        // });
        return;
      }
      filteredList = [];
      txsListState = 1;
      widget.txs.map((tx) {
        _selectedDate = DateFormat.yMd().format(pickedDate);
        if (DateFormat.yMd().format(tx.date) == _selectedDate) {
          setState(() {
            filteredList.add(tx);
          });
        }
      }).toList();
    });
  }

  void _showAll() {
    txsListState = 0;
    setState(() {
      filteredList = widget.txs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.txs.isEmpty
        ? Center(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Divider(
                    indent: 20,
                    endIndent: 20,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Text(
                          LocaleKeys.no_transaction_is_done_yet.tr(),
                          style: TextStyle(fontSize: 25),
                          textAlign: TextAlign.center,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    'assets/images/no_transaction.png',
                    width: 100,
                  ),
                ],
              ),
            ),
          )
        : Column(
            children: <Widget>[
              Divider(
                indent: 10,
                endIndent: 10,
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                ),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0, left: 10),
                      child: Text(
                        LocaleKeys.transaction.tr(),
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    Spacer(),
                    PopupMenuButton(
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            value: 'filterDate',
                            child: Text(LocaleKeys.filter_transaction.tr()),
                            enabled: !(txsListState == 1),
                          ),
                          PopupMenuItem(
                            value: 'showAll',
                            child: Text(LocaleKeys.show_all_transaction.tr()),
                            enabled: !(txsListState == 0),
                          ),
                          PopupMenuItem(
                            value: 'clearAll',
                            child: Text(LocaleKeys.clear_all_transaction.tr()),
                          ),
                        ];
                      },
                      onSelected: (val) {
                        switch (val) {
                          case 'filterDate':
                            _datePicker();
                            break;
                          case 'showAll':
                            _showAll();
                            break;
                          case 'clearAll':
                            widget.clearTxs();
                            filteredList = [];
                            break;
                          default:
                            print('cool');
                        }
                      },
                    ),
                  ],
                ),
              ),
              TransactionList(
                  filteredList, widget.deleteTx, widget.currencySimbol),
            ],
          );
  }
}
