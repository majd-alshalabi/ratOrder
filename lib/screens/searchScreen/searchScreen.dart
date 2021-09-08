import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rat_order/constant.dart';
import 'package:rat_order/helper/databaseHelper.dart';
import 'package:rat_order/helper/providerHelper.dart';
import 'package:provider/provider.dart';
import 'package:rat_order/screens/homePageScreen/restaurant.dart';

class SearchScreen extends StatefulWidget {
  static final String id = 'searchScreen';

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller = TextEditingController();
  List fillteredList;
  List restaurantList;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    restaurantList = context.read<ProviderHelper>().data['restaurant'];
    fillteredList = restaurantList;
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 70,
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: firstColor,
            title: SearchSection(
              myController: controller,
              onclick: () {
                setState(
                  () {
                    fillteredList = restaurantList
                        .where(
                          (
                            element,
                          ) =>
                              element['name'].contains(
                            controller.text,
                          ),
                        )
                        .toList();
                  },
                );
              },
            ),
          ),
          body: Container(
            child: ListView.builder(
              itemCount: fillteredList != null ? fillteredList.length : 0,
              itemBuilder: (context, idx) => InkWell(
                onTap: () {
                  context.read<ProviderHelper>().selectedRestaurant =
                      fillteredList[idx]['idx'];
                  Navigator.pushNamed(context, Restaurant.id);
                },
                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: AssetImage(
                                  'assets/images/restaurant/${fillteredList[idx]['image']}'),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              fillteredList[idx]['name'],
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            if (context.read<ProviderHelper>().loggedIn) {
                              setState(() {
                                loading = false;
                              });
                              context.read<ProviderHelper>().setFavArray(idx);
                              DatabaseHelper.updateFav(
                                  context.read<ProviderHelper>().id,
                                  context.read<ProviderHelper>().fav);
                              Future.delayed(Duration(milliseconds: 1000), () {
                                setState(() {
                                  loading = true;
                                });
                              });
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("سجل دخولك اولا"),
                              ));
                            }
                          },
                          icon: Icon(
                            context.read<ProviderHelper>().loggedIn
                                ? context.read<ProviderHelper>().fav[idx] == '1'
                                    ? Icons.favorite
                                    : Icons.favorite_border
                                : Icons.favorite_border,
                            color: firstColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
