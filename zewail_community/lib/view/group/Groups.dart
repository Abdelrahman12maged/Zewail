import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../Controller/groups/Cubit/cubit.dart';
import '../../Controller/groups/Cubit/states.dart';
import '../../Controller/unreadcupit/Cubit.dart';
import '../../Controller/unreadcupit/States.dart';
import '../../Core/Constant/constants.dart';
import '../../Core/Constant/links.dart';
import '../../Core/Function/AlertExit.dart';
import '../../Core/Function/Api.dart';
import '../../Core/errors/Customerrowidget.dart';
import '../../data/models/Groups_model.dart';
import '../../main.dart';
import '../Drawer/Drawer.dart';
import '../PostsAndUsers/PostsPage.dart';
import 'cmponent/Indicator.dart';
import 'cmponent/groupitem.dart';
import 'notifacation.dart';

class Groupss extends StatefulWidget {
  Groupss({Key? key}) : super(key: key);

  @override
  State<Groupss> createState() => _GroupsState();
}

class _GroupsState extends State<Groupss> {
  var _selectedindex = 0;
  bool isloading = false;
  List<GroupModel> groupscached = [];
  // final NetworkController networkController = Get.find();
  Future<void> loadCachedGroups() async {
    try {
      String groupsDataJson = prefs!.getString('cached_groups') ?? '';
      List<dynamic> groupsData = jsonDecode(groupsDataJson);

      groupscached = groupsData
          .map((groupData) => GroupModel.fromJson(groupData))
          .cast<
              GroupModel>() // Ensure that the list contains GroupModel objects
          .toList();
    } catch (e) {
      print(e.toString());
    }
  }
/*
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
        print("FCM Token group: $fcmToken");
      }

      // هنا يمكنك تخزين الـ FCM Token في SharedPreferences أو أي مكان آخر
      // await   prefs!.setString("dtoken", fcmToken!);

      if (fcmToken != null) {
        await sendfcmtoken(fcmToken);
      }
      print('fcm group${fcmToken}');
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
            "$baseurl/student/",
        body: {
          "device_token": fcmtoken,
        },
      );

      // print(prefs!.getInt("stid"));
    } on Exception catch (e) {
      print(e.toString());
    }
  }*/

  @override
  void initState() {
    // fetchFCMToken();
    // BlocProvider.of<unreadCubit>(context).fetchUnreadnotif();
    //  BlocProvider.of<groupCubit>(context).fetchgroups();
    loadCachedGroups();
    print("cached groups ${groupscached}");
    super.initState();
  }

  /* Widget blocunread() {
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
  }*/

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return showExitConfirmationDialog(context);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.kPrimaryColor,
          /*leading: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NotificationPage()));
            },
            child: Stack(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 80,
                  decoration: BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: Icon(
                    Icons.notifications,
                    color: Colors.black,
                    size: 40,
                  ),
                ),
              ),
              //  blocunread()
            ]),
          ),*/
        ),
        backgroundColor: MyColors.kPrimaryColor,
        //   backgroundColor: Color.fromARGB(255, 34, 56, 69),
        endDrawer: Drawer(
            width: MediaQuery.of(context).size.width / 1.3,
            child: NavigationDrawerWidget()),
        body: allbodyPage(context),
      ),
    );
  }

  /* Widget unreadWidget(BuildContext context, int conunt) {
    return Positioned(
      top: 0,
      right: 0,
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
  }*/

  Column allbodyPage(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          "assets/group.png",
          height: MediaQuery.of(context).size.height / 3.7,
          fit: BoxFit.fitWidth,
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 220, 212, 212),
              borderRadius: BorderRadius.only(
                topLeft: containerRadius,
                topRight: containerRadius,
              ),
            ),
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: RefreshIndicator(
                    onRefresh: () async {
                      BlocProvider.of<groupCubit>(context).fetchgroups();
                    },
                    child: ListView(children: [blocGroups()]))),
          ),
        ),
      ],
    );
  }

  Widget blocGroups() {
    return BlocConsumer<groupCubit, groupStates>(listener: (context, state) {
      if (state is groupSucceslState) {
        final groupsJson =
            jsonEncode(state.groups.map((group) => group.toJson()).toList());

        prefs!.setString('cached_groups', groupsJson);
      }
    }, builder: (context, state) {
      //   isloading = true;

      if (state is groupSucceslState) {
        List<GroupModel> groups = state.groups;
        //  isloading = false;

        return groupbuildWidget(groups);
      } else if (state is groupfailuerState) {
        return Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      BlocProvider.of<groupCubit>(context).fetchgroups();
                    },
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.black,
                      size: 50,
                    )),
                Text(
                  "${state.error}",
                  style: TextStyle(fontSize: 16, color: Colors.red),
                ),
              ],
            ),

            SizedBox(height: 10),
            groupbuildWidget(groupscached), // Display cached groups
          ],
        );
      } else {
        return Center(
          child: SpinKitSpinningLines(
            color: Color.fromARGB(255, 5, 52, 239),
            duration: Duration(milliseconds: 1000),
          ),
        );
      }
    });
  }

  Column groupbuildWidget(List<GroupModel> groups) {
    return Column(
      children: [
        Text(
          "الجروبات",
          style: TextStyle(fontSize: 40, color: Colors.blue),
        ),
        SizedBox(
          height: 30,
        ),
        groups != null && groups.isNotEmpty
            ? Container(
                height: 200,
                child: PageView.builder(
                  onPageChanged: (index) {
                    setState(() {
                      _selectedindex = index;
                    });
                  },
                  controller: PageController(viewportFraction: 0.7),
                  itemCount: groups.length,
                  itemBuilder: (context, index) {
                    GroupModel group = groups[index];
                    var _scale = _selectedindex == index ? 1.0 : 0.8;
                    return TweenAnimationBuilder(
                      duration: Duration(milliseconds: 350),
                      tween: Tween(begin: _scale, end: _scale),
                      curve: Curves.ease,
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: child,
                        );
                      },
                      child: InkWell(
                        onTap: () {
                          //  Navigator.pushNamed(context, 'posts',
                          ///     arguments: group.id);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Psots(
                                    groupid: group.id, groupName: group.name),
                              ));
                        },
                        child: BoxItems(
                          image: group.image,
                          teacherName: group.teachername,
                          name: group.name,
                        ),
                      ),
                    );
                  },
                ),
              )
            : Center(
                child: Text(
                  'لا توجد جروبات بعد',
                  style: TextStyle(fontSize: 16),
                ),
              ),

        /*   FutureBuilder(
                        future: AllGroupsService().getAllGroups(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<GroupsModel> groupss = snapshot.data!;
                                          
                            return ;
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                                              ),*/
        SizedBox(
          height: 15,
        ),
        groups != null && groups.isNotEmpty
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    groups.length,
                    (index) => Indicator(
                        isActive: _selectedindex == index ? true : false),
                  )
                ],
              )
            : Text(""),
      ],
    );
  }
}
