import 'package:flutter/material.dart';

class NumberPad extends StatelessWidget {
  final pickNumber;
  final bool isEnable;
  final eraseNumber;
  const NumberPad(
    this.pickNumber, {
    Key? key,
    this.isEnable = true,
    this.eraseNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        numberLine("1", "2", "3", pickNumber, eraseNumber, isEnable),
        numberLine("4", "5", "6", pickNumber, eraseNumber, isEnable),
        numberLine("7", "8", "9", pickNumber, eraseNumber, isEnable),
        numberLine("", "0", "<-", pickNumber, eraseNumber, isEnable),
      ],
    );
  }
}

Row numberLine(q, w, e, pickNumber, eraseNumber, isEnable) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: q != ""
            ? () {
                pickNumber(q);
              }
            : null,
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 40,
          child: Text(
            q,
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: () {
          pickNumber(w);
        },
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 40,
          child: Text(
            w,
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: () {
          if (e == "<-") {
            eraseNumber();
            return;
          }
          pickNumber(e);
        },
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 40,
          child: e == "<-"
              ? Icon(
                  Icons.backspace_rounded,
                  color: Colors.white,
                  size: 30,
                )
              : Text(
                  e,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    ],
  );
}
