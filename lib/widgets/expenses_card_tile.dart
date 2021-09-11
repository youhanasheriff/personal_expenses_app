import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../helpers/helpers.dart';
import '../models/transaction.dart';

import '../constants/constants.dart';

// ignore: must_be_immutable
class ExpensesCardTile extends StatelessWidget {
  final currencySimbol;
  final Transaction transaction;
  final action;
  ExpensesCardTile({
    Key? key,
    required this.transaction,
    required this.currencySimbol,
    required this.action,
  }) : super(key: key);

  var help;

  @override
  Widget build(BuildContext context) {
    help = Helpers(transaction);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: kCardBackground,
      elevation: 0.2,
      child: ListTile(
        onTap: () => action(context, transaction.id),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        leading: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: help.iconBgColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: SvgPicture.asset(
              help.getIcon,
              color: help.iconColor,
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              help.categoryTitle,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "$currencySimbol${transaction.amount.toStringAsFixed(2)}",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: kExpensesRed,
              ),
            ),
          ],
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              child: Text(
                transaction.title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: kBaseLight20,
                ),
              ),
            ),
            Text(
              help.getTime,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: kBaseLight20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class ExpenseCardContent extends StatelessWidget {
//   const ExpenseCardContent({
//     Key? key,
//     required this.iconBgColor,
//     required this.getIcon,
//     required this.iconColor,
//     required this.categoryTitle,
//     required this.amount,
//     required this.title,
//     required this.getTime,
//   }) : super(key: key);

//   final Color iconBgColor;
//   final String getIcon;
//   final Color iconColor;
//   final String categoryTitle;
//   final String amount;
//   final String title;
//   final String getTime;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         SizedBox(width: 15),
//         Container(
//           height: 50,
//           width: 50,
//           decoration: BoxDecoration(
//             color: iconBgColor,
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(5.0),
//             child: SvgPicture.asset(
//               getIcon,
//               color: iconColor,
//             ),
//           ),
//         ),
//         SizedBox(width: 15),
//         Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Text(
//                   categoryTitle,
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 // Spacer(),
//                 Text(
//                   "-\$$amount",
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                     color: kExpensesRed,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 11,
//             ),
//             Row(
//               children: [
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width * 0.45,
//                   child: Text(
//                     title,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       color: kBaseLight20,
//                     ),
//                   ),
//                 ),
//                 Text(
//                   getTime,
//                   style: TextStyle(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w600,
//                     color: kBaseLight20,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         SizedBox(
//           width: 20,
//         ),
//       ],
//     );
//   }
// }
