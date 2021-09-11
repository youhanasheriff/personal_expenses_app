import 'package:flutter/material.dart';

import '../config/size_config.dart';
import '../constants/constants.dart';

class SessionTitle extends StatelessWidget {
  final bool showBtn;
  final title;
  final actionText;
  final action;
  const SessionTitle(String this.title, this.showBtn,
      {this.action, this.actionText = "See All"});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getPropotionalScreenWidth(12),
        vertical: !showBtn ? 18 : 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          showBtn
              ? TextButton(
                  onPressed: action,
                  style: TextButton.styleFrom(
                    primary: kPrimaryColor100,
                    shadowColor: kPrimaryColor20,
                    backgroundColor: kPrimaryColor20,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                  child: Text(actionText),
                )
              : Container(),
        ],
      ),
    );
  }
}
