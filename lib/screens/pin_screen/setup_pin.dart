import 'package:flutter/material.dart';
import 'package:flutter_app/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

import './pin_code_screen.dart';
import '../../local_storage/shared_preferences.dart';
import '../../models/transaction.dart';
import '../../screens/all_set/all_set.dart';
import '../../screens/settings/settings.dart';

class PinScreen extends StatefulWidget {
  static String routeName = "/setup_pin";
  PinScreen({Key? key}) : super(key: key);

  @override
  _PinScreenState createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  List<String> title = [ LocaleKeys.lets_setup_your_pin.tr(), LocaleKeys.ok_re_type_your_pin.tr(),];
  List<String> _pin = ["", ""];
  bool isEnable = true;
  bool? _isPINTrue;
  int _currentPage = 0;
  bool isPIN = false;
  late PageController _pageController;

  _pinEnter(String value) {
    if (_pin[_currentPage].length >= 4) return;

    setState(() {
      _pin[_currentPage] += value;
    });

    if (_pin[_currentPage].length >= 4) {
      if (_currentPage >= 1) {
        _comparePIN();
        return;
      }
      onDone();
      return;
    }
  }

  eraseNumber() {
    if (_pin[_currentPage] == "") return;
    if (_pin[_currentPage].length > 0) {
      String _temp = "";
      for (int q = 0; q < _pin[_currentPage].length - 1; q++) {
        _temp += _pin[_currentPage][q];
      }
      setState(() {
        _pin[_currentPage] = _temp;
      });
    }
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  onDone() {
    _pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  Future _comparePIN() async {
    setState(() {
      _isPINTrue = _pin[0] == _pin[1];
    });

    if (_isPINTrue == true) {
      if (isPIN) {
        Navigator.of(context).popAndPushNamed(SettingsPage.routeName);
      } else {
        Navigator.of(context).popAndPushNamed(AllSet.routeName);
      }
      await TransactionSharedPreferences.setSecurityPIN(_pin[0]);
    } else {
      setState(() {
        _pin = [_pin[0], ""];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var isPIN = ModalRoute.of(context)!.settings.arguments;
    if (isPIN != null) {
      isPIN as IsPIN;
      this.isPIN = isPIN.isPIN;
    }
    return PageView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: title.length,
      onPageChanged: (index) {
        _currentPage = index;
      },
      controller: _pageController,
      itemBuilder: (context, index) {
        return PinScreenPage(
          eraseNumber: eraseNumber,
          pin: _pin[index],
          title: title[index],
          isEnable: isEnable,
          pinEnter: _pinEnter,
          pinCompare: _isPINTrue,
          // onDone: onDone,
        );
      },
    );
  }
}
