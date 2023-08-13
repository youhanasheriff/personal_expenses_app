import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../models/transaction.dart';
import '../../screens/home_page/home_page.dart';
import '../../screens/pin_screen/setup_pin.dart';
import '../../translations/locale_keys.g.dart';
import '../../constants/constants.dart';
import '../../local_storage/shared_preferences.dart';
import '../../models/localization.dart';

import './components/settings_item.dart';

class SettingsPage extends StatefulWidget {
  static String routeName = "/settings_page";
  SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  void initState() {
    super.initState();
    String? _temp = TransactionSharedPreferences.getCurrency();
    CurrencySimbols.simbolsList().forEach(
      (element) {
        if (element.currencySimbol == _temp) {
          btnTitleCurrency = element.name;
        }
      },
    );
    String _lang = TransactionSharedPreferences.getLang() ?? "English";
    Languages.languageList().forEach((element) {
      if (element.name == _lang) {
        btnTitleLanguage = element.name;
      }
    });
    String? _tempActive = TransactionSharedPreferences.getIsPINActive();
    if (_tempActive == "true") {
      isPINActive = _tempActive == "true";
    } else if (_tempActive == "false") {
      isPINActive = _tempActive == "false";
    }
    pinPin = LocaleKeys.pin.tr();
    pinNone = LocaleKeys.none.tr();
    String? _tempPIN = TransactionSharedPreferences.getSecurityPIN();
    if (_tempPIN == null || _tempPIN == "") {
      isPINAlreadyThere = false;
      btnTitlePIN = pinNone;
    } else {
      isPINAlreadyThere = true;
      btnTitlePIN = pinPin;
    }
  }

  late String btnTitleCurrency = "Dollar";
  late String btnTitleLanguage;
  late String btnTitlePIN;
  late String pinPin;
  late String pinNone;
  late bool isPINAlreadyThere;
  late bool isPINActive;
  List<Map<String, dynamic>> items() {
    return [
      {
        "title": LocaleKeys.currency.tr(),
        "btnTitle": btnTitleCurrency,
        "action": _actionCurrency,
      },
      {
        "title": LocaleKeys.languages.tr(),
        "btnTitle": btnTitleLanguage,
        "action": _actionLanguage,
      },
      {
        "title": LocaleKeys.security.tr(),
        "btnTitle": btnTitlePIN,
        "action": _actionPIN,
      },
    ];
  }

  String currencySimbol = "\$";

  void currencySimbolFuntion(currency) {
    setState(() {
      currencySimbol = currency.currencySimbol;
    });
    TransactionSharedPreferences.setCurrency(currencySimbol);
  }

  void _changeLanguage(lang) {
    context.setLocale(Locale(lang.languageCode));
    TransactionSharedPreferences.setLang(lang.name);
  }

  void _changeIsPINActive(bool isActive) {
    TransactionSharedPreferences.setIsPINActive(isActive);
  }

  void _actionCurrency(BuildContext context) {
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
                setState(() {
                  currencySimbolFuntion(currency);
                  btnTitleCurrency = currency.name;
                });
              },
            );
          }).toList(),
        );
      },
    );
  }

  void _actionLanguage(BuildContext context) {
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
                setState(() {
                  btnTitleLanguage = lang.name;
                });
              },
            );
          }).toList(),
        );
      },
    );
  }

  void _actionPIN(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(pinPin),
          children: [true, false].map((item) {
            return ListTile(
              title: Text(item ? pinPin : pinNone),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  if (isPINAlreadyThere && item) return;
                  isPINActive = item;
                  btnTitlePIN = isPINActive ? pinPin : pinNone;
                  _changeIsPINActive(item);
                  if (item) {
                    Navigator.pushNamed(
                      context,
                      PinScreen.routeName,
                      arguments: IsPIN(true),
                    );
                  } else {
                    TransactionSharedPreferences.setSecurityPIN("");
                    isPINAlreadyThere = false;
                    btnTitlePIN = pinNone;
                  }
                });
              },
            );
          }).toList(),
        );
      },
    );
  }

  void _helpAction(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          LocaleKeys.we_will_add_this_page_soon.tr(),
        ),
        action: SnackBarAction(
          label: LocaleKeys.ok.tr(),
          onPressed: () {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, HomePage.routeName);
        return true;
      },
      child: Scaffold(
        key: _key,
        appBar: AppBar(
          leading: IconButton(
            icon: SvgPicture.asset(
              (Directionality.of(context).toString() == "TextDirection.ltr")
                  ? "assets/icons/arrow-left.svg"
                  : "assets/icons/arrow-right.svg",
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, HomePage.routeName);
            },
          ),
          elevation: 1.5,
          title: Text(
            LocaleKeys.settings.tr(),
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          backgroundColor: kCardBackground,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ...items()
                  .map(
                    (item) => SettingsItems(
                      title: item["title"]!,
                      btnTitle: item["btnTitle"]!,
                      action: item["action"],
                    ),
                  )
                  .toList(),
              SizedBox(height: 80),
              SettingsItems(
                title: LocaleKeys.help.tr(),
                btnTitle: "",
                action: () => _helpAction(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
