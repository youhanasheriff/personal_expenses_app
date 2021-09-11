import 'package:flutter/material.dart';

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
    //TODO change
    {
      "image": "assets/images/intro/cash_on_hand.png",
      "title": "Gain total control \n of your money",
      "subText":
          "Become your own expenses manager\n and make every cent \ncount"
    },
    {
      "image": "assets/images/intro/list_and_cash.png",
      "title": "Know where your \nmoney goes",
      "subText":
          "Track your spendings easily,\n with categories and financial report "
    },
    {
      "image": "assets/images/intro/plan_pad.png",
      "title": "Plan what’s yours",
      "subText": "Get your own report with categories"
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
                    text: "Continue", //TODO change
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
                      text: "Skip", //TODO change
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
