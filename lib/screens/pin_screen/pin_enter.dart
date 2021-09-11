import 'package:flutter/material.dart';

import './pin_code_screen.dart';
import '../../screens/home_page/home_page.dart';
import '../../local_storage/shared_preferences.dart';

class PinEnter extends StatefulWidget {
  static String routeName = "/enter_pin";

  PinEnter({Key? key}) : super(key: key);

  @override
  _PinEnterState createState() => _PinEnterState();
}

class _PinEnterState extends State<PinEnter> {
  String _pin = "";
  String? _securityPIN = "";
  bool? _isPINTrue;

  @override
  void initState() {
    super.initState();
    _securityPIN = TransactionSharedPreferences.getSecurityPIN();
  }

  _pinEnter(String value) {
    if (_pin.length >= 4) return;

    setState(() {
      _pin += value;
    });
    Future.delayed(Duration(milliseconds: 50), () {
      if (_pin.length >= 4) {
        _comparePIN();
        return;
      }
    });
  }

  _comparePIN() {
    _isPINTrue = _pin == _securityPIN;

    if (_isPINTrue == true) {
      Navigator.of(context).pushReplacementNamed(HomePage.routeName);
    }
    setState(() {
      _pin = "";
    });
  }

  _eraseNumber() {
    if (_pin == "") return;
    if (_pin.length > 0) {
      String _temp = "";
      for (int q = 0; q < _pin.length - 1; q++) {
        _temp += _pin[q];
      }
      setState(() {
        _pin = _temp;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PinScreenPage(
      eraseNumber: _eraseNumber,
      pin: _pin,
      title: "Enter Your PIN", // TODO change
      pinEnter: _pinEnter,
      pinCompare: _isPINTrue,
      errorText: "Wrong PIN!!", // TODO change
    );
  }
}
