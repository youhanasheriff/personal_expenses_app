import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../config/size_config.dart';
import '../../constants/constants.dart';

class BigButton extends StatelessWidget {
  final String text;
  final List<Color> color;
  final Function()? press;

  BigButton(
      {Key? key, required this.text, required this.press, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getPropotionalScreenHeight(60),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(color[0]),
        ),
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            color: color[1],
          ),
        ),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final String text;
  final Function()? press;

  const SecondaryButton({Key? key, required this.text, required this.press})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: SizedBox(
        width: double.infinity,
        height: getPropotionalScreenHeight(60),
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(kPrimaryColor20),
          ),
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              color: kPrimaryColor100,
            ),
          ),
        ),
      ),
    );
  }
}
