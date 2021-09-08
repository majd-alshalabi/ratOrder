import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:rat_order/helper/databaseHelper.dart';
import 'package:rat_order/helper/providerHelper.dart';
import 'package:provider/provider.dart';
import 'package:rat_order/screens/homePageScreen/cart.dart';
import 'package:rat_order/screens/homePageScreen/meal.dart';
import 'package:rat_order/screens/mapScreen/mapScreen.dart';
import '../../constant.dart';

class Restaurant extends StatefulWidget {
  static final String id = 'restaurant';

  @override
  _RestaurantState createState() => _RestaurantState();
}

class _RestaurantState extends State<Restaurant> with TickerProviderStateMixin {
  int idx;
  String z;
  Image image1;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    idx = context.read<ProviderHelper>().selectedRestaurant;
    z = context.read<ProviderHelper>().getRestaurantImage(idx);
    image1 = Image.asset(
        'assets/images/restaurant/${context.read<ProviderHelper>().getRestaurantImage(idx)}',
        fit: BoxFit.cover);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    precacheImage(image1.image, context);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: WillPopScope(
        onWillPop: context.read<ProviderHelper>().cart.length != 0
            ? () async => buildShowDialog(context)
            : null,
        child: Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: context.read<ProviderHelper>().cart.length > 0
              ? CartFooter(
                  onclick: () => Navigator.pushNamed(context, Cart.id),
                  text: 'عرض السلة',
                )
              : null,
          body: DefaultTabController(
            length: 5,
            child: NestedScrollView(
              body: TabBarView(
                children: [
                  MainFoodList(),
                  Center(child: Text("Page 2")),
                  Center(child: Text("Page 3")),
                  Center(child: Text('Page 4')),
                  Center(child: Text('Page 5'))
                ],
              ),
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) => [
                Container(
                  child: SliverAppBar(
                    actions: [
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, MapScreen.id);
                        },
                        icon: Icon(
                          Ionicons.location_outline,
                          color: Colors.white,
                        ),
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
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("سجل دخولك اولا"),
                            ));
                          }
                        },
                        icon: loading == false
                            ? Container(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 0.9,
                                ),
                              )
                            : Icon(
                                context.read<ProviderHelper>().loggedIn
                                    ? loading
                                        ? context
                                                    .watch<ProviderHelper>()
                                                    .fav[idx] ==
                                                '0'
                                            ? Icons.favorite_border
                                            : Icons.favorite
                                        : Icons.airplane_ticket
                                    : Icons.favorite_border,
                                color: Colors.white,
                              ),
                      ),
                    ],
                    iconTheme: IconThemeData(color: Colors.white),
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    pinned: true,
                    expandedHeight: 300.0,
                    flexibleSpace: FlexibleSpaceBar(
                      background: image1,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: RestaurantWidgetFooter(
                    idx: idx,
                  ),
                ),
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.grey[400],
                  pinned: true,
                  toolbarHeight: 25,
                  flexibleSpace: myTabBar(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> buildShowDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'تنبيه',
                  style: TextStyle(fontSize: 15, color: firstColor),
                  textAlign: TextAlign.right,
                ),
                SizedBox(
                  width: 10,
                ),
                FaIcon(
                  FontAwesomeIcons.exclamationTriangle,
                  color: thirdColor,
                  size: 18,
                ),
              ],
            ),
            Text(
              'لديك اطباق في سلتك ستحذف في حال الاغلاق',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.right,
            ),
          ],
        ),
        actions: <Widget>[
          InkWell(
            onTap: () => Navigator.pop(context, false),
            child: Container(
              height: 40,
              alignment: Alignment.center,
              color: firstColor,
              width: 70,
              child: Text(
                'الغاء',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              context.read<ProviderHelper>().cart.clear();

              Navigator.pop(context, true);
            },
            child: Container(
              height: 40,
              color: firstColor,
              alignment: Alignment.center,
              width: 70,
              child: Text(
                'حذف',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
//

class ImageHeaderWidget extends StatefulWidget {
  const ImageHeaderWidget({
    @required this.x,
    @required bool visible,
  }) : _visible = visible;

  final double x;
  final bool _visible;

  @override
  _ImageHeaderWidgetState createState() => _ImageHeaderWidgetState();
}

class _ImageHeaderWidgetState extends State<ImageHeaderWidget> {
  int idx;

  @override
  void initState() {
    super.initState();
    idx = context.read<ProviderHelper>().selectedRestaurant;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3 - widget.x,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          'assets/images/restaurant/${context.read<ProviderHelper>().data["restaurant"][idx]["image"]}'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              child: AnimatedOpacity(
                  opacity: widget._visible ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 500),
                  child: Container(
                    decoration: BoxDecoration(
                        color: firstColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30))),
                  )),
            ),
            AppBar(
              iconTheme: IconThemeData(
                color: Colors.white, //change your color here
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, MapScreen.id);
                  },
                  icon: Icon(
                    Icons.location_on_outlined,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite_border,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10,
                )
              ],
            ),
          ],
        ),
        AppBar(
          toolbarHeight: 7,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(100),
            ),
          ),
          brightness: Brightness.light,
          backgroundColor: Colors.white.withOpacity(0.3),
          elevation: 0,
        ),
      ],
    );
  }
}

TabBar myTabBar() => TabBar(
      indicatorColor: firstColor,
      labelColor: firstColor,
      unselectedLabelColor: Colors.white,
      isScrollable: true,
      tabs: <Tab>[
        Tab(
          child: Text('الاطباق الرئيسية'),
        ),
        Tab(
          child: Text('سلطات'),
        ),
        Tab(
          child: Text('وجبات خفيفة'),
        ),
        Tab(
          child: Text('مشروبات ساخنة'),
        ),
        Tab(
          child: Text('مشروبات باردة'),
        ),
      ],
    );

class MainFoodList extends StatefulWidget {
  @override
  _MainFoodListState createState() => _MainFoodListState();
}

class _MainFoodListState extends State<MainFoodList> {
  int idx;

  @override
  void initState() {
    super.initState();
    idx = context.read<ProviderHelper>().selectedRestaurant;
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: ListView.builder(
        itemCount: context.read<ProviderHelper>().getFoodList(idx).length,
        itemBuilder: (context, int index) => ListItem(
          restaurantIdx: idx,
          foodIdx: index,
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final int restaurantIdx;
  final int foodIdx;

  const ListItem({this.restaurantIdx, this.foodIdx});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: InkWell(
        onTap: () {
          context.read<ProviderHelper>().setSelectedMeal(
              context.read<ProviderHelper>().data['restaurant'][restaurantIdx],
              context
                  .read<ProviderHelper>()
                  .getFoodList(restaurantIdx)[foodIdx]);
          context.read<ProviderHelper>().mealNum = 1;
          Navigator.pushNamed(context, MealWidget.id);
        },
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/images/food/${context.read<ProviderHelper>().mealList(restaurantIdx)[foodIdx]["image"]}',
                      ),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.all(Radius.circular(30))),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(context
                        .read<ProviderHelper>()
                        .mealList(restaurantIdx)[foodIdx]["name"]),
                    getTextWidgets(
                        context
                            .read<ProviderHelper>()
                            .getRecipe(restaurantIdx, foodIdx),
                        TextStyle(fontSize: 10))
                  ],
                ),
                Text(
                  '${context.read<ProviderHelper>().mealList(restaurantIdx)[foodIdx]["price"].toString()} ل.س',
                  style: TextStyle(color: firstColor),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
