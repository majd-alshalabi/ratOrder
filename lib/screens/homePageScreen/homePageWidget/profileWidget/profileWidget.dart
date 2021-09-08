import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ionicons/ionicons.dart';
import 'package:rat_order/constant.dart';
import 'package:rat_order/helper/providerHelper.dart';
import 'package:rat_order/helper/sharedPre.dart';
import 'package:rat_order/screens/accountScreens/welecomScreen.dart';

import 'myLocationScreen.dart';

class ProfileScreen extends StatefulWidget {
  static String id = 'profileScreen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        child: context.read<ProviderHelper>().loggedIn
            ? SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 3,
                          height: MediaQuery.of(context).size.width / 3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                100,
                              ),
                            ),
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/restaurant/firstRestaurant.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              height: 70,
                              width: 1,
                              color: Colors.grey,
                              margin: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'الانضمام',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Row(
                                  children: [
                                    Text(' mon ago'),
                                    Text(
                                      ' 6',
                                      style: TextStyle(fontSize: 20),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  '${getUserName(context.read<ProviderHelper>().name)} \n',
                              style: TextStyle(
                                fontSize: 50,
                                fontFamily: firstFont,
                              ),
                            ),
                            TextSpan(
                                text: 'مستهلك',
                                style: TextStyle(
                                    fontSize: 30, color: Colors.grey)),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconItem(
                            text: 'طلباتي',
                            fontAwesomeIcons: Icon(
                              Ionicons.cart_outline,
                              size: 30,
                              color: firstColor,
                            ),
                            widgetColor: firstColor,
                          ),
                          IconItem(
                            onclick: () {
                              Navigator.pushNamed(context, MyLocation.id);
                            },
                            text: 'عناويني',
                            fontAwesomeIcons: Icon(
                              Ionicons.map_outline,
                              size: 30,
                              color: Colors.blue,
                            ),
                            widgetColor: Colors.blue,
                          ),
                          IconItem(
                            text: 'الاعدادات',
                            fontAwesomeIcons: Icon(
                              Ionicons.cog,
                              size: 30,
                              color: Colors.blueGrey,
                            ),
                            widgetColor: Colors.blueGrey,
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(100)),
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: InkWell(
                        onTap: () async {
                          await SharedPre.setUserID(-1);
                          Navigator.pushNamedAndRemoveUntil(
                              context, WelecomeScreen.id, (route) => false);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.logout,
                              color: Colors.pinkAccent,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('تسجيل الخروج')
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'سجل دخولك اولا',
                      style: TextStyle(fontSize: 30),
                    ),
                    MyButton(
                      buttonText: 'تسجيل الدخول',
                      buttonColor: Colors.blueGrey,
                      buttonFunction: () {
                        Navigator.pushNamed(context, WelecomeScreen.id);
                      },
                    )
                  ],
                ),
              ),
      ),
    );
  }
}

String getUserName(String name) {
  return name.indexOf('@') != -1 ? name.substring(0, name.indexOf('@')) : name;
}

class IconItem extends StatelessWidget {
  final String text;
  final Widget fontAwesomeIcons;
  final Function onclick;
  final Color widgetColor;

  IconItem(
      {@required this.text,
      @required this.fontAwesomeIcons,
      this.onclick,
      @required this.widgetColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onclick,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            alignment: Alignment.center,
            width: 50,
            height: 50,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: widgetColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(100),
            ),
            child: fontAwesomeIcons,
          ),
          Text(text),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Icon(Icons.navigate_next),
          )
        ],
      ),
    );
  }
}
