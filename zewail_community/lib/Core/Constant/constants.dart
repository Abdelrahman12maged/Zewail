import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../main.dart';

class MyColors {
  static const Color kPrimaryColor = Colors.blue;
  static const Color kBackgroundColor = Color.fromARGB(255, 229, 229, 229);
  static const Color subTitleTextColor = Color(0xFF9593a8);
}

SystemUiOverlayStyle defaultOverlay = const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark);
var containerRadius = Radius.circular(30.0);

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackbar(
        {required context,
        String? message,
        Color? color = Colors.red,
        Color? colorback = Colors.white}) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        showCloseIcon: true,
        backgroundColor: colorback,
        duration: Duration(seconds: 2),
        content: message != null || message != ""
            ? Text(
                textDirection: TextDirection.rtl,
                "${message}",
                style: TextStyle(color: color, fontSize: 18),
              )
            : Text(
                textDirection: TextDirection.rtl,
                "حدث خطأ",
                style: TextStyle(color: color, fontSize: 18),
              )));
