import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../Controller/posts/PostCubit.dart';
import '../../Controller/profile/cubit.dart';
import '../../Controller/profile/states.dart';
import '../../Core/Constant/LoadingIndic.dart';
import '../../data/models/PostsModel.dart';
import '../../main.dart';
import 'AddPost.dart';
import 'comments.dart';
import 'componentPosts/Alert.dart';
import 'componentPosts/cardpost.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({
    super.key,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isDisposed = false;
  ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    isDisposed = true;
    _scrollController.dispose();
    super.dispose();
  }

  void initState() {
    if (!isDisposed) {
      final studenCubi = context.read<getUserCubit>();
      studenCubi.fetchStudentPosts(prefs!.getInt("stid") as int);
      studenCubi.posts = [];
    }
    _scrollController.addListener(_scrollListener);
    super.initState();
    //   BlocProvider.of<getUserCubit>(context).getuserData();
    //  studecubit.fetchStudentPosts(user!.data!.stId!);
  }

  void _scrollListener() {
    final studenCubi = context.read<getUserCubit>();
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    final threshold =
        100.0; // التمييز بين نهاية القائمة والحاجة لجلب المزيد من البيانات

    if (maxScroll - currentScroll <= threshold &&
        !studenCubi.isLoadingMore &&
        studenCubi.hasMoreData) {
      // جلب المزيد من البيانات بمجرد الوصول لنهاية القائمة
      studenCubi.loadMorePosts(prefs!.getInt("stid") as int);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 223, 225, 232),
        // backgroundColor: Color.fromARGB(255, 220, 212, 212),
        appBar: AppBar(
          //  backgroundColor: Color.fromARGB(255, 220, 212, 212),
          backgroundColor: Color.fromARGB(255, 223, 225, 232),
          title: Center(
              child: Text(
            'ملفي الشخصي',
            style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          )),
        ),
        body:
            BlocConsumer<getUserCubit, UserStates>(listener: (context, state) {
          if (state is deleteUserPostSuccess) {
            AwesomeDialog(
              autoHide: Duration(milliseconds: 1200),

              context: context,
              dialogType: DialogType.success,
              //  animType: AnimType.rightSlide,
              desc: 'تم حذف البوست',
            )..show();
          }
          // if (state is getUserSucceslState) {
          //    BlocProvider.of<getUserCubit>(context).getuserData();
          //   user = BlocProvider.of<getUserCubit>(context).userr;
          //  }
          // TODO: implement listener
        }, builder: (context, state) {
          if (state is deleteUserPostSuccess) {
            final studecubit = BlocProvider.of<getUserCubit>(context);
            studecubit.fetchStudentPosts(prefs!.getInt("stid") as int);
          }
          if (state is postsUserSucceslState) {
            List<PostsModel> posts = state.posts;
            final studenCubi = context.read<getUserCubit>();
            final isLoading = studenCubi.isLoading;
            final isLoadingMore = studenCubi.isLoadingMore;
            final hasMoreData = studenCubi.hasMoreData;
            //  user = BlocProvider.of<getUserCubit>(context).userr;

            return RefreshIndicator(
              onRefresh: () async {
                final studecubit = BlocProvider.of<getUserCubit>(context);
                studecubit.fetchStudentPosts(prefs!.getInt("stid") as int);
              },
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                        child: prefs!.getString("profile") == null ||
                                prefs!.getString("profile") == ""
                            ? CircleAvatar(
                                child: Center(child: Text("لا توجد صورة")),
                                radius: 60,
                              )
                            : CircleAvatar(
                                radius: 60,
                                backgroundImage: NetworkImage(
                                    '${prefs!.getString("profile")}'),
                              )),
                    SizedBox(height: 16.0),
                    Center(
                      child: prefs!.getString("stname") == null ||
                              prefs!.getString("stname") == ""
                          ? Text(
                              "no name added",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            )
                          : Text(
                              textDirection: TextDirection.rtl,
                              ' ${prefs!.getString("stname")}',
                              style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                    ),
                    Divider(),
                    Text(
                      textDirection: TextDirection.rtl,
                      'المنشورات',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          if (scrollInfo.metrics.pixels ==
                              scrollInfo.metrics.maxScrollExtent) {
                            if (!isLoading && hasMoreData) {
                              studenCubi
                                  .loadMorePosts(prefs!.getInt("stid") as int);
                            }
                          }
                          return true;
                        },
                        child: posts != null && posts.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
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
                                          if (!isLoading && hasMoreData) {
                                            studenCubi.loadMorePosts(
                                                prefs!.getInt("stid") as int);
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
                                        avatar: post.avatar,
                                        numcomments: post.comments != null
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
                                        teacherreplay: post.teachreply,
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return CustomActionoptin(
                                                  contenDelte:
                                                      'هل انت متأكد انك تريد حذف البوست',
                                                  contenttitleDelete:
                                                      "حذف البوست",
                                                  titleDelete: "حذف البوست",
                                                  titleEdit: "تعديل البوست",
                                                  onDeleteConfirmed: () {
                                                    BlocProvider.of<postCubit>(
                                                            context)
                                                        .deletePost(post.id!);
                                                    // final studenCubi = context.read<getUserCubit>();

                                                    Navigator.of(context).pop();
                                                  },
                                                  onEdit: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) => AddPost(
                                                            bookbage:
                                                                post.bookpage,
                                                            content:
                                                                post.content,
                                                            image: post.image,
                                                            postid: post.id,
                                                            qunm: post.qnum,
                                                            selectedbook:
                                                                post.bookName !=
                                                                        null
                                                                    ? post
                                                                        .bookName!
                                                                        .id
                                                                    : null,
                                                            groupidpost:
                                                                post.groupid,
                                                            groupid:
                                                                post.groupid),
                                                        // Pass the post data here
                                                      ),
                                                    );
                                                  },
                                                );
                                              });
                                        },
                                        ontapcomment: () {
                                          if (post != null && post.id != null) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => comments(
                                                  postid: post.id,
                                                ),
                                                // Pass the post data here
                                              ),
                                            );
                                          }
                                        },
                                        ontapIconcomment: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => comments(
                                                postid: post.id!,
                                              ),
                                              // Pass the post data here
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                },
                              )
                            : Center(
                                child: Text(
                                  'لا توجد منشورات بعد.',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is postsUserFailure) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          BlocProvider.of<getUserCubit>(context)
                              .fetchStudentPosts(prefs!.getInt("stid") as int);
                        },
                        icon: Icon(
                          Icons.refresh,
                          color: Colors.black,
                          size: 50,
                        )),
                    Text(
                      "${state.erro}",
                      style: TextStyle(fontSize: 13, color: Colors.red),
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
        }));
  }
}
