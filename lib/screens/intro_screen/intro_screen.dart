import 'package:flutter/material.dart';
import '../../config/size_config.dart';
import '../../screens/intro_screen/components/body.dart';

class IntroScreen extends StatelessWidget {
  static String routeName = "/intro_screen";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Body(),
    );
  }
}
