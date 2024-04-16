import 'package:flutter/material.dart';

import '../styles/colors.dart';
import '../styles/textstyles.dart';

Widget greenButton(BuildContext context, String btnText,bool isVisible,Function callbackAction) {
  return Container(
    width: double.infinity,
    height: 60,
    child: TextButton(
      onPressed: () => callbackAction(),
      child: Padding(
        padding:  EdgeInsets.all(2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('  '),
            // SizedBox(width: 90),
             Text(btnText,style: percentSubTextStyle),
            // SizedBox(width: 100),
            isVisible?Icon(Icons.arrow_forward,
              color: whiteColor,
            ):Container(),
          ],
        ),
      ),
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
        primary: Colors.white,
        backgroundColor: greenColor,
      ),
    ),
  );
}
