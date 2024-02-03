import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../Core/Function/AlertExit.dart';
import '../../Controller/Notification/Cubit.dart';
import '../../Controller/Notification/states.dart';
import '../../Controller/groups/Cubit/cubit.dart';
import '../../Controller/profile/cubit.dart';
import '../../Controller/unreadcupit/Cubit.dart';
import '../../data/models/notification.dart';
import '../PostsAndUsers/comments.dart';

import '../../Core/errors/Customerrowidget.dart';
import '../../main.dart';
import '../PostsAndUsers/componentPosts/fullscreen.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    BlocProvider.of<notificationCubit>(context).fetchNotifications();
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return showExitConfirmationDialog(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('الاشعارات')),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            return await BlocProvider.of<notificationCubit>(context)
                .fetchNotifications();
          },
          child: BlocConsumer<notificationCubit, getnotificationStates>(
            listener: (context, state) {
              if (state is notifcationSucceslState) {
                //   BlocProvider.of<groupCubit>(context).fetchgroups();
                BlocProvider.of<unreadCubit>(context).fetchUnreadnotif();
              }
            },
            builder: (context, state) {
              if (state is notifcationSucceslState) {
                return NotificationList(state.notifs);
              } else if (state is notifcationfailuerState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              BlocProvider.of<notificationCubit>(context)
                                  .fetchNotifications();
                            },
                            icon: Icon(
                              Icons.refresh,
                              color: Colors.black,
                              size: 50,
                            )),
                        Text(
                          "${state.error}",
                          style: TextStyle(fontSize: 13, color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                return SpinKitSpinningLines(
                  color: Color.fromARGB(255, 5, 52, 239),
                  duration: Duration(milliseconds: 1000),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class NotificationList extends StatelessWidget {
  NotificationList(this.notifs);
  notificationModel notifs;
  @override
  Widget build(BuildContext context) {
    return notifs.data != null && notifs.data!.isNotEmpty
        ? ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: notifs.data!.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  if (notifs.data![index].postId != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => comments(
                                  postid: notifs.data![index].postId,
                                )));
                  }
                },
                child: NotificationCard(
                  message: notifs.data![index].body,
                  timeago: notifs.data![index].timeAgo,
                  image: notifs.data![index].image,
                ),
              );
            },
          )
        : Center(child: Text('لا توجد اشعارات'));
  }
}

class NotificationCard extends StatelessWidget {
  final String? message;
  final String? timeago;
  final String? image;

  NotificationCard({this.message, this.timeago, this.image});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 229, 219, 218),
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: [
          ListTile(
            trailing: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(Icons.notifications),
            ),
            title: message == null || message == ""
                ? Text("")
                : Text(
                    "$message",
                    textDirection: TextDirection.rtl,
                  ),
            subtitle: timeago == null || message == ""
                ? Text("")
                : Text(
                    '$timeago',
                    textDirection: TextDirection.rtl,
                  ),
          ),
          image == null || image == ""
              ? Container()
              : CachedNetworkImage(
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  imageUrl: "${image}",
                  imageBuilder: (context, imageProvider) {
                    return GestureDetector(
                      onDoubleTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullScreenImagePage(
                                  imageUrl: image as String),
                            ));
                      },
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.fill)),
                      ),
                    );
                  })
        ],
      ),
    );
  }
}
