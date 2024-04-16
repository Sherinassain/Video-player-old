// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new

import 'package:flutter/material.dart';
import 'package:video_player_app/features/auth/login/login_page.dart';
import 'package:video_player_app/styles/colors.dart';
import 'package:video_player_app/styles/textstyles.dart';

import '../../models/profile_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final optionItems = <ProfileModel>[];

  @override
  void initState() {
    super.initState();
    optionItems.add(ProfileModel(Icons.lock, 'Change Password'));
    optionItems.add(ProfileModel(Icons.support_agent, '  Support'));
    optionItems.add(ProfileModel(Icons.power_settings_new, '  Logout'));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar:  AppBar(backgroundColor: imageColor,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text("User Profile",style: titleTextStyle,),
            centerTitle: true,
          ),
      backgroundColor: backGroundColor,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // background image and bottom contents
          Column(
            children: <Widget>[
              Container(
                height: 130.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://i.pinimg.com/736x/a7/63/e0/a763e04eb94cee0bade54b2853d41e2a.jpg"),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(color: imageColor, blurRadius: 8.0)
                    ],
                    color: whiteColor),
              ),
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      'Arya',
                      style: titleTextStyle,
                    ),
                    SizedBox(height: 3),
                    Text(
                      'arya@gmail.com',
                      style: titleTextStyle,
                    ),
                    SizedBox(height: 3),
                    Text(
                      '12-09-2023',
                      style: titleTextStyle,
                    ),
                    SizedBox(height: 30),
                    Padding(padding:  EdgeInsets.only(left: 15, right: 15, bottom: 40),child:Container(
                      decoration: BoxDecoration(
                          color: whiteColor, borderRadius: BorderRadius.circular(12)
                      ),
                      width: double.infinity,
                      height: 178,
                      child:  ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => Divider(
                          color: Colors.black12,
                          height: 4,
                        ),
                        itemCount: optionItems.length,
                        itemBuilder: (context, index) => ListTile(
                          onTap: () {
                            selectedPage(context, index);
                          },
                          leading: Icon(
                            optionItems[index].icon,
                            size: 21,
                            color: imageColor,
                          ),
                          title: Align(
                            child: Text(
                              optionItems[index].text,
                              style: titleTextStyle,
                            ),
                            alignment: Alignment(-1.2, 0),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios_outlined, size: 18),
                        ),
                      ),
                    ) ,)
                  ],
                )
              )
            ],
          ),
          // Profile image
          Positioned(
            top: 100.0, // (background container size) - (circle height / 2)
            child:
            Container(
                      height: 60.0,
                      width: 60.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: new NetworkImage(
                                  "https://i.pinimg.com/564x/77/df/f3/77dff3c64140e5550fdd9a94c449db74.jpg"),
                              fit: BoxFit.cover)),
                    )
          )
        ],
      ),
    ));
  }

  selectedPage(BuildContext context, int index) {
    switch (index) {
      case 0:
        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(
        //     builder: (context) => ChangePassword(),
        //   ),
        // );
        break;
      case 1:
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => SupportPage(),
        //   ),
        // );
        break;
      case 2:
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => LoginPage(),
        //   ),
        // );
        break;
    }
  }
}
