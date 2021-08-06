import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../charts/card.dart';

class Charts extends StatelessWidget {
  final recentTxs;
  final String currencySimbol;
  Charts(this.recentTxs, this.currencySimbol);

  List get txs {
    return List.generate(7, (index) {
      final weekDays = DateTime.now().subtract(Duration(days: index));
      double totalAmount = 0.0;

      for (int i = 0; i < recentTxs.length; i++) {
        if (recentTxs[i].date.day == weekDays.day &&
            recentTxs[i].date.day == weekDays.day &&
            recentTxs[i].date.month == weekDays.month) {
          totalAmount += recentTxs[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDays),
        'amount': totalAmount,
      };
    });
  }

  double get apt {
    double temp = 0.0;
    for (int i = 0; i < txs.length; i++) {
      temp += txs[i]['amount'];
    }
    return temp;
  }

  List<Widget> get getTx {
    List<Widget> reversedList = new List.from(txs
        .map((tx) {
          return Expanded(
              child: ChartBar(tx['day'], tx['amount'], apt, currencySimbol));
        })
        .toList()
        .reversed);
    return reversedList;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(2),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: getTx,
        ),
      ),
    );
  }
}
