import 'package:flutter/material.dart';
import 'package:flutter_app/translations/locale_keys.g.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:intl/intl.dart';

import '../../helpers/helpers.dart';
import '../../local_storage/shared_preferences.dart';
import '../../models/transaction.dart';
import '../../constants/constants.dart';

class ExpenseDetails extends StatelessWidget {
  final String id;
  final List<Transaction> txs;
  final deleteFun;
  ExpenseDetails(this.id, this.txs, this.deleteFun);

  Transaction get tx {
    late Transaction _tx;
    txs.forEach((tx) {
      if (tx.id == id) {
        _tx = tx;
      }
    });
    return _tx;
  }

  String get _date {
    return DateFormat('EEE, dd-MMM-yyyy').format(tx.date);
  }

  String get _time {
    var v =
        "${tx.date.hour}:${tx.date.minute}:${tx.date.second}";
    return DateFormat.jm().format(DateFormat("hh:mm:ss").parse(v));
  }

  @override
  Widget build(BuildContext context) {
    var help = Helpers(tx);
    String _simbol = TransactionSharedPreferences.getCurrency() ?? "\$";
    return Wrap(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
              width: 100,
              height: 80,
              decoration: BoxDecoration(
                color: help.iconBgColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: SvgPicture.asset(
                help.getIcon,
                color: help.iconColor,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          color: Colors.white,
          width: double.infinity,
          height: 50,
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Text(
                "${tx.title}",
                softWrap: true,
                style: TextStyle(
                  color: help.iconColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: () => deleteFun(tx.id),
                icon: Icon(Icons.delete_forever_rounded),
                iconSize: 30,
                color: kExpensesRed,
                splashRadius: 1,
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "$_time",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "$_date",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          width: double.infinity,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: help.iconColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Text(
                  help.categoryTitle,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: help.iconBgColor,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Text(
                  LocaleKeys.description.tr(),
                  style: TextStyle(
                    color: kPrimaryTextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.only(left: 8.0, right: 8.0, top: 5.0),
                child: Text(
                  tx.description == "" || tx.description == null
                      ? LocaleKeys.there_is_no_description_available.tr()
                      : tx.description!,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Center(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  decoration: BoxDecoration(
                    color: help.iconColor,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Text(
                    "$_simbol${tx.amount}",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ],
    );
  }
}
