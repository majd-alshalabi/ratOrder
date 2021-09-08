import 'package:flutter/cupertino.dart';

class CartItem {
  CartItem({this.name, this.note, this.numm, this.price, @required this.image});

  int numm;
  String name;
  int price;
  String note;
  String image;
}
