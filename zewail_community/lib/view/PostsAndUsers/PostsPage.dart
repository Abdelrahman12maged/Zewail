import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../Controller/GroupTeacher/cubit.dart';
import '../../Controller/posts/PostCubit.dart';
import '../../Controller/posts/PostCubit.dart';
import '../../Controller/posts/PostStates.dart';
import '../../Controller/groups/Cubit/cubit.dart';
import '../../Controller/groups/Cubit/states.dart';
import '../../Controller/profile/cubit.dart';
import '../../Controller/unreadcupit/Cubit.dart';
import '../../Core/Constant/LoadingIndic.dart';
import '../../Core/Constant/constants.dart';
import '../../Core/Function/Api.dart';
import '../../Core/errors/Customerrowidget.dart';
import '../../data/models/PostsModel.dart';
import '../Drawer/Drawer.dart';
import 'AddPost.dart';
import 'comments.dart';
import 'componentPosts/alert.dart';
import 'componentPosts/cardpost.dart';
import '../../Controller/posts/PostCubit.dart';
import '../../main.dart';

class Psots extends StatefulWidget {
  Psots({super.key, this.groupName, this.groupid});
  int? groupid;
  String? groupName;
  State<Psots> createState() => _PsotsState();
}

class _PsotsState extends State<Psots> {
  bool isDisposed = false;
  bool _isSearching = false;
  final _searchTextController = TextEditingController();
  late List<PostsModel> posts;
  late List<PostsModel> searchedForPosts;
  bool? isteacher = prefs!.getBool('ist');
  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }

  void initState() {
    super.initState();
    if (!isDisposed) {
      final postsCubit = context.read<postCubit>();
      if (widget.groupid != null) {
        postsCubit.fetchgroupPosts(widget.groupid!);
      }

      postsCubit.posts = [];
    }
    //  BlocProvider.of<postCubit>(context).fetchgroupPosts(widget.groupid!);
  }

  Widget _buildSearchField() {
    return Container(
      height: 55,
      child: Card(
        child: TextField(
          textDirection: TextDirection.rtl,
          controller: _searchTextController,
          cursorColor: Colors.amber,
          decoration: InputDecoration(
            fillColor: Color.fromARGB(255, 247, 237, 237),
            filled: true,
            hintText: 'بحث...',
            border: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none),
            hintStyle:
                TextStyle(color: Color.fromARGB(255, 2, 1, 1), fontSize: 18),
          ),
          style: TextStyle(color: Color.fromARGB(255, 9, 8, 8), fontSize: 18),
          onSubmitted: (val) {
            if (widget.groupid != null) {
              BlocProvider.of<postCubit>(context)
                  .fetchgroupPosts(widget.groupid!, _searchTextController.text);
            }
          },
        ),
      ),
    );
  }

  Widget _buildAppBarTitle() {
    return Row(
      children: [
        IconButton(
          iconSize: 40,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    AddPost(groupid: widget.groupid), // Pass the post data here
              ),
            );
          },
          icon: Icon(
            color: Colors.white,
            Icons.add_box_rounded,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () async {
            //  BlocProvider.of<postCubit>(context)
            //    .fetchgroupPosts(widget.groupid!);
            _clearSearch();
            Navigator.pop(context);
          },
          icon: Icon(Icons.clear, color: Color.fromARGB(255, 254, 252, 252)),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: Icon(
            Icons.search,
            size: 35,
            color: Color.fromARGB(255, 255, 253, 253),
          ),
        ),
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    if (_searchTextController.text.isNotEmpty) {
      setState(() {
        _searchTextController.clear();
      });
      BlocProvider.of<postCubit>(context).fetchgroupPosts(widget.groupid!);
    }
  }

  @override
  Widget build(BuildContext context) {
    /*  if (isDisposed) {
      //   BlocProvider.of<postCubit>(context).fetchgroupPosts(widget.groupid!);
      final postsCubit = context.read<postCubit>();
      postsCubit.posts = [];
    }

*/

    // final int groupId = ModalRoute.of(context)!.settings.arguments as int;

    return widget.groupid != null
        ? Scaffold(
            backgroundColor: MyColors.kPrimaryColor,
            appBar: AppBar(
              leading: _isSearching
                  ? BackButton(
                      //  onPressed: () async {
                      //   BlocProvider.of<postCubit>(context)
                      //       .fetchgroupPosts(widget.groupid!);
                      //    Navigator.pop(context);
                      //   },
                      color: Color.fromARGB(255, 249, 245, 245),
                    )
                  : _buildAppBarTitle(),
              title: _isSearching ? _buildSearchField() : Container(),
              backgroundColor: MyColors.kPrimaryColor,
              actions: _buildAppBarActions(),
              /*    actions: [
          Center(
            child: Text(
              "أضف سؤال",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          IconButton(
            iconSize: 40,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddPost(
                      groupid: widget.groupid), // Pass the post data here
                ),
              );
            },
            icon: Icon(
              color: Colors.white,
              Icons.add_box_rounded,
            ),
          ),
        ],*/
            ),
            endDrawer: Drawer(
                width: MediaQuery.of(context).size.width / 1.3,
                child: NavigationDrawerWidget()),
            body: BlocConsumer<postCubit, postStates>(
              listener: (context, state) {
                if (state is PostSucceslState) {
                  BlocProvider.of<groupCubit>(context).fetchgroups();
                  BlocProvider.of<unreadCubit>(context).fetchUnreadnotif();
                  BlocProvider.of<groupTeacherCubit>(context)
                      .fetchgroupsTeacher();
                }
                if (state is deletePostSuccess) {
                  AwesomeDialog(
                    autoHide: Duration(milliseconds: 1200),

                    context: context,
                    dialogType: DialogType.success,
                    //  animType: AnimType.rightSlide,
                    desc: 'تم حذف البوست',
                  )..show();
                }
              },
              builder: (context, state) {
                if (state is deletePostSuccess) {
                  BlocProvider.of<postCubit>(context)
                      .fetchgroupPosts(widget.groupid!);
                  if (isteacher == false && prefs!.getInt("stid") != null) {
                    BlocProvider.of<getUserCubit>(context)
                        .fetchStudentPosts(prefs!.getInt("stid") as int);
                  }
                }
                if (state is PostSucceslState) {
                  posts = state.posts;
                  final postsCubi = context.read<postCubit>();
                  final isLoading = postsCubi.isLoading;
                  final isLoadingMore = postsCubi.isLoadingMore;
                  final hasMoreData = postsCubi.hasMoreData;

                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _isSearching == false
                                ? Text(
                                    widget.groupName != null ||
                                            widget.groupName != ""
                                        ? "${widget.groupName}"
                                        : 'no name added',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    " قم بالبحث الان في المنشورات",
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            //  color: Color.fromARGB(255, 220, 212, 212),
                            color: Color.fromARGB(255, 205, 205, 205),
                            borderRadius: BorderRadius.only(
                              topLeft: containerRadius,
                              topRight: containerRadius,
                            ),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: 3, right: 10, left: 10),
                            child: NotificationListener<ScrollNotification>(
                              onNotification: (ScrollNotification scrollInfo) {
                                if (scrollInfo.metrics.pixels ==
                                    scrollInfo.metrics.maxScrollExtent) {
                                  //final gid = postsCubi.selectedGroupid;

                                  if (!isLoading && hasMoreData) {
                                    postsCubi.loadMorePosts(widget.groupid);
                                  }
                                }
                                return true;
                              },
                              child: posts != null && posts.isNotEmpty
                                  ? RefreshIndicator(
                                      onRefresh: () async {
                                        BlocProvider.of<postCubit>(context)
                                            .fetchgroupPosts(widget.groupid!);
                                      },
                                      child: ListView.builder(
                                        physics: BouncingScrollPhysics(),
                                        itemCount: posts.length + 1,
                                        itemBuilder: (context, index) {
                                          if (index == posts.length) {
                                            if (isLoadingMore) {
                                              return Center(
                                                child:
                                                    Loading(), // عرض LoadingIndicator عند التحميل
                                              );
                                            } else if (hasMoreData) {
                                              return InkWell(
                                                onTap: () {
                                                  //  final gid =
                                                  //      postsCubi.selectedGroupid;
                                                  if (!isLoading &&
                                                      hasMoreData) {
                                                    postsCubi.loadMorePosts(
                                                        widget.groupid);
                                                  }
                                                },
                                                child: isLoading
                                                    ? Loading() // عرض LoadingIndicator أثناء التحميل
                                                    : Center(
                                                        child: Text(
                                                        '..جار تحميل المزيد',
                                                        style: TextStyle(
                                                            color: Colors.blue,
                                                            fontSize: 20),
                                                      )),
                                              );
                                            } else {
                                              return Container();
                                            }
                                          }
                                          PostsModel post = posts[index];

                                          return Column(
                                            children: [
                                              CardPost(
                                                isteacher: post.isteacher,
                                                numcomments:
                                                    post.comments != null
                                                        ? post.comments?.length
                                                        : 0,
                                                studenName: post.ownerName,
                                                timeago: post.timeago,
                                                content: post.content,
                                                image: post.image,
                                                bookpage: post.bookpage,
                                                bookname: post.bookName != null
                                                    ? post.bookName?.name
                                                    : 'no book',
                                                qnum: post.qnum,
                                                avatar: post.avatar,
                                                teacherreplay: post.teachreply,
                                                onPressed: () {
                                                  // post.studentdata != null &&
                                                  //  prefs!.getInt("stid") ==
                                                  //     post.studentdata!.stId
                                                  if (isteacher == true &&
                                                      post.isteacher == 1) {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return CustomActionoptin(
                                                            contenDelte:
                                                                'هل انت متأكد انك تريد حذف البوست',
                                                            contenttitleDelete:
                                                                "حذف البوست",
                                                            titleDelete:
                                                                "حذف البوست",
                                                            titleEdit:
                                                                "تعديل البوست",
                                                            onDeleteConfirmed:
                                                                () {
                                                              BlocProvider.of<
                                                                          postCubit>(
                                                                      context)
                                                                  .deletePost(
                                                                      post.id!);
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            onEdit: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder: (context) => AddPost(
                                                                      bookbage: post
                                                                          .bookpage,
                                                                      content: post
                                                                          .content,
                                                                      image: post
                                                                          .image,
                                                                      postid: post
                                                                          .id,
                                                                      qunm: post
                                                                          .qnum,
                                                                      selectedbook: post.bookName !=
                                                                              null
                                                                          ? post
                                                                              .bookName!
                                                                              .id
                                                                          : null,
                                                                      groupidpost:
                                                                          post
                                                                              .groupid,
                                                                      groupid:
                                                                          widget
                                                                              .groupid),
                                                                  // Pass the post data here
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        });
                                                  } else if (post.studentdata !=
                                                          null &&
                                                      prefs!.getInt("stid") ==
                                                          post.studentdata!
                                                              .stId) {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return CustomActionoptin(
                                                            contenDelte:
                                                                'هل انت متأكد انك تريد حذف البوست',
                                                            contenttitleDelete:
                                                                "حذف البوست",
                                                            titleDelete:
                                                                "حذف البوست",
                                                            titleEdit:
                                                                "تعديل البوست",
                                                            onDeleteConfirmed:
                                                                () {
                                                              BlocProvider.of<
                                                                          postCubit>(
                                                                      context)
                                                                  .deletePost(
                                                                      post.id!);
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            onEdit: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder: (context) => AddPost(
                                                                      bookbage: post
                                                                          .bookpage,
                                                                      content: post
                                                                          .content,
                                                                      image: post
                                                                          .image,
                                                                      postid: post
                                                                          .id,
                                                                      qunm: post
                                                                          .qnum,
                                                                      selectedbook: post.bookName !=
                                                                              null
                                                                          ? post
                                                                              .bookName!
                                                                              .id
                                                                          : null,
                                                                      groupidpost:
                                                                          post
                                                                              .groupid,
                                                                      groupid:
                                                                          widget
                                                                              .groupid),
                                                                  // Pass the post data here
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        });
                                                  } else if (isteacher ==
                                                          true &&
                                                      post.isteacher == 0) {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return CustomActionoptin(
                                                            contenDelte:
                                                                'هل انت متأكد انك تريد حذف البوست',
                                                            contenttitleDelete:
                                                                "حذف البوست",
                                                            titleDelete:
                                                                "حذف البوست",
                                                            onDeleteConfirmed:
                                                                () {
                                                              BlocProvider.of<
                                                                          postCubit>(
                                                                      context)
                                                                  .deletePost(
                                                                      post.id!);
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                          );
                                                        });
                                                  }
                                                },
                                                ontapcomment: () {
                                                  if (post != null &&
                                                      post.id != null) {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            comments(
                                                          postid: post.id,
                                                        ),
                                                        // Pass the post data here
                                                      ),
                                                    );
                                                  }

                                                  // Navigator.pushNamed(
                                                  //    context, "comments",
                                                  //   arguments: post.id);
                                                },
                                                ontapIconcomment: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          comments(
                                                        postid: post.id,
                                                      ),
                                                      // Pass the post data here
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    )
                                  : Center(
                                      child: _isSearching
                                          ? Text(
                                              'لا توجد نتائج البحث.',
                                              style: TextStyle(fontSize: 16),
                                            )
                                          : Text(
                                              'لا توجد منشورات بعد.',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (state is PostfailuerState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                BlocProvider.of<postCubit>(context)
                                    .fetchgroupPosts(widget.groupid!);
                              },
                              icon: Icon(
                                Icons.refresh,
                                color: Colors.black,
                                size: 50,
                              )),
                          Text(
                            "${state.error}",
                            style: TextStyle(
                                fontSize: 13,
                                color: Color.fromARGB(255, 252, 251, 251)),
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  return SpinKitHourGlass(
                    color: Color.fromARGB(255, 131, 225, 146),
                    duration: Duration(milliseconds: 1000),
                  );
                }
              },
            ),
          )
        : Center(child: Text("الجروب غير موجود "));
  }
}
