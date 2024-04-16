// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:video_player_app/styles/colors.dart';

import '../../../styles/textstyles.dart';
import '../../../widgets/green_button.dart';
import 'otp_verification.dart';

class NumberVerificationPage extends StatefulWidget {
  NumberVerificationPage({Key? key}) : super(key: key);

  @override
  _NumberVerificationPageState createState() => _NumberVerificationPageState();
}

class _NumberVerificationPageState extends State<NumberVerificationPage> {
  final _formKey = GlobalKey<FormState>();

  dynamic countryCode = '+91';
  dynamic mobileNumber = '';

  void onSignUp() async {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) =>
                  OtpVerificationPage()));
  }

  void onCancelPressed() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (_) => NumberVerificationPage()));
    // Navigator.of(context).pop();
  }



  String numberErrorMessage = '';

  bool validateMobileNumber(String value) {
    if (!(value.isNotEmpty)) {
      setState(() {
        numberErrorMessage = "Number can't be empty";
      });
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(25, 30, 25, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.network(
                    'https://i.pinimg.com/236x/43/9c/13/439c13c8107d4958595a2a2ae807475c.jpg',
                  ),
                ),
                SizedBox(height: 20),
                Text('Enter your phone number', style: titleTextStyle),
                SizedBox(height: 20),
                Text('We have send you an sms with code to enter number',
                    style: titleTextStyle),
                SizedBox(height: 30),
                IntlPhoneField(
                  onChanged: (phone) {
                    mobileNumber = '${phone.number}';
                  },
                  onCountryChanged: (phone) {
                    countryCode = '${phone.countryCode}';
                  },
                  iconPosition: IconPosition.trailing,
                  showCountryFlag: false,
                  style: titleTextStyle,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    isDense: true,
                    labelText: 'Mobile Number',
                    errorText: numberErrorMessage,
                    hintText: 'Enter Your Number',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: blackColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                      BorderSide(color: blackColor, width: 1),
                    ),
                  ),
                  initialCountryCode: 'IN',
                ),
                SizedBox(
                  height: 40,
                ),
                greenButton(context, 'Next', true, onSignUp),
                SizedBox(height: 20),
              ],
            ),
          ),
        ));
  }
}
