import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:video_player_app/features/auth/signup/signup_success_page.dart';
import 'package:video_player_app/styles/textstyles.dart';

import '../../../styles/colors.dart';
import '../../../widgets/green_button.dart';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({Key? key}) : super(key: key);

  @override
  _OtpVerificationPageState createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final _formKey = GlobalKey<FormState>();

  String otp = '';
  String mobileNumber = '';
  String countryCode = '';

  void onOtp() async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => SignUpSuccessPage()));
  }

  void onResendOtp() async {}

  void onOkPressed() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => OtpVerificationPage()));
  }

  void onCancelPressed() {
    Navigator.of(context).pop();
  }



  String otpErrorMessage = '';

  bool validateOtp(String value) {
    if (!(value.isNotEmpty)) {
      setState(() {
        otpErrorMessage = "Otp can't be empty";
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
          padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Image.network(
                    'https://i.pinimg.com/236x/43/9c/13/439c13c8107d4958595a2a2ae807475c.jpg',
                  ),
                ),
                SizedBox(height: 50),
                Text('Phone Verification', style: titleTextStyle),
                SizedBox(height: 30),
                Text('Enter Your OTP', style: titleTextStyle),
                SizedBox(height: 38),
                Center(
                  child: OTPTextField(
                    margin: EdgeInsets.all(5),
                    keyboardType: TextInputType.number,
                    style: titleTextStyle,
                    length: 6,
                    width: MediaQuery.of(context).size.longestSide,
                    textFieldAlignment: MainAxisAlignment.center,
                    fieldWidth: 34,
                    outlineBorderRadius: 19,
                    onChanged: (otp) {},
                    onCompleted: (newOtp) {
                      otp = newOtp;
                    },
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                        text: TextSpan(
                            text: 'Didn' 't receive OTP? ',
                            style: titleTextStyle,
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Resend new OTP',
                                  style: titleTextStyle,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => {onResendOtp()})
                            ])),
                  ],
                ),
                SizedBox(height: 80),
                greenButton(context, 'Verify', false, onOtp),
                SizedBox(height: 20),
              ],
            ),
          ),
        ));
  }
}
