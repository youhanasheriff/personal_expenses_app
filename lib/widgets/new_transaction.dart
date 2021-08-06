import 'package:flutter/material.dart';
import 'package:flutter_app/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _selectedDate;

  void _datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration:
                    InputDecoration(labelText: LocaleKeys.new_tx_title.tr()),
                controller: titleController,
              ),
              TextField(
                decoration:
                    InputDecoration(labelText: LocaleKeys.new_tc_amount.tr()),
                controller: amountController,
                keyboardType: TextInputType.number,
              ),
              Row(
                children: [
                  FittedBox(
                    child: Container(
                      width: MediaQuery.of(context).size.width * .4,
                      child: Text(
                        _selectedDate == null
                            ? LocaleKeys.no_date_chosen.tr()
                            : '${LocaleKeys.picked_date.tr()}: ${DateFormat.yMd().format(_selectedDate!)}',
                      ),
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: _datePicker,
                    child: Text(
                      LocaleKeys.choose_date.tr(),
                    ),
                  )
                ],
              ),
              ElevatedButton(
                child: Text(LocaleKeys.add_transaction.tr()),
                onPressed: () {
                  if (titleController.text == '' ||
                      amountController.text == '' ||
                      _selectedDate == null) {
                    return;
                  }
                  widget.addTx(titleController.text,
                      double.parse(amountController.text), _selectedDate);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
