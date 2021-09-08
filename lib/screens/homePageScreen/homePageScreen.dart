import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';
import 'package:rat_order/constant.dart';
import 'package:rat_order/screens/homePageScreen/homePageWidget/RestaurantWidget.dart';
import 'package:rat_order/screens/homePageScreen/homePageWidget/favWidget.dart';
import 'package:rat_order/screens/homePageScreen/homePageWidget/homeWidget.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'homePageWidget/profileWidget/profileWidget.dart';

class HomePage extends StatefulWidget {
  static final String id = 'homePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  List<Widget> layoutWidget = [
    HomeWidget(),
    RestaurantWidget(),
    FavWidget(),
    ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            systemNavigationBarColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            bottomNavigationBar: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: SalomonBottomBar(
                unselectedItemColor: Colors.grey,
                currentIndex: currentIndex,
                onTap: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                items: <SalomonBottomBarItem>[
                  SalomonBottomBarItem(
                      icon: Icon(Ionicons.bulb_outline),
                      title: Text('الرئيسية'),
                      activeIcon: Icon(Ionicons.bulb),
                      selectedColor: Colors.blue),
                  SalomonBottomBarItem(
                      icon: Icon(Ionicons.restaurant),
                      title: Text('المطاعم'),
                      selectedColor: firstColor),
                  SalomonBottomBarItem(
                      icon: Icon(Ionicons.heart_outline),
                      title: Text('المفضلة'),
                      selectedColor: Colors.pinkAccent),
                  SalomonBottomBarItem(
                      icon: Icon(Icons.person),
                      title: Text('حسابك'),
                      selectedColor: Colors.blueGrey),
                ],
              ),
            ),
            body: layoutWidget[currentIndex],
          ),
        ));
  }
}
