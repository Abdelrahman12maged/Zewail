import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../Controller/GroupTeacher/States.dart';
import '../../Controller/GroupTeacher/cubit.dart';
import '../../Controller/unreadcupit/Cubit.dart';
import '../../Controller/unreadcupit/States.dart';
import '../../Core/Constant/constants.dart';
import '../../Core/Constant/links.dart';
import '../../Core/Function/AlertExit.dart';
import '../../Core/Function/Api.dart';
import '../../Core/errors/Customerrowidget.dart';
import '../../data/models/GroupsTeacherModel.dart';
import '../../main.dart';
import '../Drawer/Drawer.dart';
import '../PostsAndUsers/PostsPage.dart';
import 'cmponent/Indicator.dart';
import 'cmponent/groupitem.dart';
import 'notifacation.dart';

class GroupssTeacher extends StatefulWidget {
  GroupssTeacher({Key? key}) : super(key: key);

  @override
  State<GroupssTeacher> createState() => _GroupssTeacherState();
}

class _GroupssTeacherState extends State<GroupssTeacher> {
  var _selectedindex = 0;
  bool isloading = false;
  List<GroupTeacherModel> groupscached = [];

  Future<void> loadCachedGroups() async {
    try {
      String groupsDataJson = prefs!.getString('cached_groups') ?? '';
      List<dynamic> groupsData = await jsonDecode(groupsDataJson);

      groupscached = groupsData
          .map((groupData) => GroupTeacherModel.fromJson(groupData))
          .cast<
              GroupTeacherModel>() // Ensure that the list contains GroupModel objects
          .toList();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    // fetchFCMToken();
    loadCachedGroups();
    // BlocProvider.of<unreadCubit>(context).fetchUnreadnotif();
    //  BlocProvider.of<groupTeacherCubit>(context).fetchgroupsTeacher();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return showExitConfirmationDialog(context);
        },
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: MyColors.kPrimaryColor,
            ),
            backgroundColor: MyColors.kPrimaryColor,
            //   backgroundColor: Color.fromARGB(255, 34, 56, 69),
            endDrawer: Drawer(
              width: MediaQuery.of(context).size.width / 1.3,
              child: NavigationDrawerWidget(),
            ),
            body: Column(
              children: [
                Image.asset(
                  "assets/img.png",
                  height: MediaQuery.of(context).size.height / 3.3,
                  fit: BoxFit.fill,
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
                              BlocProvider.of<groupTeacherCubit>(context)
                                  .fetchgroupsTeacher();
                            },
                            child: ListView(children: [blocGroups()]))),
                  ),
                ),
              ],
            )));
  }

  Widget blocGroups() {
    return BlocConsumer<groupTeacherCubit, groupTeacherStates>(
        listener: (context, state) {
      if (state is groupTeacherSucceslState) {
        final groupsJson =
            jsonEncode(state.groups.map((group) => group.toJson()).toList());

        prefs!.setString('cached_groups', groupsJson);
      }
    }, builder: (context, state) {
      if (state is groupTeacherSucceslState) {
        List<GroupTeacherModel> groups = state.groups;
        //  isloading = false;

        return groupbuildWidget(groups);
      } else if (state is groupTeacherfailuerState) {
        return Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      BlocProvider.of<groupTeacherCubit>(context)
                          .fetchgroupsTeacher();
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
        return SpinKitSpinningLines(
          color: Color.fromARGB(255, 5, 52, 239),
          duration: Duration(milliseconds: 1000),
        );
      }
    });
  }

  Column groupbuildWidget(List<GroupTeacherModel> groups) {
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
                    GroupTeacherModel group = groups[index];
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Psots(
                                    groupid: group.id,
                                    groupName: group.courseName),
                              ));
                        },
                        child: BoxItems(
                          image: group.image,
                          teacherName: group.teachername,
                          name: group.courseName,
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
