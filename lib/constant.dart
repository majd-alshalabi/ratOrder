import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rat_order/screens/searchScreen/searchScreen.dart';
import 'helper/providerHelper.dart';

final Color firstColor = Color(0XFFffbf59);
final Color secondColor = Color(0XFFffb8d3);
final Color thirdColor = Color(0XFF587067);

final firstFont = 'Quicksand-VariableFont_wght';
final secondFont = 'OpenSansCondensed-Light';
final thirdFont = 'Lateef-Regular';

Widget getTextWidgets(List<String> strings, TextStyle textStyle) {
  List<Widget> list = [];
  for (var i = 0; i < strings.length; i++) {
    list.add(Text(
      i != strings.length - 1 ? '${strings[i]} , ' : strings[i],
      style: textStyle,
    ));
  }
  return Row(children: list);
}

class MyButton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Function buttonFunction;
  final double width;

  MyButton(
      {this.buttonText, this.buttonColor, this.buttonFunction, this.width});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: buttonColor,
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: () {
            buttonFunction();
          },
          height: 42.0,
          minWidth: width,
          child: Text(
            buttonText,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class ShadowText extends StatelessWidget {
  ShadowText(this.data, {this.style}) : assert(data != null);

  final String data;
  final TextStyle style;

  Widget build(BuildContext context) {
    return new ClipRect(
      child: new Stack(
        children: [
          new Positioned(
            top: 2.0,
            left: 2.0,
            child: new Text(
              data,
              style: style != null
                  ? style.copyWith(color: Colors.black.withOpacity(0.5))
                  : TextStyle(color: Colors.black),
            ),
          ),
          new BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: new Text(data, style: style),
          ),
        ],
      ),
    );
  }
}

class SearchSection extends StatefulWidget {
  final Function onclick;
  final TextEditingController myController;

  SearchSection({this.onclick, this.myController});

  @override
  _SearchSectionState createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.searchengin,
              color: firstColor,
            ),
            onPressed: widget.onclick,
          ),
          Expanded(
            child: TextField(
              textAlign: TextAlign.right,
              onSubmitted: (value) {
                widget.onclick();
              },
              controller: widget.myController,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: "البحث عن مطعم",
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image(
            width: MediaQuery.of(context).orientation == Orientation.portrait
                ? MediaQuery.of(context).size.width / 3
                : MediaQuery.of(context).size.width / 5,
            image: AssetImage('assets/images/rat.png'),
          ),
          RichText(
            textAlign: TextAlign.center,
            text: new TextSpan(
              style: new TextStyle(
                fontSize: 40.0,
                color: thirdColor,
              ),
              children: <TextSpan>[
                TextSpan(
                    text: 'Rat', style: TextStyle(fontWeight: FontWeight.w600)),
                TextSpan(
                    text: 'order',
                    style: TextStyle(
                        color: firstColor,
                        fontWeight: FontWeight.w600,
                        fontFamily: firstFont)),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class InputContainer extends StatefulWidget {
  final String placeHolderText;
  final double newWidth;
  final TextEditingController controller;
  final bool obscureTextValue;
  final keyboardType;
  final Function valid;
  final Function onchange;

  InputContainer(
      {this.placeHolderText,
      this.newWidth,
      this.controller,
      this.obscureTextValue,
      this.keyboardType,
      this.valid,
      this.onchange});
  @override
  _InputContainerState createState() => _InputContainerState();
}

class _InputContainerState extends State<InputContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.newWidth,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(6),
      child: TextFormField(
        onChanged: widget.onchange == null ? (value) {} : widget.onchange,
        textInputAction: TextInputAction.next,
        validator: widget.valid,
        obscureText:
            widget.obscureTextValue == null ? false : widget.obscureTextValue,
        keyboardType: widget.keyboardType == null
            ? TextInputType.text
            : widget.keyboardType,
        controller: widget.controller,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding:
              EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
          hintText: widget.placeHolderText,
        ),
      ),
    );
  }
}

class RestaurantWidgetFooter extends StatefulWidget {
  final int idx;

  const RestaurantWidgetFooter({@required this.idx});

  @override
  _RestaurantWidgetFooterState createState() => _RestaurantWidgetFooterState();
}

class _RestaurantWidgetFooterState extends State<RestaurantWidgetFooter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.6)),
      child: Row(
        children: [
          Row(
            children: [
              Container(
                width: 50,
                child: Image(
                  image: AssetImage('assets/images/rat.png'),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ShadowText(
                    context.read<ProviderHelper>().data['restaurant']
                        [widget.idx]['name'],
                    style: TextStyle(color: firstColor, fontSize: 20),
                  ),
                  ShadowText(
                    'قيمة التوصيل : 5000 ل.س',
                    style: TextStyle(fontSize: 12),
                  )
                ],
              )
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    context.read<ProviderHelper>().data['restaurant']
                            [widget.idx]['connected']
                        ? Row(
                            children: [
                              ShadowText(
                                'متصل',
                                style: TextStyle(color: Colors.lightGreen),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              FaIcon(
                                FontAwesomeIcons.solidCircle,
                                size: 10,
                                color: Colors.lightGreen,
                              )
                            ],
                          )
                        : Row(
                            children: [
                              ShadowText(
                                'غير متصل',
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              FaIcon(
                                FontAwesomeIcons.circle,
                                size: 10,
                                color: Colors.red[300],
                              ),
                            ],
                          ),
                    Row(
                      children: [
                        ShadowText(
                          'مساء ',
                          style: TextStyle(fontSize: 10),
                        ),
                        ShadowText(
                          '${context.read<ProviderHelper>().data['restaurant'][widget.idx]['close']} صباحا ',
                          style: TextStyle(fontSize: 10),
                        ),
                        ShadowText(
                          '${context.read<ProviderHelper>().data['restaurant'][widget.idx]['open']}',
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}

class CartFooter extends StatelessWidget {
  final Function onclick;
  final String text;

  const CartFooter({@required this.onclick, @required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onclick,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.all(5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: firstColor, borderRadius: BorderRadius.circular(30)),
            width: 40,
            height: 40,
            child: FaIcon(
              FontAwesomeIcons.cartArrowDown,
              color: Colors.white,
            ),
          ),
          Text(
            text,
            style: TextStyle(color: firstColor, fontSize: 18),
          ),
          Container(
            margin: EdgeInsets.all(5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: firstColor, borderRadius: BorderRadius.circular(30)),
            width: 40,
            height: 40,
            child: Text(
              context.read<ProviderHelper>().cart.length.toString(),
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}

class JustClickSearchSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, SearchScreen.id),
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'البحث عن مطعم ...',
              style: TextStyle(color: Colors.grey),
            ),
            FaIcon(
              FontAwesomeIcons.searchengin,
              color: firstColor,
            )
          ],
        ),
      ),
    );
  }
}
