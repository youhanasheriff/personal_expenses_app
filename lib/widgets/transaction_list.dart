import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final deleteTx;
  final String currencySimbol;
  TransactionList(this.transactions, this.deleteTx, this.currencySimbol);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.52,
      child: SingleChildScrollView(
        child: Column(
          children: transactions.map((tx) {
            return Container(
              height: 90,
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              child: Card(
                elevation: 3,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 8,
                    ),
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Theme.of(context).accentColor,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(
                          child: Text(
                            '$currencySimbol${tx.amount}',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          tx.title!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          DateFormat.yMMMEd().format(tx.date!),
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        deleteTx(tx.id);
                      },
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).primaryColorDark,
                    ),
                    SizedBox(
                      width: 4,
                    )
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
