import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/constants.dart';

class SettingsItems extends StatelessWidget {
  final String title;
  final String btnTitle;
  final action;
  const SettingsItems(
      {required this.title, required this.btnTitle, this.action});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, top: 8.0),
      child: InkWell(
        onTap: () {
          action(context);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              width: 200,
              height: 50,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Spacer(),
                  Text(
                    btnTitle,
                    style: TextStyle(
                      color: kPrimaryColor40,
                    ),
                  ),
                  SvgPicture.asset(
                    "assets/icons/arrow-right-2.svg",
                    color: kPrimaryColor60,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
