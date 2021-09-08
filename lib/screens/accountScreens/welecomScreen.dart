import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rat_order/helper/providerHelper.dart';
import 'package:rat_order/screens/accountScreens/consumer/consumerSigninScreen.dart';
import 'package:rat_order/screens/accountScreens/resturant/resturantLoginScreen.dart';
import 'package:rat_order/screens/homePageScreen/homePageScreen.dart';

import '../../constant.dart';

class WelecomeScreen extends StatelessWidget {
  static final id = 'welecomScreen';
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.grey[100],
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                Center(
                  child: Column(
                    children: [
                      Hero(
                        child: HeaderIcon(),
                        tag: 'icon',
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? 100
                            : 0,
                      ),
                      Container(
                        child: Column(
                          children: [
                            MyButton(
                              buttonText: 'التسجيل كمطعم',
                              buttonColor: firstColor,
                              width: 200,
                              buttonFunction: () {
                                Navigator.pushNamed(
                                    context, ResturantSigninScreen.id);
                              },
                            ),
                            MyButton(
                              buttonText: 'التسجيل كمستهلك',
                              buttonColor: thirdColor,
                              width: 100,
                              buttonFunction: () {
                                Navigator.pushNamed(
                                    context, ConsumerSigninScreen.id);
                              },
                            ),
                            InkWell(
                              onTap: () {
                                context.read<ProviderHelper>().loggedIn = false;
                                Navigator.pushReplacementNamed(
                                    context, HomePage.id);
                              },
                              child: Text(
                                'تخطي',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.lightBlue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
