import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rat_order/constant.dart';
import 'package:rat_order/helper/providerHelper.dart';

class MealWidget extends StatefulWidget {
  static final String id = 'mealWidget';

  @override
  _MealWidgetState createState() => _MealWidgetState();
}

class _MealWidgetState extends State<MealWidget> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: SafeArea(
            child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: ListView(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              context
                                  .read<ProviderHelper>()
                                  .selectedMeal['name'],
                              style: TextStyle(fontSize: 25),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.favorite_border,
                                color: secondColor,
                              ),
                              onPressed: () {},
                            )
                          ],
                        ),
                        getTextWidgets(
                            context
                                .read<ProviderHelper>()
                                .selectedMeal['recipe'],
                            TextStyle(fontSize: 13)),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 15),
                          height: MediaQuery.of(context).size.height / 4,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/food/${context.read<ProviderHelper>().selectedMeal["image"]}'),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Divider(color: Colors.black),
                        SizedBox(
                          height: 10,
                        ),
                        CounterSection(),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(color: Colors.black),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: controller,
                          minLines: 2,
                          maxLines: 5,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: 'ملاحظات اضافية(اختياري)',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                            'سعر الوجبة : ${context.read<ProviderHelper>().selectedMeal["price"]} ل.س'),
                        Text(
                            'السعر الاجمالي : ${context.read<ProviderHelper>().selectedMeal["price"] * context.watch<ProviderHelper>().mealNum} ل.س'),
                      ],
                    )),
                    Container(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          if (context.read<ProviderHelper>().loggedIn) {
                            context.read<ProviderHelper>().addToCart(
                                controller.text == null ? '' : controller.text);

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("تم !!"),
                            ));
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("سجل دخول اولا"),
                            ));
                          }
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'أضف الى السلة',
                              style: TextStyle(color: firstColor, fontSize: 20),
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: firstColor,
                                  borderRadius: BorderRadius.circular(20)),
                              child: FaIcon(
                                FontAwesomeIcons.cartArrowDown,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

class CounterSection extends StatefulWidget {
  @override
  _CounterSectionState createState() => _CounterSectionState();
}

class _CounterSectionState extends State<CounterSection> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
            icon: FaIcon(FontAwesomeIcons.plus),
            onPressed: () {
              setState(() {
                context.read<ProviderHelper>().setMealnum(1);
              });
            }),
        Text(
          context.watch<ProviderHelper>().mealNum.toString(),
          style: TextStyle(fontSize: 20),
        ),
        IconButton(
          icon: FaIcon(FontAwesomeIcons.minus),
          onPressed: () {
            if (context.read<ProviderHelper>().mealNum > 1) {
              setState(() {
                context.read<ProviderHelper>().setMealnum(-1);
              });
            }
          },
        ),
      ],
    );
  }
}
