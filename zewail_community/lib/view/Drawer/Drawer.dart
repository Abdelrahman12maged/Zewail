// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zewail_community/Controller/profile/cubit.dart';
import 'package:zewail_community/Controller/profile/states.dart';
import 'package:zewail_community/Core/Constant/LoadingIndic.dart';
import 'package:zewail_community/Core/Constant/constants.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:zewail_community/Core/errors/Customerrowidget.dart';
import 'package:zewail_community/main.dart';
import 'package:zewail_community/view/Drawer/privacypage.dart';
import 'package:zewail_community/view/auth/Register.dart';
import 'package:zewail_community/view/auth/homelogine.dart';
import '../../Core/Function/ScanCode.dart';
import 'AboutUs.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);

  bool isDisposed = false;
  bool? isteacher = prefs!.getBool('ist');

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15)),
        //  color: Color.fromARGB(255, 63, 159, 237),
        color: Color.fromARGB(255, 34, 110, 172),
        child: ListView(
          children: <Widget>[
            Container(
              padding: padding,
              child: Column(
                children: [
                  isteacher == true ? buildteacher() : blocbuild(context),
                  SizedBox(height: 5),
                  isteacher == false
                      ? buildMenuItem(
                          text: 'الملف الشخصي',
                          icon: FontAwesomeIcons.personCircleCheck,
                          onClicked: () async {
                            await Navigator.pushNamed(context, "profile");
                          },
                        )
                      : Text(""),
                  const SizedBox(height: 5),
                  buildMenuItem(
                    text: 'من نحن',
                    icon: Icons.people,
                    onClicked: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AboutUsPage()));
                    },
                  ),
                  const SizedBox(height: 5),
                  buildMenuItem(
                    text: 'الشروط والأحكام',
                    icon: Icons.rule,
                    onClicked: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PrivacyPolicyPage()));
                    },
                  ),
                  const SizedBox(height: 5),

                  //   buildMenuItem(
                  //    text: 'زيارة موقعنا روزويل',
                  //    icon: FontAwesomeIcons.earthAfrica,
                  //    onClicked: () {
                  //      Navigator.pushNamed(context, "web");
                  //     },
                  //    ),
                  const SizedBox(height: 5),
                  buildMenuItem(
                      text: 'تسجيل الخروج',
                      icon: Icons.logout,
                      onClicked: () async {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.warning,
                          animType: AnimType.rightSlide,
                          title: 'تسجيل الخروج',
                          desc: 'متأكد انك تريد الخروج',
                          btnCancelText: "لا",
                          btnOkText: "نعم",
                          btnCancelOnPress: () {},
                          btnOkOnPress: () async {
                            await logout();

                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => loginhome()),
                              (route) =>
                                  false, // هنا يتم إزالة جميع الصفحات السابقة من العارض
                            );
                          },
                        )..show();
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget blocbuild(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 16,
        ),
        Center(
          child: InkWell(
              onTap: () async {
                await Navigator.pushNamed(context, "profile");
              },
              child: prefs!.getString("profile") == null ||
                      prefs!.getString("profile") == ""
                  ? CircleAvatar(
                      child: Center(child: Text("لا توجد صورة")),
                      radius: 60,
                    )
                  : CircleAvatar(
                      radius: 60,
                      backgroundImage:
                          NetworkImage('${prefs!.getString("profile")}'),
                    )),
        ),
        SizedBox(height: 7),
        Center(
          child: prefs!.getString("stname") == null ||
                  prefs!.getString("stname") == ""
              ? Text(
                  "no name added",
                  style: TextStyle(color: Colors.white),
                )
              : Text(
                  textDirection: TextDirection.rtl,
                  ' ${prefs!.getString("stname")}',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
        ),
        SizedBox(
          height: 10,
        ),
        prefs!.getInt("code") == null || prefs!.getInt("code") == ""
            ? Container()
            : Center(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    child: Card(
                      child: Center(
                        child: Text(
                            'barcode:   ${prefs!.getInt("code").toString()}',
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 0, 0, 0))),
                      ),
                    ))),
        SizedBox(height: 10),
        Divider(
          color: Colors.blueAccent,
          height: 2,
        ),
      ],
    );
  }

  Column buildteacher() {
    return Column(
      children: [
        SizedBox(
          height: 16,
        ),
        Center(
          child: InkWell(
              onTap: () async {},
              child: prefs!.getString("profilet") == null ||
                      prefs!.getString("profilet") == ""
                  ? CircleAvatar(
                      child: Center(child: Text("لا توجد صورة")),
                      radius: 60,
                    )
                  : CircleAvatar(
                      radius: 60,
                      backgroundImage:
                          NetworkImage('${prefs!.getString("profilet")}'),
                    )),
        ),
        SizedBox(height: 16.0),
        Center(
          child: prefs!.getString("teachername") == null ||
                  prefs!.getString("teachername") == ""
              ? Text("no name added")
              : Text(
                  textDirection: TextDirection.rtl,
                  ' ${prefs!.getString("teachername")}',
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
        ),
        Divider(
          color: Colors.blueAccent,
          height: 2,
        ),
      ],
    );
  }

  Future<void> logout() async {
    await prefs!.clear();
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      trailing: Icon(icon, color: color),
      title: Text(text,
          textDirection: TextDirection.rtl,
          style: TextStyle(
            color: color,
            fontSize: 20,
          )),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }
}
