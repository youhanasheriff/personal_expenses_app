import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_app/helpers/transaction_helper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import './components/home_top_panel.dart';
import './all_transactions/all_transactions.dart';
import './components/no_data_text.dart';
import '../../models/transaction.dart';
import '../../widgets/expenses_card_tile.dart';
import '../../widgets/graph_chart.dart';
import '../../config/size_config.dart';
import '../../constants/constants.dart';
import '../../widgets/session_title.dart';
import '../../../local_storage/shared_preferences.dart';
import '../../../screens/add_transaction.dart/add_transaction.dart';
import '../../../translations/locale_keys.g.dart';
import '../../../widgets/expense_details/expense_details.dart';

class HomePage extends StatefulWidget {
  static String routeName = "/home_page";
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _key = GlobalKey();
  late List<Transaction> _transaction;
  GraphController _graphController = GraphController.WEEK;
  int _currentPage = 0;
  late PageController _pageController;
  String currencySimbol = "\$";

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _transaction = TransactionSharedPreferences.getTransactions();
    currencySimbol = TransactionSharedPreferences.getCurrency();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<Transaction> get _todayTransactions {
    String _selectedDate = DateFormat.yMd().format(DateTime.now());
    List<Transaction> _temp = [];
    _transaction.forEach((tx) {
      if (DateFormat.yMd().format(tx.date) == _selectedDate) {
        _temp.add(tx);
      }
    });
    _temp.sort((a, b) => a.date.compareTo(b.date));
    return _temp;
  }

  List<Transaction> get _weekTransactions {
    List<Transaction> _temp = _transaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
    _temp.sort((a, b) => a.date.compareTo(b.date));
    return _temp;
  }

  List<Transaction> get _recentTransaction {
    List<Transaction> _temp = _weekTransactions;
    _temp.sort((a, b) => b.date.compareTo(a.date));
    return _temp;
  }

