import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../Controller/GroupTeacher/cubit.dart';
import '../../Controller/groups/Cubit/cubit.dart';
import '../../Core/Constant/constants.dart';
import '../../Core/Constant/links.dart';
import '../../Core/Function/Api.dart';
import 'profile.dart';
import '../group/Groups.dart';
import '../group/notifacation.dart';

import '../../Controller/unreadcupit/Cubit.dart';
import '../../Controller/unreadcupit/States.dart';
import '../../Core/Function/AlertExit.dart';
import '../../Core/errors/Customerrowidget.dart';
import '../../main.dart';
import '../Drawer/Drawer.dart';
import '../Drawer/webView.dart';
import '../group/GroupsTeacher.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _pageIndex = 1; // Index of the current page
  final PageController _pageController = PageController(initialPage: 1);
  bool? isteacher = prefs!.getBool('ist');

  final firbasemessag = FirebaseMessaging.instance;

  void fetchFCMToken() async {
    try {
      String? fcmToken;
      if (Firebase.apps.isNotEmpty) {
        NotificationSettings settings = await firbasemessag.requestPermission(
          alert: true,
          announcement: false,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: false,
          sound: true,
        );
        if (settings.authorizationStatus == AuthorizationStatus.authorized) {
          print('User granted permission');
        } else if (settings.authorizationStatus ==
            AuthorizationStatus.provisional) {
          print('User granted provisional permission');
        } else {
          print('User declined or has not accepted permission');
        }
        fcmToken = await FirebaseMessaging.instance.getToken();
        print("FCM Token home==: $fcmToken");
      }

      // هنا يمكنك تخزين الـ FCM Token في SharedPreferences أو أي مكان آخر
      // await   prefs!.setString("dtoken", fcmToken!);

      if (fcmToken != null) {
        await sendfcmtoken(fcmToken);
      }
      print('fcm home==${fcmToken}');
      // print("${prefs!.getString("dtoken")}");
    } catch (error) {
      print('Error fetching FCM Token: $error');
    }
  }

  Future<void> sendfcmtoken(
    String fcmtoken,
  ) async {
    try {
      var response = await Api().post(
        url:
            "$baseurl/student/updateDeviceToken?token=${prefs!.getString("token")}",
        body: {
          "device_token": fcmtoken,
        },
      );

      // print(prefs!.getInt("stid"));
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    fetchFCMToken();
    isteacher == true
        ? BlocProvider.of<groupTeacherCubit>(context).fetchgroupsTeacher()
        : BlocProvider.of<groupCubit>(context).fetchgroups();
    BlocProvider.of<unreadCubit>(context).fetchUnreadnotif();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
          width: MediaQuery.of(context).size.width / 1.3,
          child: NavigationDrawerWidget()),
      backgroundColor: Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
        index: _pageIndex, // Set the initial index
        onTap: (index) {
          _pageIndex = index; // Update the index when an item is tapped

          // Navigate to the selected page
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
        // animationDuration: Duration(milliseconds: 500),
        items: [
          Stack(children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                width: 80,
                decoration:
                    BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: Icon(
                  Icons.notifications,
                  color: Colors.black,
                  size: 35,
                ),
              ),
            ),
            blocunread()
          ]),
          Icon(
            Icons.home,
            color: Color.fromARGB(255, 236, 218, 218),
            size: 35,
          ),
          Icon(
            FontAwesomeIcons.earthAfrica,
            color: Color.fromARGB(255, 244, 226, 226),
            size: 35,
          ),
        ],
        backgroundColor: Color.fromARGB(255, 220, 212, 212),
        //color: Color.fromARGB(255, 174, 174, 174),
        //color: Color.fromARGB(255, 88, 83, 232),
        color: MyColors.kPrimaryColor,
        letIndexChange: (index) => true,
      ),
      // Create a PageView to display the pages
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          NotificationPage(),
          isteacher == true ? GroupssTeacher() : Groupss(),
          MyWebView(),
        ],
        onPageChanged: (index) {
          _pageIndex = index; // Update the index when the page changes
        },
      ),
    );
  }

  Widget blocunread() {
    return BlocConsumer<unreadCubit, unreadStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is unreadSucceslState) {
          return state.counts == null || state.counts == "" || state.counts == 0
              ? Container()
              : unreadWidget(context, state.counts!);
        } else if (state is unreadfailuerState) {
          return errrowidget(erromessage: '');
        } else {
          return Text('');
        }
      },
    );
  }

  Widget unreadWidget(BuildContext context, int conunt) {
    return Positioned(
      top: 14,
      right: 27,
      child: Container(
        width: 30, // تحديد العرض المناسب للدائرة
        height: 27, // تحديد الارتفاع المناسب للدائرة
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromARGB(255, 236, 2, 2),
        ),
        child: Center(
          child: Text(
            "${conunt.toString()}",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
