// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "app_name": "Personal expenses",
  "no_transaction_is_done_yet": "No transaction is done yet!",
  "transaction": "Transactions",
  "new_tx_title": "Title",
  "new_tc_amount": "Amount",
  "no_date_chosen": "No date Chosen",
  "choose_date": "Choose date",
  "add_transaction": "Add Transaction",
  "filter_transaction": "Filter Transactions",
  "show_all_transaction": "Show all transactions ",
  "clear_all_transaction": "Clear all Transactions",
  "picked_date": "Picked date",
  "languages": "Languages",
  "currency": "Currency"
};
static const Map<String,dynamic> ta = {
  "app_name": "தனிப்பட்ட செலவுகள்",
  "no_transaction_is_done_yet": "இதுவரை எந்த பரிவர்த்தனையும் செய்யப்படவில்லை!",
  "transaction": "பரிவர்த்தனைகள்",
  "new_tx_title": "தலைப்பு",
  "new_tc_amount": "தொகை",
  "no_date_chosen": "தேதி தேர்வு செய்யப்படவில்லை",
  "choose_date": "தேதியைத் தேர்வுசெய்க",
  "add_transaction": "பரிவர்த்தனை சேர்க்கவும்",
  "filter_transaction": "பரிவர்த்தனைகளை வடிகட்டவும்",
  "show_all_transaction": "அனைத்து பரிமாற்றங்களையும் காட்டு",
  "clear_all_transaction": "அனைத்து பரிமாற்றங்களையும் அழிக்கவும்",
  "picked_date": "தேர்ந்தெடுக்கப்பட்ட தேதி",
  "languages": "மொழிகள்",
  "currency": "நாணயம்"
};
static const Map<String,dynamic> ar = {
  "app_name": "المصاريف الشخصية",
  "no_transaction_is_done_yet": "لم تتم أي معاملة حتى الآن",
  "transaction": "معاملات تجارية",
  "new_tx_title": "عنوان",
  "new_tc_amount": "كمية",
  "no_date_chosen": "لم يتم إختيار التاريخ",
  "choose_date": "إختيار التاريخ",
  "add_transaction": "أضف معاملة",
  "filter_transaction": "تصفية المعاملات",
  "show_all_transaction": "عرض كل المعاملات",
  "clear_all_transaction": "مسح كل المعاملات",
  "picked_date": "التاريخ المختار",
  "languages": "اللغات",
  "currency": "عملة"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "ta": ta, "ar": ar};
}
