import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rat_order/constant.dart';

class ResturantSigninScreen extends StatelessWidget {
  static final id = 'restutantSigninScreen';
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            systemNavigationBarColor: Colors.grey[100],
            systemNavigationBarIconBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark),
        child: Scaffold(
          body: Stack(
            children: [
              Center(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Hero(
                          child: HeaderIcon(),
                          tag: 'icon',
                        ),
                        Text('Resturant Account'),
                        SizedBox(
                          height: 30,
                        ),
                        InputContainer(
                          keyboardType: TextInputType.emailAddress,
                          placeHolderText: 'username or email',
                          newWidth: 4 * MediaQuery.of(context).size.width / 5,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InputContainer(
                          obscureTextValue: true,
                          placeHolderText: 'password',
                          newWidth: 4 * MediaQuery.of(context).size.width / 5,
                        ),
                        MyButton(
                          buttonColor: firstColor,
                          buttonText: 'Sign in',
                          width: 160,
                          buttonFunction: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.grey.withOpacity(0.7),
                child: Center(
                    child: Text(
                  'Comming Soon',
                  style: TextStyle(fontSize: 40, color: firstColor),
                )),
              )
            ],
          ),
        ));
  }
}
