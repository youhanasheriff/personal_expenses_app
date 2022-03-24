import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class NoDataText extends StatelessWidget {
  final String text;
  const NoDataText(this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width * 0.9,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: kPrimaryTextColor.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
