import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:rat_order/helper/providerHelper.dart';
import 'package:rat_order/screens/homePageScreen/restaurant.dart';
import '../../../constant.dart';

class RestaurantWidget extends StatefulWidget {
  @override
  _RestaurantWidgetState createState() => _RestaurantWidgetState();
}

class _RestaurantWidgetState extends State<RestaurantWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          JustClickSearchSection(),
          Expanded(
            child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: Container(
                child: ListView.builder(
                    itemCount: context
                        .read<ProviderHelper>()
                        .data['restaurant']
                        .length,
                    itemBuilder: (context, idx) {
                      return RestaurantListItem(
                        idx: idx,
                      );
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RestaurantListItem extends StatefulWidget {
  const RestaurantListItem({@required this.idx});

  @override
  _RestaurantListItemState createState() => _RestaurantListItemState();

  final int idx;
}

class _RestaurantListItemState extends State<RestaurantListItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<ProviderHelper>().selectedRestaurant = widget.idx;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Restaurant()));
      },
      child: Container(
        alignment: Alignment.bottomCenter,
        margin: EdgeInsets.all(10),
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          image: DecorationImage(
            image: AssetImage(
                "assets/images/restaurant/${context.read<ProviderHelper>().data["restaurant"][widget.idx]["image"]}"),
            fit: BoxFit.cover,
          ),
        ),
        child: RestaurantWidgetFooter(
          idx: widget.idx,
        ),
      ),
    );
  }
}
