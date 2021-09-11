import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../screens/settings/settings.dart';
import '../../../translations/locale_keys.g.dart';
import '../../../config/size_config.dart';
import '../../../constants/constants.dart';

class HomeTopPanel extends StatelessWidget {
  final String totalAmount;
  final showSnackBar;
  final currencySimbol;
  const HomeTopPanel({
    Key? key,
    this.totalAmount = "0.0",
    this.showSnackBar,
    required this.currencySimbol,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getPropotionalScreenHeight(225),
      padding: EdgeInsets.only(top: getPropotionalScreenHeight(5)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
        gradient: LinearGradient(
          colors: kHomeTopGradient,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          Container(
            height: getPropotionalScreenHeight(60),
            padding:
                EdgeInsets.symmetric(horizontal: getPropotionalScreenWidth(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  tooltip: LocaleKeys.settings.tr(),
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, SettingsPage.routeName);
                  },
                  icon: Container(
                    height: getPropotionalScreenHeight(30),
                    width: getPropotionalScreenWidth(30),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Colors.blueAccent,
                          Colors.redAccent,
                          Colors.pinkAccent,
                          Colors.purple
                        ],
                      ),
                    ),
                    child: Center(
                      child: Container(
                        height: getPropotionalScreenHeight(28),
                        width: getPropotionalScreenWidth(28),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: SvgPicture.asset(
                          "assets/icons/settings.svg",
                          color: kPrimaryColor100,
                          height: getPropotionalScreenHeight(24),
                          width: getPropotionalScreenWidth(24),
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  LocaleKeys.app_name.tr(),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                IconButton(
                  tooltip: LocaleKeys.notification.tr(),
                  onPressed: () {
                    showSnackBar(
                      LocaleKeys.notification_will_be_added_in_update.tr(),
                      LocaleKeys.ok.tr(),
                    );
                  },
                  icon: SvgPicture.asset(
                    "assets/icons/notification.svg",
                    color: kPurple100,
                    height: getPropotionalScreenHeight(38),
                    width: getPropotionalScreenWidth(38),
                  ),
                ),
              ],
            ),
          ),
          Spacer(flex: 2),
          Container(
            height: getPropotionalScreenHeight(100),
            width: getPropotionalScreenWidth(200),
            decoration: BoxDecoration(
              color: kExpensesRed,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 25),
                  Container(
                    height: getPropotionalScreenHeight(50),
                    width: getPropotionalScreenWidth(50),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        "assets/icons/expense.svg",
                        color: kExpensesRed,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.expenses.tr(),
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 6),
                      SizedBox(
                        width: 120,
                        child: Text(
                          "$currencySimbol$totalAmount",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
          Spacer(flex: 1),
        ],
      ),
    );
  }
}
