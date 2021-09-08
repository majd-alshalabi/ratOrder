import 'package:flutter/material.dart';
import 'package:rat_order/constant.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              HeaderIcon(),
              Column(
                children: [
                  Text(
                    'التحميل...',
                    style: TextStyle(fontSize: 25),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CircularProgressIndicator()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
