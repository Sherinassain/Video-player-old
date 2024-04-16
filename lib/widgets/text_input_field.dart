// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../styles/colors.dart';
import '../styles/textstyles.dart';

  TextField buildTextFormField(StateSetter setState, String _labelText,
      String _hintText, String _errorText, bool _isObscure,TextEditingController _controller){

    String labelText = "";
    return TextField(
      controller: _controller,
      style: titleTextStyle,
      obscureText: _isObscure,
      onChanged: (v) {
        setState(() {
          _labelText = v.isNotEmpty ? labelText : "";
        });
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(0),
        isDense: true,
        errorText: _controller.text == '' ? _errorText : '',
        labelText: _labelText,
        hintText: _hintText,
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
      ),
    );
  }

