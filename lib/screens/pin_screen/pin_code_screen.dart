import 'package:flutter/material.dart';

import './components/number_pad.dart';

class PinScreenPage extends StatelessWidget {
  final String pin;
  final Function pinEnter;
  final Function eraseNumber;
  final bool isEnable;
  final String title;
  final bool? pinCompare;
  final String errorText;
  PinScreenPage({
    Key? key,
    this.pin = "",
    required this.pinEnter,
    required this.eraseNumber,
    this.isEnable = true,
    required this.title,
    required this.pinCompare,
    this.errorText = "Please enter the same PIN!", // TODO change
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Widget emptyCircle = CircleAvatar(
      radius: 15,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: 13,
        backgroundColor: Colors.deepOrange,
        child: Container(),
      ),
    );

    Widget circle = CircleAvatar(
      radius: 15,
      backgroundColor: Colors.white,
      child: Container(),
    );
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: pinCompare != false
                  ? TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )
                  : TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.red,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
              child: Text(
                pinCompare == null
                    ? title
                    : pinCompare == false
                        ? errorText
                        : title,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(),
                pin == ""
                    ? emptyCircle
                    : pin.length >= 1
                        ? circle
                        : emptyCircle,
                pin == ""
                    ? emptyCircle
                    : pin.length >= 2
                        ? circle
                        : emptyCircle,
                pin == ""
                    ? emptyCircle
                    : pin.length >= 3
                        ? circle
                        : emptyCircle,
                pin == ""
                    ? emptyCircle
                    : pin.length >= 4
                        ? circle
                        : emptyCircle,
                SizedBox(),
              ],
            ),
            NumberPad(
              pinEnter,
              isEnable: isEnable,
              eraseNumber: eraseNumber,
            ),
          ],
        ),
      ),
    );
  }
}
