import 'package:flutter/material.dart';
import '../screens/set_lang/set_lang.dart';
import '../screens/home_page/home_page.dart';
import '../screens/add_transaction.dart/add_transaction.dart';
import '../screens/pin_screen/pin_enter.dart';
import '../screens/pin_screen/setup_pin.dart';
import '../screens/settings/settings.dart';
import '../screens/all_set/all_set.dart';
import '../screens/intro_screen/intro_screen.dart';

final Map<String, WidgetBuilder> routes = {
  IntroScreen.routeName: (context) => IntroScreen(),
  PinScreen.routeName: (context) => PinScreen(),
  AllSet.routeName: (context) => AllSet(),
  HomePage.routeName: (context) => HomePage(),
  PinEnter.routeName: (context) => PinEnter(),
  AddTransaction.routeName: (context) => AddTransaction(),
  SettingsPage.routeName: (context) => SettingsPage(),
  SetLang.routeName: (context) => SetLang(),
};
