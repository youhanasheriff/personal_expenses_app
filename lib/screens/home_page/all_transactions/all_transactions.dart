import 'package:flutter/material.dart';
import 'package:flutter_app/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../models/transaction.dart';
import '../../../local_storage/shared_preferences.dart';
import '../../../screens/home_page/components/no_data_text.dart';
import '../../../translations/locale_keys.g.dart';
import '../../../widgets/expense_details/expense_details.dart';
import '../../../widgets/filter_transaction.dart';
import '../../../widgets/session_title.dart';
import '../../../widgets/expenses_card_tile.dart';

class AllTransactions extends StatefulWidget {
  final List<Transaction> transaction;
  final deleteFun;
  AllTransactions(this.transaction, this.deleteFun);

  @override
  _AllTransactionsState createState() => _AllTransactionsState();
}

class _AllTransactionsState extends State<AllTransactions> {
  late List<Transaction> transaction;
  List<Transaction> filteredTransaction = [];
  String currencySimbol = "\$";
  double _totalamount = 00.00;
  double _amount = 00.00;

  @override
  void initState() {
    super.initState();
    transaction = widget.transaction;
    currencySimbol = TransactionSharedPreferences.getCurrency();
    transaction.forEach((element) {
      _amount += element.amount;
    });
    _totalamount = _amount;
  }

  List<Transaction> get _todayTransactions {
    String _selectedDate = DateFormat.yMd().format(DateTime.now());
    List<Transaction> _temp = [];
    transaction.forEach((tx) {
      if (DateFormat.yMd().format(tx.date) == _selectedDate) {
        _temp.add(tx);
      }
    });
    _temp.sort((a, b) => b.date.compareTo(a.date));
    return _temp;
  }

  List<Transaction> get _yesterdayTransactions {
    String _selectedDate =
        DateFormat.yMd().format(DateTime.now().subtract(Duration(days: 1)));
    List<Transaction> _temp = [];
    transaction.forEach((tx) {
      if (DateFormat.yMd().format(tx.date) == _selectedDate) {
        _temp.add(tx);
      }
    });
    _temp.sort((a, b) => b.date.compareTo(a.date));
    return _temp;
  }

  List<Transaction> get _beforeYesterdayTransactions {
    List<Transaction> _temp = transaction.where((tx) {
      return tx.date.isBefore(DateTime.now().subtract(Duration(days: 2)));
    }).toList();
    _temp.sort((a, b) => b.date.compareTo(a.date));
    return _temp;
  }

  void _showCard(BuildContext ctx) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: ctx,
      builder: (_) {
        return FilterTransaction(applyFilter, transaction);
      },
    );
  }

  void deleteFun(id) {
    widget.deleteFun(id);
    setState(() {
      transaction = TransactionSharedPreferences.getTransactions();
    });
  }

  void showCard(BuildContext ctx, String id) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: ctx,
      builder: (_) {
        return ExpenseDetails(id, transaction, deleteFun);
      },
    );
  }

  void applyFilter({
    DateTime? selectedDate,
    int? selectedIndexForCategory,
    String? sortBy,
  }) {
    List<Transaction> _temp = [];
    if (selectedDate == null &&
        selectedIndexForCategory == null &&
        sortBy != null) {
      filteredTransaction = transaction;
    } else if (selectedDate == null &&
        selectedIndexForCategory != null &&
        sortBy == null) {
      _temp = transaction;
    }

    if (selectedDate != null) {
      filteredTransaction = [];
      transaction.forEach((tx) {
        if (DateFormat.yMd().format(tx.date) ==
            DateFormat.yMd().format(selectedDate)) {
          setState(() {
            filteredTransaction.add(tx);
          });
        }
      });
      _temp = filteredTransaction;
    }
    if (sortBy != null) {
      if (sortBy == Categories.newest)
        setState(() {
          filteredTransaction
              .sort((a, b) => b.date.compareTo(a.date));
        });
      if (sortBy == Categories.oldest)
        setState(() {
          filteredTransaction
              .sort((a, b) => a.date.compareTo(b.date));
        });

      if (sortBy == Categories.highest)
        setState(() {
          filteredTransaction.sort((a, b) => b.amount.compareTo(a.amount));
        });
      if (sortBy == Categories.lowest)
        setState(() {
          filteredTransaction.sort((a, b) => a.amount.compareTo(b.amount));
        });
    }

    if (selectedIndexForCategory != null) {
      filteredTransaction = [];
      String _tempCat =
          Categories.categoriesNames.keys.elementAt(selectedIndexForCategory);
      _temp.forEach((tx) {
        if (tx.category == _tempCat) {
          setState(() {
            filteredTransaction.add(tx);
          });
        }
      });
    }
    setState(() {
      _totalamount = 0.00;
      filteredTransaction.forEach((element) {
        _totalamount += element.amount;
      });
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SessionTitle(
                filteredTransaction.length == 0
                    ? LocaleKeys.all_transactions.tr()
                    : LocaleKeys.filter_transaction.tr(),
                false),
            Container(
              margin: const EdgeInsets.only(right: 18),
              child: IconButton(
                onPressed: () {
                  filteredTransaction.length == 0
                      ? _showCard(context)
                      : setState(
                          () {
                            filteredTransaction = [];
                            _totalamount = _amount;
                          },
                        );
                },
                icon: SvgPicture.asset("assets/icons/filter.svg"),
                tooltip: filteredTransaction.length == 0
                    ? LocaleKeys.filter_transaction.tr()
                    : LocaleKeys.all_transactions.tr(),
              ),
            )
          ],
        ),
        Card(
          elevation: 0.3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: ListTile(
            title: Text(
              LocaleKeys.total_spent.tr(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Text(
              "${_totalamount.toStringAsFixed(2)}",
              style: TextStyle(
                color: kExpensesRed,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        filteredTransaction.length == 0
            ? Column(children: allTxs(context))
            : Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: filteredTxs(context),
                ),
              ),
        if (transaction.length == 0)
          NoDataText(LocaleKeys.no_transaction_is_done_yet.tr()),
      ],
    );
  }

  padding(Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: child,
    );
  }

  List<Widget> allTxs(context) {
    return [
      if (_todayTransactions.length != 0)
        SessionTitle(LocaleKeys.today.tr(), false),
      padding(
        Column(
          children: [
            ..._todayTransactions
                .map(
                  (e) => ExpensesCardTile(
                    transaction: e,
                    currencySimbol: currencySimbol,
                    action: showCard,
                  ),
                )
                .toList(),
          ],
        ),
      ),
      if (_yesterdayTransactions.length != 0)
        SessionTitle(LocaleKeys.yesterday.tr(), false),
      padding(
        Column(
          children: [
            ..._yesterdayTransactions
                .map(
                  (e) => ExpensesCardTile(
                    transaction: e,
                    currencySimbol: currencySimbol,
                    action: showCard,
                  ),
                )
                .toList(),
          ],
        ),
      ),
      if (_beforeYesterdayTransactions.length != 0)
        SessionTitle(LocaleKeys.before_yesterday.tr(), false),
      padding(
        Column(
          children: [
            ..._beforeYesterdayTransactions
                .map(
                  (e) => ExpensesCardTile(
                    transaction: e,
                    currencySimbol: currencySimbol,
                    action: showCard,
                  ),
                )
                .toList(),
          ],
        ),
      ),
    ];
  }

  List<Widget> filteredTxs(context) {
    return [
      ...filteredTransaction
          .map(
            (e) => ExpensesCardTile(
              transaction: e,
              currencySimbol: currencySimbol,
              action: showCard,
            ),
          )
          .toList(),
    ];
  }
}
