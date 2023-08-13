import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/constants.dart';
import '../models/transaction.dart';
import '../translations/locale_keys.g.dart';
import '../widgets/button.dart';
import '../widgets/custom_scroll_bar/custom_radio_button.dart';
import '../widgets/session_title.dart';
import 'bottom_sheets.dart/category.dart';

class FilterTransaction extends StatefulWidget {
  final txs;
  final applyFilter;
  FilterTransaction(this.applyFilter, this.txs);
  @override
  _FilterTransactionState createState() => _FilterTransactionState();
}

class _FilterTransactionState extends State<FilterTransaction> {
  List<String> sortBy = [
    Categories.highest,
    Categories.lowest,
    Categories.newest,
    Categories.oldest,
  ];
  List<Transaction> filteredList = [];
  int? selectedIndexForBtn;
  int? _selectedIndexForCategory;
  String? _selectedCategory;
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
      filteredList = [];
      widget.txs.map((tx) {
        setState(() {
          _selectedDate = pickedDate;
        });
        if (DateFormat.yMd().format(tx.dateTime!) ==
            DateFormat.yMd().format(_selectedDate!)) {
          setState(() {
            filteredList.add(tx);
          });
        }
      }).toList();
    });
  }

  List<Widget> get btns {
    List<Padding> _temp = [];
    for (int i = 0; i < sortBy.length; i++) {
      _temp.add(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: CustomRadioBtn(
            text: sortBy[i],
            selectedIndex: selectedIndexForBtn,
            index: i,
            action: selectedBtn,
          ),
        ),
      );
    }
    return _temp;
  }

  void _reset() {
    setState(() {
      selectedIndexForBtn = null;
      _selectedCategory = null;
      _selectedDate = null;
      filteredList = [];
    });
  }

  void selectCategory(int index) {
    _selectedIndexForCategory = index;
    setState(() {
      _selectedCategory = Categories.categoriesNames.values.elementAt(index);
    });
  }

  void selectedBtn(index) {
    setState(() {
      selectedIndexForBtn = index;
    });
  }

  void _showCard(BuildContext ctx) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: ctx,
      builder: (_) {
        return CategoryBottomSheet(selectCategory: selectCategory);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    height: 5,
                    width: 35,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
              SessionTitle(
                LocaleKeys.filter_transaction.tr(),
                true,
                actionText: LocaleKeys.reset.tr(),
                action: _reset,
              ),
              SessionTitle(LocaleKeys.date.tr(), false),
              _padding(
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      LocaleKeys.choose_date.tr(),
                      style: TextStyle(fontSize: 17),
                    ),
                    _customInkWell(
                      action: _datePicker,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            (_selectedDate == null)
                                ? LocaleKeys.s0selected.tr()
                                : "${DateFormat.yMd().format(_selectedDate!)} Selected",
                            style: TextStyle(
                              color: kBaseLight20,
                            ),
                          ),
                          SvgPicture.asset(
                            "assets/icons/arrow-right-2.svg",
                            color: kPrimaryColor100,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SessionTitle(LocaleKeys.sort_by.tr(), false),
              _padding(
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: btns,
                ),
              ),
              SessionTitle(LocaleKeys.category.tr(), false),
              _padding(
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      LocaleKeys.choose_category.tr(),
                      style: TextStyle(fontSize: 17),
                    ),
                    _customInkWell(
                      action: () {
                        _showCard(context);
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _selectedCategory == null
                                ? LocaleKeys.s0selected.tr()
                                : "${_selectedCategory!} Selected",
                            style: TextStyle(
                              color: kBaseLight20,
                            ),
                          ),
                          SvgPicture.asset(
                            "assets/icons/arrow-right-2.svg",
                            color: kPrimaryColor100,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: BigButton(
                  text: LocaleKeys.apply.tr(),
                  press: () {
                    widget.applyFilter(
                      selectedDate: _selectedDate,
                      sortBy: selectedIndexForBtn != null
                          ? sortBy[selectedIndexForBtn!]
                          : null,
                      selectedIndexForCategory: _selectedIndexForCategory,
                    );
                  },
                  color: [
                    kPrimaryColor100,
                    Colors.white,
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _padding(Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: child,
    );
  }

  _customInkWell({required Widget child, required Function action}) {
    return InkWell(
      onTap: () {
        action();
      },
      splashColor: kPrimaryColor20,
      borderRadius: BorderRadius.circular(15),
      child: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: SizedBox(
          height: 30,
          child: child,
        ),
      ),
    );
  }
}
