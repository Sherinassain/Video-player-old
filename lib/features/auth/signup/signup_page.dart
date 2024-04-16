// ignore_for_file: must_be_immutable

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../styles/colors.dart';
import '../../../styles/textstyles.dart';
import '../../../widgets/green_button.dart';
import '../../../widgets/text_input_field.dart';
import '../login/login_page.dart';
import 'number_verification.dart';

class SignUpPage extends StatefulWidget {
   SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  bool _isHidden = true;

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void onCancelPressed() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
  }

  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  void onSignUp() async {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => NumberVerificationPage()));
  }

  String passErrorMessage = "";
  bool validatePassword(String value) {
    if (!(value.isNotEmpty)) {
      setState(() {
        passErrorMessage = "Password can't be empty";
      });
      return false;
    } else {
      setState(() {
        passErrorMessage = "";
      });
      return true;
    }
  }

  String emailErrorMessage = "";

  bool validateEmail(String value) {
    if (!(value.isNotEmpty)) {
      setState(() {
        emailErrorMessage = "Email can't be empty";
      });
      return false;
    } else {
      setState(() {
        emailErrorMessage = "";
      });
      return true;
    }
  }

  String nameErrorMessage = "";
  bool validateUserName(String value) {
    if (!(value.isNotEmpty)) {
      setState(() {
        nameErrorMessage = "UserName can't be empty";
      });
      return false;
    } else {
      setState(() {
        nameErrorMessage = "";
      });
      return true;
    }
  }




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 40),
          child: Form(
            key: _formKey,
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Center(
                  child: Image.network('https://i.pinimg.com/236x/43/9c/13/439c13c8107d4958595a2a2ae807475c.jpg')),
              SizedBox(height: 30),
              Text("Register Account", style: titleTextStyle),
              SizedBox(height: 30),
              buildTextFormField(setState, 'Username', 'Enter username',
                  nameErrorMessage, false, userNameController),
              SizedBox(height: 12),
              buildTextFormField(setState, 'Email', 'Enter Email',
                  emailErrorMessage, false, emailController),
              SizedBox(height: 12),
              buildTextField("Password"),
              SizedBox(height: 10),
              SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text: 'By continuing you agree to our ',
                  style: titleTextStyle,
                  children: [
                    TextSpan(text: 'Terms of Service ', style: titleTextStyle),
                    TextSpan(text: 'and ', style: titleTextStyle),
                    TextSpan(text: 'Privacy Policy', style: titleTextStyle),
                  ],
                ),
              ),
              SizedBox(height: 35),
              greenButton(context, 'Sign Up', false, onSignUp),
              SizedBox(height: 20),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Already have an account? ',
                    style: titleTextStyle,
                    children: [
                      TextSpan(
                          text: 'Log In',
                          style: titleTextStyle,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()))
                            }),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }


  Widget buildTextField(String hintText) {
    return TextField(
      controller: passwordController,
      style: titleTextStyle,
      onChanged: (_) => setState(() {}),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(0),
        isDense: true,
        hintText: hintText,
        errorText: passwordController.text == '' ? passErrorMessage : '',
        labelText: 'Password',
        fillColor: blackColor,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: blackColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: blackColor, width: 1),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: blackColor, width: 1),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: blackColor, width: 1),
        ),
        suffixIcon: hintText == "Password" ? IconButton(
          onPressed: _toggleVisibility,
          icon: _isHidden ? Icon(Icons.visibility_off,color: blackColor,) : Icon(Icons.visibility,color: blackColor,),
        ) : null,
      ),
      obscureText: hintText == "Password" ? _isHidden : false,
    );
  }
}
