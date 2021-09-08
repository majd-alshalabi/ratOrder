import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'myLocationClass.dart';
import 'cartitem.dart';

class ProviderHelper extends ChangeNotifier {
  var data = {
    'restaurant': [
      {
        'name': 'بروتين بار',
        'connected': true,
        'open': '30 : 8',
        'close': '00 : 10',
        'image': 'firstRestaurant.jpg',
        'idx': 0,
        'lang': 33.52362831566595,
        'lat': 36.31551651260909,
        'food': [
          {
            'name': 'فيتا',
            'image': 'fita.jpg',
            'recipe': ['بندورة كروية', 'صلصة بيستو', 'جبنة فيتا', 'خبز اسمر'],
            'price': 5000,
          },
          {
            'name': 'كلوب',
            'image': 'club.jpg',
            'recipe': [
              'بيض',
              'شرائح حبش',
              'صدر دجاج',
              'توست اسمر',
              'خس',
              'مخلل',
              'خردل'
            ],
            'price': 5500,
          },
          {
            'name': 'كلوب',
            'image': 'club.jpg',
            'recipe': [
              'بيض',
              'شرائح حبش',
              'صدر دجاج',
              'توست اسمر',
              'خس',
              'مخلل',
              'خردل'
            ],
            'price': 5500,
          },
          {
            'name': 'كلوب',
            'image': 'club.jpg',
            'recipe': [
              'بيض',
              'شرائح حبش',
              'صدر دجاج',
              'توست اسمر',
              'خس',
              'مخلل',
              'خردل'
            ],
            'price': 5500,
          }
        ],
      },
      {
        'name': 'ديب ن ديب',
        'image': 'secondRestaurant.png',
        'connected': false,
        'open': '00 : 10',
        'close': '00 : 12',
        'idx': 1,
        'lang': 33.521631023906565,
        'lat': 36.315885128138625,
        'food': [
          {
            'name': 'فيتا',
            'image': 'fita.jpg',
            'recipe': ['بندورة كروية', 'صلصة بيستو', 'جبنة فيتا', 'خبز اسمر'],
            'price': 5000,
          },
        ]
      },
      {
        'name': 'ديب ن ديب',
        'image': 'thirdRestaurant.jpg',
        'connected': false,
        'open': '00 : 10',
        'close': '00 : 12',
        'idx': 2,
        'lang': 33.521631023906565,
        'lat': 36.315885128138625,
        'food': [
          {
            'name': 'فيتا',
            'image': 'fita.jpg',
            'recipe': ['بندورة كروية', 'صلصة بيستو', 'جبنة فيتا', 'خبز اسمر'],
            'price': 5000,
          },
        ]
      },
      {
        'name': 'ديب ن ديب',
        'image': 'fourthRestaurant.jpg',
        'connected': false,
        'open': '00 : 10',
        'close': '00 : 12',
        'idx': 3,
        'lang': 33.521631023906565,
        'lat': 36.315885128138625,
        'food': [
          {
            'name': 'فيتا',
            'image': 'fita.jpg',
            'recipe': ['بندورة كروية', 'صلصة بيستو', 'جبنة فيتا', 'خبز اسمر'],
            'price': 5000,
          },
        ]
      },
      {
        'name': 'ديب ن ديب',
        'image': 'firstRestaurant.jpg',
        'connected': false,
        'open': '00 : 10',
        'close': '00 : 12',
        'idx': 4,
        'lang': 33.521631023906565,
        'lat': 36.315885128138625,
        'food': [
          {
            'name': 'فيتا',
            'image': 'fita.jpg',
            'recipe': ['بندورة كروية', 'صلصة بيستو', 'جبنة فيتا', 'خبز اسمر'],
            'price': 5000,
          },
        ]
      },
      {
        'name': 'ديب ن ديب',
        'image': 'firstRestaurant.jpg',
        'connected': false,
        'open': '00 : 10',
        'close': '00 : 12',
        'idx': 5,
        'lang': 33.521631023906565,
        'lat': 36.315885128138625,
        'food': [
          {
            'name': 'فيتا',
            'image': 'fita.jpg',
            'recipe': ['بندورة كروية', 'صلصة بيستو', 'جبنة فيتا', 'خبز اسمر'],
            'price': 5000,
          },
        ]
      },
    ]
  };

  List<Map> mealList(int idx) {
    return data['restaurant'][idx]['food'];
  }

  String getRestaurantImage(int idx) {
    return data['restaurant'][idx]['image'];
  }

  List<Map> getFoodList(int restaurantIdx) {
    return data['restaurant'][restaurantIdx]['food'];
  }

  List<String> getRecipe(int restaurantIdx, int foodIdx) {
    return getFoodList(restaurantIdx)[foodIdx]['recipe'];
  }

  var selectedMeal;
  var selectedRestaurant;

  void setSelectedMeal(var restaurant, var meal) {
    selectedMeal = meal;
    selectedRestaurant = restaurant;
  }

  int mealNum = 1;

  void setMealnum(int num) {
    mealNum += num;
    notifyListeners();
  }

  List<CartItem> cart = [];

  void addToCart(String note) {
    CartItem cartItem = new CartItem(
        name: selectedMeal['name'],
        note: note,
        price: selectedMeal['price'],
        image: selectedMeal['image'],
        numm: mealNum);

    cart.add(cartItem);
  }

  void setCartItemNum(int idx, int add) {
    if (add == -1 && cart[idx].numm == 1) {
      cart.removeAt(idx);
    } else
      cart[idx].numm += add;
    notifyListeners();
  }

  int getCartTotalPrice() {
    int sum = 0;
    cart.forEach((element) {
      sum += (element.numm * element.price);
    });
    return sum;
  }

  LatLng langAndLat() {
    return LatLng(data['restaurant'][selectedRestaurant]['lang'],
        data['restaurant'][selectedRestaurant]['lat']);
  }

  List<Locations> locationList = [];

  void addToLocationsList(Locations locations) {
    locationList.add(locations);
    notifyListeners();
  }

  void updateLocationsList(Locations locations, int idx) {
    locationList[idx] = locations;
    notifyListeners();
  }

  void delateFromLocationList(int idx) {
    locationList.removeAt(idx);
    notifyListeners();
  }

  int theEditedLocationIdx;

  bool loggedIn = false;
  String name;
  String fav;
  int id;

  void setFavArray(int idx) {
    List<String> li = fav.split("");
    li[idx] = li[idx] == '1' ? '0' : '1';
    fav = li.join();
    print(fav);
    notifyListeners();
  }
}
