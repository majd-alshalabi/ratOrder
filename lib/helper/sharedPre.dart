import 'package:shared_preferences/shared_preferences.dart';

class SharedPre {
  static final String _userId = '_id';

  static Future<void> setUserID(int val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(_userId, val);
  }

  static Future<int> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_userId) ?? -1;
  }
}
