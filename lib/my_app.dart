import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import './local_storage/shared_preferences.dart';
import './screens/home_page/home_page.dart';
import './screens/pin_screen/pin_enter.dart';

import './config/routes.dart';
import './constants/constants.dart';
import './screens/intro_screen/intro_screen.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _tempPIN;
  var _isPINActive;
  @override
  void initState() {
    super.initState();
    _tempPIN = TransactionSharedPreferences.getSecurityPIN();
    _isPINActive = TransactionSharedPreferences.getIsPINActive();
  }

  Future _pin() async {
    if (_isPINActive == "false" || _isPINActive == false) {
      return HomePage.routeName;
    } else if (_tempPIN == null || _tempPIN == "") {
      return IntroScreen.routeName;
    } else {
      return PinEnter.routeName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _pin(),
      builder: (context, snapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            fontFamily: "Inter",
            primarySwatch: Colors.deepOrange,
            textTheme: TextTheme(
              bodyText1: TextStyle(color: kPrimaryTextColor),
              bodyText2: TextStyle(color: kPrimaryTextColor),
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          title: 'Personal Expenses',
          initialRoute: (snapshot.data).toString(),
          routes: routes,
        );
        // }
      },
    );
  }
}
