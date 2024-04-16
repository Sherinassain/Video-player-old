import 'package:flutter/material.dart';
import '../styles/colors.dart';
import '../styles/textstyles.dart';

AppBar defaultAppBar(BuildContext context,Function callbackAction) {
  return AppBar(
    elevation: 2,
    backgroundColor: imageColor,
    titleSpacing: 0,centerTitle: true,
    automaticallyImplyLeading: true,
    title:Center(
      child: Text('Video player',style: titleTextStyle,)
    ),
    actions: [
      InkWell(
        child: Icon(Icons.person,color: whiteColor,size: 25,),onTap: (){
        callbackAction();
      },
      ),
      SizedBox(width: 20,)
    ],
  );
}