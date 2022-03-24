import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_app/translations/locale_keys.g.dart';

import '../../../constants/constants.dart';
import '../../../screens/pin_screen/setup_pin.dart';
import '../../../widgets/button.dart';

import './intro_screen_content.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> pageData = [
    {
      "image": "assets/images/intro/cash_on_hand.png",
      "title": LocaleKeys.gain_total_control_of_your_money.tr(),
      "subText": LocaleKeys.become_your_ouw_expense_manager.tr()
    },
    {
      "image": "assets/images/intro/list_and_cash.png",
      "title": LocaleKeys.know_where_your_money_goes.tr(),
      "subText": LocaleKeys.track_your_spending.tr()
    },
    {
      "image": "assets/images/intro/plan_pad.png",
      "title": LocaleKeys.plan_whats_yours.tr(),
      "subText": LocaleKeys.get_your_own_report.tr()
    },
  ];

  late PageController _pageController;

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: PageView.builder(
              itemCount: pageData.length,
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return IntroScreenContent(
                  img: pageData[index]["image"],
                  title: pageData[index]["title"],
                  subText: pageData[index]["subText"],
                );
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(pageData.length, (index) {
                    return buildDot(index);
                  }),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 2.0),
                  child: BigButton(
                    text: LocaleKeys.continue_page.tr(),
                    press: currentPage < 2
                        ? () {
                            _pageController.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn,
                            );
                          }
                        : () {
                            Navigator.of(context)
                                .popAndPushNamed(PinScreen.routeName);
                          },
                    color: [kPrimaryColor100, Colors.white],
                  ),
                ),
                SizedBox(height: 20),
                if (currentPage < 2)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 2.0),
                    child: BigButton(
                      text: LocaleKeys.skip.tr(),
                      press: () {
                        _pageController.jumpToPage(2);
                      },
                      color: [kPrimaryColor20, kPrimaryColor100],
                    ),
                  ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AnimatedContainer buildDot(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      margin: EdgeInsets.only(right: 3),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor80 : kSecondaryTextColor,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
