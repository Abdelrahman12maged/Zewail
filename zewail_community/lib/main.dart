import 'dart:collection';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'view/auth/welcome.dart';
import 'view/PostsAndUsers/HomePage.dart';
import 'Controller/GroupTeacher/cubit.dart';
import 'Controller/Notification/Cubit.dart';
import 'Controller/addcomment/cubit.dart';
import 'Controller/booksCubit/Cubit.dart';
import 'Controller/posts/PostCubit.dart';
import 'Controller/groups/Cubit/cubit.dart';
import 'Controller/profile/cubit.dart';
import 'Controller/unreadcupit/Cubit.dart';
import 'Core/Function/Api.dart';
import 'data/repo/PostsRepoImp.dart';
import 'data/repo/groupRepoimp.dart';
import 'view/Drawer/webView.dart';
import 'view/PostsAndUsers/AddPost.dart';
import 'view/PostsAndUsers/PostsPage.dart';
import 'view/PostsAndUsers/comments.dart';
import 'view/PostsAndUsers/profile.dart';
import 'view/auth/Login.dart';
import 'view/auth/LoginTeacher.dart';
import 'view/auth/Register.dart';
import 'view/auth/homelogine.dart';
import 'view/group/Groups.dart';
import 'view/group/GroupsTeacher.dart';

import 'Controller/addpost/addpostCubit.dart';

import 'view/intro/OnBording.dart';

SharedPreferences? prefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  prefs = await SharedPreferences.getInstance();

  String? token = prefs!.getString("token");
  //String? tokent = prefs!.getString("tokent");
  bool? isteacher = prefs!.getBool('ist');

  Widget? screen;
  if (isteacher == null || isteacher == "") {
    screen = const OnBording();
  }
  if (token == null || token == "") {
    screen = const OnBording();
  } else {
    // isteacher == true ? screen = GroupssTeacher() : screen = Groupss();
    screen = HomePage();
  }

  runApp(MyApp(
    screen: screen,
  ));
//  DependencyInjection.init();
  await Permission.microphone.request();
}

class MyApp extends StatelessWidget {
  final Widget? screen;
  // ignore: non_constant_identifier_names
  MyApp({super.key, required this.screen});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider(
        // create: (context) => LoginCubit(),
        //),
        BlocProvider<groupCubit>(
            create: (context) =>
                groupCubit(groupRepoim(Apiservice(Dio())))..fetchgroups()),
        BlocProvider<groupTeacherCubit>(
            create: (context) =>
                groupTeacherCubit(groupRepoim(Apiservice(Dio())))
                  ..fetchgroupsTeacher()),
        BlocProvider<notificationCubit>(
            create: (context) =>
                notificationCubit(groupRepoim(Apiservice(Dio())))),
        BlocProvider<postCubit>(
            create: (context) => postCubit(postRepoim(Apiservice(Dio())))),
        BlocProvider<addpostCubit>(
            create: (context) => addpostCubit(postRepoim(Apiservice(Dio())))),
        BlocProvider<addcommentCubit>(
            create: (context) =>
                addcommentCubit(postRepoim(Apiservice(Dio())))),
        BlocProvider<getUserCubit>(
            create: (context) => getUserCubit(postRepoim(Apiservice(Dio())))),
        BlocProvider<booksCubit>(
            create: (context) => booksCubit(postRepoim(Apiservice(Dio())))),
        BlocProvider<unreadCubit>(
            create: (context) => unreadCubit(groupRepoim(Apiservice(Dio())))
              ..fetchUnreadnotif()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.fallback(useMaterial3: true),
        home: screen,
        routes: {
          "start": (context) => OnBording(),
          "Register": (context) => Register(),
          "homelogin": (context) => loginhome(),
          "Login": (context) => Login(),
          "LoginTeacher": (context) => LoginTeacher(),
          "group": (context) => Groupss(),
          "groupTeacher": (context) => GroupssTeacher(),
          "posts": (context) => Psots(),
          "addpost": (context) => AddPost(),
          "profile": (context) => ProfilePage(),
          "comments": (context) => comments(),
          "web": (context) => MyWebView()
        },
      ),
    );
  }
}
