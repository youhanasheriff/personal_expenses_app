import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_app/translations/locale_keys.g.dart';

const kPrimaryColor100 = Color(0xFFD84315);
const kPrimaryColor80 = Color(0xFFDF6843);
const kPrimaryColor60 = Color(0xFFE68D71);
const kPrimaryColor40 = Color(0xFFEEB2A0);
const kPrimaryColor20 = Color(0xFFF5D7CE);

const kPurple100 = Color(0xFF7F3DFF);
const kPurple20 = Color(0xFFEEE5FF);

const kYellow100 = Color(0xFFFCAC12);
const kYellow20 = Color(0xFFFCEED4);

const kGreen100 = Color(0xFF00A86B);
const kGreen20 = Color(0xFFCFFAEA);

const kBlue100 = Color(0xFF0077FF);
const kBlue20 = Color(0xFFBDDCFF);

const kExpensesRed = Color(0xFFFD3C4A);
const kExpensesRed20 = Color(0xFFFDD5D7);
const kCardBackground = Color(0xFFFCFCFC);

const kBaseLight20 = Color(0xFF91919F);
const kBaseLight80 = Color(0xFFFCFCFC);

const kSecondaryLightColor = Color(0xFF91919F);

const kPrimaryTextColor = Color(0xFF212325);
const kSecondaryTextColor = Color(0xFF91919F);

const kColor = Color(0xFFEEE5FF);

const kHomeTopGradient = [
  Color(0xFFFFEBC5),
  Color(0x70FFEBC5),
];

class Categories {
  static const String subscription = "subscription";
  static const String food = "food";
  static const String bank = "bank";
  static const String shopping = "shopping";
  static const String transportation = "transportation";

  static Map<String, String> get categoriesNames {
    return {
      shopping: LocaleKeys.shopping.tr(),
      food: LocaleKeys.food.tr(),
      bank: LocaleKeys.bank.tr(),
      subscription: LocaleKeys.subscription.tr(),
      transportation: LocaleKeys.transportation.tr(),
    };
  }

  static String get highest => LocaleKeys.highest.tr();
  static String get lowest => LocaleKeys.lowest.tr();
  static String get newest => LocaleKeys.newest.tr();
  static String get oldest => LocaleKeys.oldest.tr();
}

enum GraphController {
  DAY,
  WEEK,
  MONTH,
  YEAR,
}
