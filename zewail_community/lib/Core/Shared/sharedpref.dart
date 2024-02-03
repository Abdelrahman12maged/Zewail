import 'package:shared_preferences/shared_preferences.dart';

import '../Function/Api.dart';

class sharedpref {
  static Future saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  }

  static Future saveTokenTeacher(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("tokent", token);
  }
}

class fcmToken {
  final Apiservice Apiser;

  fcmToken(this.Apiser);
}
