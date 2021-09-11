import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../screens/home_page/home_page.dart';

class AllSet extends StatelessWidget {
  static String routeName = "/all_set";
  const AllSet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: InkWell(
          onTap: () {
            Navigator.of(context).popAndPushNamed(HomePage.routeName);
          },
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.check_rounded,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 25),
                Text(
                  "You are set!!", // TODO change
                  style: TextStyle(
                    color: kPrimaryTextColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Text(
                  "Tap to continue...", // TODO change
                  style: TextStyle(
                    color: kPrimaryTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
