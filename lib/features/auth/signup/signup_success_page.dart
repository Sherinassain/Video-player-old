import 'package:flutter/material.dart';
import 'package:video_player_app/styles/textstyles.dart';

import '../../../styles/colors.dart';
import '../../../widgets/green_button.dart';
import '../../home/video_player.dart';


class SignUpSuccessPage extends StatefulWidget {
  const SignUpSuccessPage({Key? key}) : super(key: key);

  @override
  _SignUpSuccessPage createState() => _SignUpSuccessPage();
}


class _SignUpSuccessPage extends State<SignUpSuccessPage> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: whiteColor,
            body: SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(20, 100, 20, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Image.network('https://cdn.pixabay.com/photo/2013/07/12/18/22/check-153363_640.png',height: 100,)),
          SizedBox(height: 40),
          Text(
            'Sign up Success',
            style: titleTextStyle,
          ),
          SizedBox(height: 59),
          greenButton(context, 'Home', false, onButtonClick),
        ],
      ),
    )));
  }

  onButtonClick() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => VideoPlayers(),
      ),
    );
  }
}
