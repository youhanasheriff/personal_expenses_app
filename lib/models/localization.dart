class Languages {
  final int id;
  final String name;
  final String flag;
  final String languageCode;
  final String currencySimbol;

  Languages(
      this.id, this.name, this.flag, this.languageCode, this.currencySimbol);

  static List<Languages> languageList() {
    return <Languages>[
      Languages(1, 'English', '🇺🇸', 'en', '\$'),
      Languages(2, 'اَلْعَرَبِيَّةُ', '🇪🇬', 'ar', 'ر.'),
      Languages(3, 'தமிழ்', '🇮🇳', 'ta', '௹'),
    ];
  }
}

class CurrencyNames {
  static const DOLLAR = "Dollar";
  static const POUND = "Pound";
  static const RIAL = "﷼";
  static const EURO = "Euro";
  static const RUPEE = "Rupee";
  static const RUPEE_TAMIL = "ரூபாய்";
  static const YEN = "Yen";
  static const POUND_EGYPT = "جنيه مصري";
}

class CurrencySimbols {
  final int id;
  final String name;
  final String currencySimbol;

  CurrencySimbols(this.id, this.name, this.currencySimbol);

  static List<CurrencySimbols> simbolsList() {
    return <CurrencySimbols>[
      CurrencySimbols(01, CurrencyNames.DOLLAR, "\$"),
      CurrencySimbols(02, CurrencyNames.POUND, "£"),
      CurrencySimbols(03, CurrencyNames.RIAL, "ر."),
      CurrencySimbols(04, CurrencyNames.POUND_EGYPT, "ج"),
      CurrencySimbols(05, CurrencyNames.EURO, "€"),
      CurrencySimbols(06, CurrencyNames.RUPEE, "₹"),
      CurrencySimbols(07, CurrencyNames.RUPEE_TAMIL, "௹"),
      CurrencySimbols(08, CurrencyNames.YEN, "¥"),
    ];
  }
}

// personal expenses            = المصاريف الشخصية
//  No transaction is done yet! = لم تتم أي معاملة حتى الآن
// Transactions                 = معاملات تجارية 
// Title                        = عنوان
// Amount                       = كمية 
// No date Choosen              = لم يتم إختيار التاريخ
// Choose date                  = إختيار التاريخ
// Add Transaction              = أضف معاملة 
// filter Transactions          = تصفية المعاملات
// show all transactions        = عرض كل المعاملات
// clear all Transactions       = مسح كل المعاملات