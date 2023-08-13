import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../models/transaction.dart';
import '../translations/locale_keys.g.dart';

class Helpers {
  final Transaction transaction;

  Helpers(this.transaction);

  Color get iconColor {
    switch (transaction.category) {
      case Categories.shopping:
        return kYellow100;
      case Categories.subscription:
        return kPurple100;
      case Categories.food:
        return kExpensesRed;
      case Categories.bank:
        return kBlue100;
      case Categories.transportation:
        return kGreen100;
      default:
        return Colors.redAccent;
    }
  }

  Color get iconBgColor {
    switch (transaction.category) {
      case Categories.shopping:
        return kYellow20;
      case Categories.subscription:
        return kPurple20;
      case Categories.food:
        return kExpensesRed20;
      case Categories.bank:
        return kBlue20;
      case Categories.transportation:
        return kGreen20;
      default:
        return Colors.redAccent.withOpacity(0.5);
    }
  }

  String get categoryTitle {
    switch (transaction.category) {
      case Categories.shopping:
        return LocaleKeys.shopping.tr();
      case Categories.subscription:
        return LocaleKeys.subscription.tr();
      case Categories.food:
        return LocaleKeys.food.tr();
      case Categories.bank:
        return LocaleKeys.bank.tr();
      case Categories.transportation:
        return LocaleKeys.transportation.tr();
      default:
        return "Expense";
    }
  }

  String get getIcon {
    switch (transaction.category) {
      case Categories.shopping:
        return "assets/icons/shopping-bag.svg";
      case Categories.subscription:
        return "assets/icons/recurring-bill.svg";
      case Categories.food:
        return "assets/icons/restaurant.svg";
      case Categories.bank:
        return "assets/icons/salary_bank.svg";
      case Categories.transportation:
        return "assets/icons/car.svg";
      default:
        return "assets/icons/expense.svg";
    }
  }

  String get getTime {
    var v =
        "${transaction.date.hour}:${transaction.date.minute}:${transaction.date.second}";
    return DateFormat.jm().format(DateFormat("hh:mm:ss").parse(v));
  }
}
