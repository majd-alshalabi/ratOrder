import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rat_order/helper/providerHelper.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';

class Cart extends StatelessWidget {
  static final String id = 'cart';
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: SafeArea(
            child: Container(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: context.watch<ProviderHelper>().cart.length,
                      itemBuilder: (context, idx) => Container(
                        child: Card(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.width / 4,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          'assets/images/food/${context.read<ProviderHelper>().cart[idx].image}',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    context
                                        .read<ProviderHelper>()
                                        .cart[idx]
                                        .name,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              context
                                                  .read<ProviderHelper>()
                                                  .setCartItemNum(idx, 1);
                                            },
                                            icon: FaIcon(
                                              FontAwesomeIcons.plus,
                                              size: 15,
                                            ),
                                          ),
                                          Text(context
                                              .watch<ProviderHelper>()
                                              .cart[idx]
                                              .numm
                                              .toString()),
                                          IconButton(
                                            onPressed: () {
                                              context
                                                  .read<ProviderHelper>()
                                                  .setCartItemNum(idx, -1);
                                              if (context
                                                      .read<ProviderHelper>()
                                                      .cart
                                                      .length ==
                                                  0) {
                                                Navigator.pop(context);
                                              }
                                            },
                                            icon: FaIcon(
                                              context
                                                          .watch<
                                                              ProviderHelper>()
                                                          .cart[idx]
                                                          .numm !=
                                                      1
                                                  ? FontAwesomeIcons.minus
                                                  : FontAwesomeIcons.trash,
                                              size: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      '${(context.read<ProviderHelper>().cart[idx].price * context.watch<ProviderHelper>().cart[idx].numm).toString()} ل.س',
                                      style: TextStyle(fontSize: 11),
                                    ),
                                  )
                                ],
                              ),
                              context.read<ProviderHelper>().cart[idx].note !=
                                      ''
                                  ? Column(
                                      children: [
                                        Divider(
                                          color: Colors.black,
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          padding: EdgeInsets.all(10),
                                          child: Text(context
                                              .read<ProviderHelper>()
                                              .cart[idx]
                                              .note),
                                        )
                                      ],
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                    endIndent: MediaQuery.of(context).size.width / 5,
                    indent: MediaQuery.of(context).size.width / 5,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('المجموع : '),
                        Text(
                            '${context.read<ProviderHelper>().getCartTotalPrice().toString()} ل.س')
                      ],
                    ),
                  ),
                  Container(
                    child: CartFooter(
                      onclick: () {},
                      text: 'تابع',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
