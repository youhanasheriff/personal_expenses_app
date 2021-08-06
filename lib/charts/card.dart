import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final label;
  final amount;
  final percentage;
  final String currencySimbol;
  ChartBar(this.label, this.amount, this.percentage, this.currencySimbol);

  double get totalPercentage {
    // print(amount);
    // print(percentage);
    // print((amount / percentage) == 0 ? 0 * 100 : (amount / percentage) * 100);
    return (amount / percentage) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        Container(
            height: (currencySimbol == "ر." || currencySimbol == "ج") ? 30 : 18,
            child: FittedBox(
              child: Text('$currencySimbol$amount'),
            )),
        SizedBox(
          height: 5,
        ),
        Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Colors.grey,
              ),
              height: MediaQuery.of(context).size.height * 0.1,
              width: 8,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: amount == 0.0
                    ? Colors.grey
                    : Theme.of(context).primaryColor,
              ),
              height: totalPercentage >= 0 ? (totalPercentage / 100) * 70 : 70,
              width: 8,
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Text('$label'),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
