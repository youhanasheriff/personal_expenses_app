import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_app/config/size_config.dart';
import 'package:flutter_app/constants/constants.dart';
import 'package:flutter_app/local_storage/shared_preferences.dart';
import 'package:flutter_app/models/localization.dart';
import 'package:flutter_app/screens/intro_screen/intro_screen.dart';
import 'package:flutter_app/widgets/button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SetLang extends StatefulWidget {
  static String routeName = "/set_lang";
  SetLang({Key? key}) : super(key: key);

  @override
  _SetLangState createState() => _SetLangState();
}

class _SetLangState extends State<SetLang> {
  int currentIndex = 0;

  void _selectLang(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void _changeLanguage(lang) {
    context.setLocale(Locale(lang.languageCode));
    TransactionSharedPreferences.setLang(lang.name);
  }

  void _changeLocaleAndContinue() {
    switch (currentIndex) {
      case 0:
        _changeLanguage(Languages.languageList()[0]);
        break;
      case 1:
        _changeLanguage(Languages.languageList()[1]);
        break;
      case 2:
        _changeLanguage(Languages.languageList()[2]);
        break;
      default:
    }
    Navigator.popAndPushNamed(context, IntroScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(25, 25, 0, 0),
            color: kExpensesRed,
            height: double.infinity,
            width: double.infinity,
            child: SafeArea(
              child: Text(
                "Select Language",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              margin: const EdgeInsets.only(top: 70),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: SvgPicture.asset(
                      "assets/icons/lang.svg",
                      width: getPropotionalScreenWidth(300),
                      height: getPropotionalScreenHeight(300),
                    ),
                  ),
                  customRadioBtn("English", _selectLang, 0),
                  SizedBox(height: 15),
                  customRadioBtn("Arabic", _selectLang, 1),
                  SizedBox(height: 15),
                  customRadioBtn("Tamil", _selectLang, 2),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: BigButton(
                      text: "Continue",
                      press: _changeLocaleAndContinue,
                      color: [kPrimaryColor100, kPrimaryColor20],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Text(
                      "* You can change it later in setting",
                      style: TextStyle(
                        color: kBaseLight20,
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget customRadioBtn(String title, Function action, int index) {
    return InkWell(
      onTap: () => action(index),
      child: Container(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kPurple20,
              ),
              child: Center(
                child: Container(
                  height: 26,
                  width: 26,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentIndex == index ? kPurple100 : kPurple20,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