  List<Transaction> get _monthTransactions {
    List<Transaction> _temp = _transaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 28)));
    }).toList();
    _temp.sort((a, b) => a.date.compareTo(b.date));
    return _temp;
  }

  List<Transaction> get _yearTransactions {
    List<Transaction> _temp = _transaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 365)));
    }).toList();
    _temp.sort((a, b) => a.date.compareTo(b.date));
    return _temp;
  }

  List<Transaction> get _transactionForGraph {
    switch (_graphController) {
      case GraphController.DAY:
        return _todayTransactions;
      case GraphController.WEEK:
        return _weekTransactions;
      case GraphController.MONTH:
        return _monthTransactions;
      case GraphController.YEAR:
        return _yearTransactions;
      default:
        return _todayTransactions;
    }
  }

  String get totalAmountOfTranaction {
    double _temp = 0.0;
    _monthTransactions.forEach((e) {
      setState(() {
        _temp += e.amount;
      });
    });
    return _temp.toStringAsFixed(2);
  }

  void _addNewTransaction({
    required String? txTitle,
    String description = "",
    required String? category,
    required double? txAmount,
    required DateTime? selectedDate,
  }) {
    if (txTitle == null ||
        category == null ||
        txAmount == null ||
        txAmount <= 0 ||
        selectedDate == null) {
      return;
    }

    final newTx = Transaction(
      title: txTitle,
      description: description,
      category: category,
      amount: txAmount,
      date: selectedDate,
      id: DateTime.now().toString(),
    );
    setState(() {
      _transaction.add(newTx);
      TransactionSharedPreferences.setTransactions(_transaction);
    });
    Navigator.of(context).pop();
  }

  void jumpTo2() {
    _pageController.jumpToPage(1);
  }

  void deleteFun(id) {
    HelpTransaction h = HelpTransaction();
    List<Transaction> _tx = h.deleteTransaction(_transaction, id);
    setState(() {
      _transaction = _tx;
    });
    Navigator.pop(context);
  }

  void showCard(BuildContext ctx, String id) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: ctx,
      builder: (_) {
        return ExpenseDetails(id, _transaction, deleteFun);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _key,
      body: SafeArea(
        child: PageView(
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          controller: _pageController,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  HomeTopPanel(
                    totalAmount: totalAmountOfTranaction,
                    showSnackBar: customSnackbar,
                    currencySimbol: currencySimbol,
                  ),
                  SessionTitle(LocaleKeys.expenses_graph.tr(), false),
                  _transaction.length >= 4
                      ? GraphChart(
                          transactions: _transactionForGraph,
                          graphController: _graphController,
                        )
                      : NoDataText(LocaleKeys.not_enough_data_for_graph.tr()),
                  customTextButtonGroup(),
                  _transaction.length == 0
                      ? NoDataText(LocaleKeys.no_transaction_is_done_yet.tr())
                      : recentTx(),
                ],
              ),
            ),
            SingleChildScrollView(
              child: AllTransactions(_transaction, deleteFun),
            ),
          ],
        ),
      ),
      floatingActionButton: floatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  Column recentTx() {
    return Column(
      children: [
        SessionTitle(
          LocaleKeys.recent_transaction.tr(),
          true,
          action: jumpTo2,
        ),
        _recentTransaction.length == 0 ?
        NoDataText(LocaleKeys.no_transaction_is_done_yet.tr()) :
        recentTransaction(),
      ],
    );
  }

  Container recentTransaction() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          ..._recentTransaction.map((data) {
            return ExpensesCardTile(
              transaction: data,
              currencySimbol: currencySimbol,
              action: showCard,
            );
          }).toList(),
        ],
      ),
    );
  }

  SizedBox floatingActionButton(BuildContext context) {
    return SizedBox(
      height: 65,
      width: 65,
      child: FloatingActionButton(
        backgroundColor: kPrimaryColor100,
        elevation: 0.0,
        child: Icon(
          Icons.add_rounded,
          size: 45,
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(
            AddTransaction.routeName,
            arguments: AddTx(_addNewTransaction),
          );
        },
      ),
    );
  }

  BottomAppBar bottomNavigationBar() {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                _pageController.jumpToPage(0);
              },
              icon: SvgPicture.asset(
                "assets/icons/home.svg",
                color: _currentPage == 0 ? kPrimaryColor100 : Colors.grey,
                height: getPropotionalScreenHeight(35),
                width: getPropotionalScreenWidth(35),
              ),
            ),
            SizedBox.shrink(),
            IconButton(
              onPressed: () {
                _transaction.length == 0
                    ? customSnackbar(
                        LocaleKeys.no_transaction_is_done_yet.tr(),
                        LocaleKeys.ok.tr(),
                      )
                    : _pageController.jumpToPage(1);
              },
              icon: SvgPicture.asset(
                "assets/icons/transaction.svg",
                color: _currentPage == 1 ? kPrimaryColor100 : Colors.grey,
                height: getPropotionalScreenHeight(35),
                width: getPropotionalScreenWidth(35),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> customSnackbar(
      String text, String btnText) {
    // ignore: deprecated_member_use
    return _key.currentState!.showSnackBar(
      SnackBar(
        content: Text(
          text,
        ),
        action: SnackBarAction(
          label: btnText,
          onPressed: () {},
        ),
      ),
    );
  }

  Padding customTextButtonGroup() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          customTextButtons(GraphController.DAY, LocaleKeys.day.tr()),
          customTextButtons(GraphController.WEEK, LocaleKeys.week.tr()),
          customTextButtons(GraphController.MONTH, LocaleKeys.month.tr()),
          customTextButtons(GraphController.YEAR, LocaleKeys.year.tr()),
        ],
      ),
    );
  }

  TextButton customTextButtons(GraphController control, String text) {
    return TextButton(
      onPressed: () {
        setState(() {
          _graphController = control;
        });
      },
      style: _graphController == control
          ? TextButton.styleFrom(
              primary: kPrimaryColor100,
              shadowColor: kPrimaryColor20,
              backgroundColor: kPrimaryColor20,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
            )
          : TextButton.styleFrom(
              primary: kSecondaryTextColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
            ),
      child: Text(text),
    );
  }
}
