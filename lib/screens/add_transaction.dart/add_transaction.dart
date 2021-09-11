import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../local_storage/shared_preferences.dart';
import '../../constants/constants.dart';
import '../../models/transaction.dart';
import '../../translations/locale_keys.g.dart';
import '../../widgets/button.dart';
import '../../widgets/custom_scroll_bar/expanded_section.dart';
import '../../widgets/scroll_bar.dart';

class AddTransaction extends StatefulWidget {
  static String routeName = "/add_transaction";
  AddTransaction({Key? key}) : super(key: key);

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  Map categoryName = Categories.categoriesNames;
  bool isStrechedDropDown = false;
  int? groupValue;
  late String title;
  String? selectedCategory;
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();
  DateTime? finalDateAndTime;
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  String currencySimbol = "\$";
  String? _datetime;

  @override
  void initState() {
    super.initState();
    String _tempSimbol = TransactionSharedPreferences.getCurrency();
    currencySimbol = _tempSimbol;
    title = LocaleKeys.select_category.tr();
  }

  void _datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;

      showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      ).then((pickedTime) {
        if (pickedTime == null) return;

        finalDateAndTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        setState(() {
          String? _temp;
          String _tempDay =
              finalDateAndTime!.day.toString().length == 1 ? "0" : "";
          String _tempMonth =
              finalDateAndTime!.month.toString().length == 1 ? "0" : "";
          _temp =
              "$_tempDay${finalDateAndTime!.day}/$_tempMonth${finalDateAndTime!.month}/${finalDateAndTime!.year}";
          _datetime = _temp;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var addTx = ModalRoute.of(context)!.settings.arguments as AddTx;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kExpensesRed,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            (Directionality.of(context).toString() == "TextDirection.ltr")
                ? "assets/icons/arrow-left.svg"
                : "assets/icons/arrow-right.svg",
            color: Colors.white,
          ),
        ),
        toolbarHeight: 90,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(LocaleKeys.expense.tr()),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: double.infinity,
              margin:
                  (Directionality.of(context).toString() == "TextDirection.ltr")
                      ? const EdgeInsets.only(top: 130, left: 25.0)
                      : const EdgeInsets.only(top: 130, right: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.how_much.tr(),
                    style: TextStyle(
                      color: kBaseLight80,
                      fontSize: 18,
                    ),
                  ),
                  // SizedBox(height: 8),
                  Stack(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          hintText: (Directionality.of(context).toString() ==
                                  "TextDirection.ltr")
                              ? "$currencySimbol"
                              : "",
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 58,
                          ),
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                        ),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 58,
                        ),
                      ),
                      TextField(
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 58,
                        ),
                        controller: amountController,
                        decoration: InputDecoration(
                          hintText: LocaleKeys.enter_amount.tr(),
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                          ),
                          prefixText: "$currencySimbol",
                          prefixStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 58,
                          ),
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: size.height * 1.3,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    custom(),
                    SizedBox(height: 10),
                    TextField(
                      focusNode: _focusNode1,
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: LocaleKeys.new_tx_title.tr(),
                        hintStyle: TextStyle(color: kBaseLight20),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: kBaseLight20,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onSubmitted: (_) {
                        _focusNode2.requestFocus();
                      },
                    ),
                    SizedBox(height: 20),
                    TextField(
                      focusNode: _focusNode2,
                      controller: descriptionController,
                      decoration: InputDecoration(
                        hintText: LocaleKeys.description.tr(),
                        hintStyle: TextStyle(color: kBaseLight20),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: kBaseLight20,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    InkWell(
                      onTap: _datePicker,
                      child: Container(
                        height: 56,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: kBaseLight20,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              _datetime == null
                                  ? LocaleKeys.choose_date_time.tr()
                                  : _datetime!,
                              style: TextStyle(
                                color: kBaseLight20,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Text(
                        "* ${LocaleKeys.default_date_time.tr()}",
                        style: TextStyle(
                          color: kBaseLight20,
                        ),
                      ),
                    ),
                    SizedBox(height: 35),
                    BigButton(
                      text: LocaleKeys.add_expense.tr(),
                      press: () {
                        if (finalDateAndTime == null) {
                          finalDateAndTime = DateTime.now();
                        }
                        if (titleController.text == '' ||
                            amountController.text == '') {
                          return;
                        }
                        addTx.addTx(
                          txTitle: titleController.text,
                          description: descriptionController.text,
                          category: selectedCategory,
                          txAmount: double.parse(amountController.text),
                          selectedDate: finalDateAndTime,
                        );
                      },
                      color: [
                        kPurple100,
                        kPurple20,
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  custom() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xffbbbbbb),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 56,
                        width: double.infinity,
                        padding: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xffbbbbbb),
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        constraints: BoxConstraints(
                          minHeight: 56,
                          minWidth: double.infinity,
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isStrechedDropDown = !isStrechedDropDown;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Text(
                                    title,
                                    style: TextStyle(
                                      color: title ==
                                              LocaleKeys.select_category.tr()
                                          ? kBaseLight20
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isStrechedDropDown = !isStrechedDropDown;
                                });
                              },
                              child: SvgPicture.asset(
                                isStrechedDropDown
                                    ? "assets/icons/arrow-up-2.svg"
                                    : "assets/icons/arrow-down-2.svg",
                                color: kBaseLight20,
                              ),
                            )
                          ],
                        ),
                      ),
                      ExpandedSection(
                        expand: isStrechedDropDown,
                        height: 150,
                        child: MyScrollbar(
                          builder: (context, scrollController2) =>
                              ListView.builder(
                            padding: EdgeInsets.all(0),
                            controller: scrollController2,
                            shrinkWrap: true,
                            itemCount: categoryName.length,
                            itemBuilder: (context, index) {
                              return RadioListTile(
                                title: Text(
                                  categoryName.values.elementAt(index),
                                ),
                                value: index,
                                groupValue: groupValue,
                                onChanged: (int? val) {
                                  setState(() {
                                    groupValue = val;
                                    title =
                                        categoryName.values.elementAt(index);
                                    selectedCategory =
                                        categoryName.keys.elementAt(index);
                                    isStrechedDropDown = !isStrechedDropDown;
                                  });
                                  _focusNode1.requestFocus();
                                },
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
