import 'package:flutter/material.dart';
import '../../constants/constants.dart';

class CustomRadioBtn extends StatelessWidget {
  final selectedIndex;
  final index;
  final text;
  final action;
  const CustomRadioBtn(
      {Key? key,
      this.selectedIndex,
      this.index,
      this.text = "Click",
      this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        action(index);
      },
      child: Text(
        text,
        style: TextStyle(
          color: selectedIndex == null
              ? kPrimaryTextColor
              : selectedIndex == index
                  ? kPrimaryColor100
                  : kPrimaryTextColor,
        ),
      ),
      style: ButtonStyle(
        backgroundColor: selectedIndex == null
            ? null
            : selectedIndex == index
                ? MaterialStateColor.resolveWith((_) => kPrimaryColor20)
                : null,
        shape: MaterialStateProperty.resolveWith(
          (states) => RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    );
  }
}
