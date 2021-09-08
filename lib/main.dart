import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rat_order/constant.dart';
import 'package:rat_order/helper/databaseHelper.dart';
import 'package:rat_order/helper/providerHelper.dart';
import 'package:rat_order/screens/accountScreens/consumer/consumerRegisterScreen.dart';
import 'package:rat_order/screens/accountScreens/consumer/consumerSigninScreen.dart';
import 'package:rat_order/screens/accountScreens/resturant/resturantLoginScreen.dart';
import 'package:rat_order/screens/accountScreens/welecomScreen.dart';
import 'package:rat_order/screens/homePageScreen/cart.dart';
import 'package:rat_order/screens/homePageScreen/homePageScreen.dart';
import 'package:rat_order/screens/homePageScreen/homePageWidget/profileWidget/addNewLocationMap.dart';
import 'package:rat_order/screens/homePageScreen/homePageWidget/profileWidget/myLocationScreen.dart';
import 'package:rat_order/screens/homePageScreen/meal.dart';
import 'package:rat_order/screens/homePageScreen/restaurant.dart';
import 'package:rat_order/screens/loadingScreen.dart';
import 'package:rat_order/screens/mapScreen/mapScreen.dart';
import 'package:rat_order/screens/searchScreen/searchScreen.dart';

import 'helper/sharedPre.dart';

void main() {
  runApp(
    ChangeNotifierProvider<ProviderHelper>(
      create: (context) => ProviderHelper(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool checkScreenTest = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    checkScreen();
  }

  Future<void> checkScreen() async {
    setState(() {
      isLoading = true;
    });
    int id = await SharedPre.getUserId();
    if (id == -1) {
      checkScreenTest = true;
    } else {
      checkScreenTest = false;
      context.read<ProviderHelper>().loggedIn = true;
      await DatabaseHelper.getDataBaseInfo().then((databaseList) {
        context.read<ProviderHelper>().name = databaseList[id]['_email'];
        context.read<ProviderHelper>().fav = databaseList[id]['_fav'];
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.amber,
        scaffoldBackgroundColor: Colors.grey[100],
        primaryTextTheme: TextTheme(
          headline6: TextStyle(color: firstColor),
        ),
      ),
      routes: {
        ConsumerSigninScreen.id: (BuildContext context) =>
            ConsumerSigninScreen(),
        ConsumerRegisterScreen.id: (BuildContext context) =>
            ConsumerRegisterScreen(),
        ResturantSigninScreen.id: (BuildContext context) =>
            ResturantSigninScreen(),
        HomePage.id: (BuildContext context) => HomePage(),
        WelecomeScreen.id: (BuildContext context) => WelecomeScreen(),
        Restaurant.id: (BuildContext context) => Restaurant(),
        SearchScreen.id: (BuildContext context) => SearchScreen(),
        MealWidget.id: (BuildContext context) => MealWidget(),
        Cart.id: (BuildContext context) => Cart(),
        MapScreen.id: (BuildContext context) => MapScreen(),
        MyLocation.id: (BuildContext context) => MyLocation(),
        AddLocationMap.id: (BuildContext context) => AddLocationMap(),
      },
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: isLoading
            ? LoadingScreen()
            : checkScreenTest
                ? WelecomeScreen()
                : HomePage(),
      ),
    );
  }
}
