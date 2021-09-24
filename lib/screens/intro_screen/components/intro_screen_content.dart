import 'package:flutter/material.dart';

import '../../../config/size_config.dart';
import '../../../constants/constants.dart';

class IntroScreenContent extends StatelessWidget {
  final title;
  final subText;
  final img;
  const IntroScreenContent({
    Key? key,
    this.title,
    this.subText,
    this.img,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        Image.asset(
          img,
          width: getPropotionalScreenWidth(300),
          height: getPropotionalScreenHeight(300),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kPrimaryTextColor,
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Text(
            subText,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ),
        Spacer(),
      ],
    );
  }
}
