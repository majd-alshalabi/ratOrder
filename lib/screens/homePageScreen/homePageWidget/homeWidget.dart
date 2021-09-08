import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rat_order/helper/providerHelper.dart';
import 'package:rat_order/screens/homePageScreen/restaurant.dart';
import '../../../constant.dart';

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: FirstSection()),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: JustClickSearchSection(),
            ),
            SizedBox(
              height: 10,
            ),
            ThirdSection(),
          ],
        ),
      ),
    );
  }
}

class FirstSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: new TextSpan(
        style: new TextStyle(
            fontSize: 40.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: firstFont),
        children: <TextSpan>[
          TextSpan(text: 'اطلب من مطعمك'),
          TextSpan(
              text: ' \nالمفضل \n', style: new TextStyle(color: firstColor)),
          TextSpan(text: ' اينما كنت')
        ],
      ),
    );
  }
}

class ThirdSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 300.0,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
      items:
          context.read<ProviderHelper>().data['restaurant'].asMap().entries.map(
        (idx) {
          return Builder(
            builder: (BuildContext context) {
              return InkWell(
                onTap: () {
                  context.read<ProviderHelper>().selectedRestaurant = idx.key;
                  Navigator.pushNamed(context, Restaurant.id);
                },
                child: SliderWidget(idx.key),
              );
            },
          );
        },
      ).toList(),
    );
  }
}

class SliderWidget extends StatelessWidget {
  SliderWidget(this.idx);

  final idx;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
            image: AssetImage(
                'assets/images/restaurant/${context.read<ProviderHelper>().data["restaurant"][idx]["image"]}'),
            fit: BoxFit.cover),
      ),
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 30, bottom: 30),
                alignment: Alignment.bottomLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ShadowText(
                      '${context.read<ProviderHelper>().data["restaurant"][idx]["name"]}',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: firstFont,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.clock,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ShadowText(
                          '${context.read<ProviderHelper>().data["restaurant"][idx]["open"]} am',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: secondFont,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        ShadowText(
                          ' - ${context.read<ProviderHelper>().data["restaurant"][idx]["close"]} pm',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: secondFont,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
