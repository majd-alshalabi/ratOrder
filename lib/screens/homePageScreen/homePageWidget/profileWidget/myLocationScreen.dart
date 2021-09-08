import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:rat_order/constant.dart';
import 'package:rat_order/helper/providerHelper.dart';
import 'package:provider/provider.dart';
import 'package:rat_order/screens/homePageScreen/homePageWidget/profileWidget/addNewLocationMap.dart';

class MyLocation extends StatelessWidget {
  static final String id = 'MyLocation';
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            titleTextStyle: TextStyle(color: firstColor),
            backgroundColor: Colors.white,
            title: Text('عناويني'),
          ),
          body: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    context.read<ProviderHelper>().theEditedLocationIdx = -1;
                    Navigator.pushNamed(context, AddLocationMap.id);
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Icon(
                          Ionicons.add,
                          color: firstColor,
                        ),
                        SizedBox(width: 10),
                        Text('اضف عنوان جديد ',
                            style: TextStyle(color: firstColor)),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount:
                        context.watch<ProviderHelper>().locationList.length,
                    itemBuilder: (context, idx) => InkWell(
                      onTap: () {
                        context.read<ProviderHelper>().theEditedLocationIdx =
                            idx;
                        Navigator.pushNamed(context, AddLocationMap.id);
                      },
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  FaIcon(FontAwesomeIcons.mapMarkerAlt,
                                      color: thirdColor),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    context
                                        .read<ProviderHelper>()
                                        .locationList[idx]
                                        .placeName,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: Icon(Ionicons.trash, color: firstColor),
                                onPressed: () {
                                  context
                                      .read<ProviderHelper>()
                                      .delateFromLocationList(idx);
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
