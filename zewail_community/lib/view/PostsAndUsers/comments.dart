// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:zewail_community/Controller/addcomment/cubit.dart';
import 'package:zewail_community/Controller/addpost/addpostCubit.dart';
import 'package:zewail_community/Controller/posts/PostCubit.dart';
import 'package:zewail_community/Controller/posts/PostStates.dart';
import 'package:zewail_community/Core/Constant/LoadingIndic.dart';
import 'package:zewail_community/Core/Constant/constants.dart';
import 'package:zewail_community/Core/errors/Customerrowidget.dart';
import 'package:zewail_community/data/models/PostDatamodel.dart';
import 'package:zewail_community/data/models/PostsModel.dart';
import 'package:zewail_community/view/PostsAndUsers/AddPost.dart';
import 'package:zewail_community/view/PostsAndUsers/componentPosts/alert.dart';
import 'package:zewail_community/view/PostsAndUsers/componentPosts/cardpost.dart';
import 'package:zewail_community/view/PostsAndUsers/componentPosts/commentcard.dart';
import 'package:zewail_community/view/auth/component/customcomponent.dart';
import 'package:path_provider/path_provider.dart';
import '../../Controller/addcomment/states.dart';
import '../../Controller/profile/cubit.dart';
import '../../Controller/unreadcupit/Cubit.dart';
import '../../Core/Function/validation.dart';

import '../../main.dart';
import 'componentPosts/addimagewidget.dart';
import 'package:path/path.dart' as path;

class comments extends StatefulWidget {
  comments({
    Key? key,
    this.datapost,
    this.postid,
  }) : super(key: key);
  PostsModel? datapost;
  int? postid;
  //int? groupid;
  @override
  _commentsState createState() => _commentsState();
}

class _commentsState extends State<comments> {
  final _commentController = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey();
  bool? isteacher = prefs!.getBool('ist');
  @override
  void dispose() {
    _commentController.dispose();
    recorder.closeRecorder();
    // for (var player in advancePlayers) {
    //   player?.dispose();
    //  }

    super.dispose();
  }

  File? _imageFile;
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }

/////////////////////////
//sounddddddddddddddd
////////////////////////////////////////////////////////////////////////////////////////////
  List<AudioPlayer?> advancePlayers = [];
  @override
  void didChangeDependencies() {
    initRecorder();
    // final int postid = ModalRoute.of(context)!.settings.arguments as int;
    BlocProvider.of<addcommentCubit>(context).getpostData(widget.postid!);

    super.didChangeDependencies();
  }

  final recorder = FlutterSoundRecorder();

  Future initRecorder() async {
    try {
      final status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw 'Permission not granted';
      }
      await recorder.openRecorder();

      recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> startRecord() async {
    try {
      final status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        AwesomeDialog(context: context, desc: "لم يتم منح الاذن للميكروفون")
          ..show();
        throw RecordingPermissionException("Microphone permission not granted");
      }

      await initRecorder();
      await recorder.startRecorder(toFile: 'audio');
    } catch (e) {
      print("Error starting recorder: $e");
      // Handle any errors that might occur during recording.
    }
  }

  File? file;
  Future<void> stopRecorder() async {
    final filePath = await recorder.stopRecorder();

    if (filePath != null && filePath.isNotEmpty) {
      final directory = await getApplicationDocumentsDirectory();
      final newPath = path.join(directory.path, 'audio.wav');
      final sourceFile = File(filePath);
      if (await sourceFile.exists()) {
        await sourceFile.copy(newPath);
        setState(() {
          file = File(newPath);
        });
        print("filll $file");
      } else {
        print("Error: Source file does not exist");
      }
    } else {
      print("Error saving the audio file");
    }
  }

  bool isrecord = false;
///////////////////////////////

  @override
  Widget build(BuildContext context) {
    final poscubit = BlocProvider.of<postCubit>(context);
    // final int postid = ModalRoute.of(context)!.settings.arguments as int;
    //

    return Scaffold(
        appBar: AppBar(
          iconTheme:
              const IconThemeData(color: Color.fromARGB(255, 251, 171, 125)),
          backgroundColor: const Color.fromARGB(255, 223, 225, 232),
        ),
        backgroundColor: const Color.fromARGB(255, 223, 225, 232),
        body: BlocConsumer<addcommentCubit, addcommentStates>(
            listener: (context, state) {
          if (state is getpostSucceslState) {
            BlocProvider.of<unreadCubit>(context).fetchUnreadnotif();
          }
          if (state is addcommentSuccess) {
            final msg = state.msg.msg;
            msg == null || msg == ""
                ? AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    autoHide: const Duration(seconds: 2))
                : AwesomeDialog(
                    context: context,
                    width: 160,
                    dialogType: DialogType.success,
                    autoHide: Duration(seconds: 2))
              ..show();
          }

          if (state is addRecordSuccess) {
            AwesomeDialog(
                dialogBackgroundColor: Color.fromARGB(255, 179, 172, 171),
                width: 180,
                context: context,
                //     desc: "تمت الاضافة للمفضلة",
                dialogType: DialogType.success,
                autoHide: Duration(seconds: 2))
              ..show();
          }
          if (state is deleteCommentSuccess) {
            AwesomeDialog(
                dialogBackgroundColor: Color.fromARGB(255, 179, 172, 171),
                width: 180,
                context: context,
                //     desc: "تمت الاضافة للمفضلة",
                dialogType: DialogType.success,
                autoHide: Duration(seconds: 2))
              ..show();
          }

          /* if (state is addcommentSuccess) {
            BlocProvider.of<addcommentCubit>(context).getpostData(postid);

            poscubit.fetchgroupPosts(poscubit.selectedGroupid);
          } else if (state is addRecordSuccess) {
            BlocProvider.of<addcommentCubit>(context).getpostData(postid);
            poscubit.fetchgroupPosts(poscubit.selecte dGroupid);
          } else if (state is deleteCommentSuccess) {
            BlocProvider.of<addcommentCubit>(context).getpostData(postid);
            poscubit.fetchgroupPosts(poscubit.selectedGroupid);
          }


          */
        }, builder: (context, state) {
          if (state is addcommentSuccess) {
            BlocProvider.of<addcommentCubit>(context)
                .getpostData(widget.postid!);

            // poscubit.fetchgroupPosts(poscubit.selectedGroupid);
          }
          if (state is addRecordSuccess) {
            BlocProvider.of<addcommentCubit>(context)
                .getpostData(widget.postid!);
            // poscubit.fetchgroupPosts(poscubit.selectedGroupid);
          }
          if (state is deleteCommentSuccess) {
            BlocProvider.of<addcommentCubit>(context)
                .getpostData(widget.postid!);
            //poscubit.fetchgroupPosts(poscubit.selectedGroupid);
          }

          //   addcommentCubit cubit = BlocProvider.of<addcommentCubit>(context);
          if (state is getpostSucceslState) {
            final post = BlocProvider.of<addcommentCubit>(context).postt;
            if (post != null &&
                post.data != null &&
                post.data!.post!.comments != null) {
              for (int i = 0; i < post.data!.post!.comments!.length; i++) {
                advancePlayers.add(AudioPlayer());
              }
            }

            // if (state is getpostSucceslState) {
            //   final post = state.postmodel.data!.post;
            return post != null && post.data != null && post.data?.post != null
                ? Stack(children: [
                    RefreshIndicator(
                      onRefresh: () async {
                        BlocProvider.of<addcommentCubit>(context)
                            .getpostData(widget.postid!);
                      },
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            CardPost(
                              isteacher: post.data!.post!.isTaecher,
                              avatar: post.data!.post!.avatar,
                              numcomments: post.data!.post!.comments != null
                                  ? post.data!.post!.comments!.length
                                  : 0,
                              studenName: post.data!.post!.ownerName,
                              timeago: post.data!.post!.timeAgo,
                              content: post.data!.post!.content,
                              image: post.data!.post!.image,
                              bookpage: post.data!.post!.bookPage,
                              qnum: post.data!.post!.questionNo,
                              //null safety
                              bookname: post.data!.post!.book != null
                                  ? post.data!.post!.book!.name
                                  : 'no book',
                              teacherreplay: post.data!.post!.teacherReplay,
                              onPressed: () {
                                if (isteacher == true &&
                                    post.data!.post!.isTaecher == 1) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return CustomActionoptin(
                                          contenDelte:
                                              'هل انت متأكد انك تريد حذف البوست',
                                          contenttitleDelete: "حذف البوست",
                                          titleDelete: "حذف البوست",
                                          titleEdit: "تعديل البوست",
                                          onDeleteConfirmed: () {
                                            BlocProvider.of<postCubit>(context)
                                                .deletePost(
                                                    post.data!.post!.id!);
                                            // final studenCubi = context.read<getUserCubit>();

                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                          },
                                          onEdit: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => AddPost(
                                                  bookbage:
                                                      post.data!.post!.bookPage,
                                                  content:
                                                      post.data!.post!.content,
                                                  image: post.data!.post!.image,
                                                  postid: post.data!.post!.id,
                                                  qunm: post
                                                      .data!.post!.questionNo,
                                                  selectedbook:
                                                      post.data!.post!.book!.id,
                                                  groupidpost: post
                                                      .data!.post!.appGroupId,
                                                ),
                                                // Pass the post data here
                                              ),
                                            );
                                          },
                                        );
                                      });
                                } else if (post.data!.post != null &&
                                    post.data!.post!.stid != null &&
                                    prefs!.getInt("stid") ==
                                        post.data!.post!.stid) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return CustomActionoptin(
                                          contenDelte:
                                              'هل انت متأكد انك تريد حذف البوست',
                                          contenttitleDelete: "حذف البوست",
                                          titleDelete: "حذف البوست",
                                          titleEdit: "تعديل البوست",
                                          onDeleteConfirmed: () {
                                            BlocProvider.of<postCubit>(context)
                                                .deletePost(
                                                    post.data!.post!.id!);
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                            // final studenCubi = context.read<getUserCubit>();
                                          },
                                          onEdit: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => AddPost(
                                                  bookbage:
                                                      post.data!.post!.bookPage,
                                                  content:
                                                      post.data!.post!.content,
                                                  image: post.data!.post!.image,
                                                  postid: post.data!.post!.id,
                                                  qunm: post
                                                      .data!.post!.questionNo,
                                                  selectedbook:
                                                      post.data!.post!.book!.id,
                                                  groupidpost: post
                                                      .data!.post!.appGroupId,
                                                ),
                                                // Pass the post data here
                                              ),
                                            );
                                          },
                                        );
                                      });
                                } else if (isteacher == true &&
                                    post.data!.post!.isTaecher == 0) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return CustomActionoptin(
                                          contenDelte:
                                              'هل انت متأكد انك تريد حذف البوست',
                                          contenttitleDelete: "حذف البوست",
                                          titleDelete: "حذف البوست",
                                          onDeleteConfirmed: () {
                                            BlocProvider.of<postCubit>(context)
                                                .deletePost(
                                                    post.data!.post!.id!);
                                            // final studenCubi = context.read<getUserCubit>();

                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                          },
                                        );
                                      });
                                }
                              },
                            ),
                            post.data!.post!.comments != null &&
                                    post.data!.post!.comments!.isNotEmpty
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        post.data!.post!.comments?.length,
                                    itemBuilder: (context, index) {
                                      return CommentCard(
                                        st_name: post.data!.post!
                                            .comments?[index].ownerNamecomm,
                                        comment: post.data!.post!
                                            .comments?[index].content,
                                        image: post
                                            .data!.post!.comments?[index].image,
                                        avatar: post.data!.post!
                                            .comments?[index].avatar,
                                        advanceplayer: advancePlayers[index],
                                        record: post.data!.post!
                                            .comments?[index].record,
                                        timeago: post.data!.post!
                                            .comments?[index].timeAgo,
                                        onLongPress: () {
                                          if (isteacher == false &&
                                              (post.data!.post != null &&
                                                  post.data!.post!.comments !=
                                                      null &&
                                                  post
                                                          .data!
                                                          .post!
                                                          .comments?[index]
                                                          .stId !=
                                                      null &&
                                                  prefs!.getInt("stid") ==
                                                      post
                                                          .data!
                                                          .post!
                                                          .comments![index]
                                                          .stId)) {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return CustomActionoptin(
                                                    contenDelte:
                                                        'هل انت متأكد انك تريد حذف التعليق',
                                                    contenttitleDelete:
                                                        "حذف التعليق",
                                                    titleDelete: "حذف التعليق",
                                                    onDeleteConfirmed: () {
                                                      BlocProvider.of<
                                                                  addcommentCubit>(
                                                              context)
                                                          .deleteComment(post
                                                              .data!
                                                              .post!
                                                              .comments![index]
                                                              .id!);
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  );
                                                });
                                          } else if (isteacher == true) {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return CustomActionoptin(
                                                    contenDelte:
                                                        'هل انت متأكد انك تريد حذف التعليق',
                                                    contenttitleDelete:
                                                        "حذف التعليق",
                                                    titleDelete: "حذف التعليق",
                                                    onDeleteConfirmed: () {
                                                      BlocProvider.of<
                                                                  addcommentCubit>(
                                                              context)
                                                          .deleteComment(post
                                                              .data!
                                                              .post!
                                                              .comments![index]
                                                              .id!);
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  );
                                                });
                                          }
                                        },
                                      );
                                    },
                                  )
                                : const Center(
                                    child: Text(
                                      'لا توجد تعليقات بعد.',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                            const SizedBox(
                              height: 400,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 90,
                      right: 0,
                      child: _imageFile != null
                          ? Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: FileImage(_imageFile!),
                                  )),
                              height: 100,
                              width: 70,
                            )
                          : Container(),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height * .01,
                            horizontal:
                                MediaQuery.of(context).size.width * .025),
                        child: Form(
                          key: formstate,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  /*   */

                                  Expanded(
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Row(
                                        children: [
                                          IconButton(
                                            onPressed: () async {
                                              await startRecord();

                                              setState(() {});

                                              showBottomSheet(
                                                enableDrag: false,
                                                constraints: BoxConstraints
                                                    .tightForFinite(),
                                                context: context,
                                                // ignore: sized_box_for_whitespace
                                                builder: (context) =>
                                                    WillPopScope(
                                                  onWillPop: () async {
                                                    await stopRecorder(); // Stop recording when back button is pressed
                                                    return true; // Allow the BottomSheet to close
                                                  },
                                                  child: Container(
                                                    height: 130,
                                                    width: double.infinity,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Icon(Icons.mic),
                                                        StreamBuilder<
                                                            RecordingDisposition>(
                                                          builder: (context,
                                                              snapshot) {
                                                            final duration =
                                                                snapshot.hasData
                                                                    ? snapshot
                                                                        .data!
                                                                        .duration
                                                                    : Duration
                                                                        .zero;

                                                            String twoDigits(
                                                                    int n) =>
                                                                n
                                                                    .toString()
                                                                    .padLeft(
                                                                        2, '0');

                                                            final twoDigitMinutes =
                                                                twoDigits(duration
                                                                    .inMinutes
                                                                    .remainder(
                                                                        60));
                                                            final twoDigitSeconds =
                                                                twoDigits(duration
                                                                    .inSeconds
                                                                    .remainder(
                                                                        60));

                                                            return Text(
                                                              '$twoDigitMinutes:$twoDigitSeconds',
                                                              style:
                                                                  const TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        230,
                                                                        148,
                                                                        148),
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            );
                                                          },
                                                          stream: recorder
                                                              .onProgress,
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            ElevatedButton(
                                                              style: ButtonStyle(
                                                                  backgroundColor:
                                                                      MaterialStatePropertyAll(
                                                                          Colors
                                                                              .green)),
                                                              child: const Text(
                                                                  "ارسال"),
                                                              onPressed:
                                                                  () async {
                                                                await stopRecorder();
                                                                Navigator.pop(
                                                                    context);
                                                                await BlocProvider.of<
                                                                            addcommentCubit>(
                                                                        context)
                                                                    .addRecord(
                                                                        widget
                                                                            .postid!,
                                                                        file);
                                                                setState(() {
                                                                  file = null;
                                                                });
                                                                print(
                                                                    "mmmmmmmmmmmmmmm $file");
                                                              },
                                                            ),
                                                            ElevatedButton(
                                                              style: ButtonStyle(
                                                                  backgroundColor:
                                                                      MaterialStatePropertyAll(
                                                                          Colors
                                                                              .red)),
                                                              child: const Text(
                                                                  "الغاء"),
                                                              onPressed:
                                                                  () async {
                                                                await stopRecorder();
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );

                                              /*  */
                                            },
                                            icon: const Icon(
                                              FontAwesomeIcons.microphone,
                                              color: Colors.blue,
                                            ),
                                          ),

                                          Expanded(
                                            child: TextFormField(
                                              //     mouseCursor: MouseCursorManager(fallbackMouseCursor),
                                              textDirection: TextDirection.rtl,
                                              validator: (val) {
                                                return Validator()
                                                    .Emptyvalidate(val!);
                                              },
                                              controller: _commentController,
                                              // controller: _textController,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              minLines: 1,
                                              maxLines: 2,
                                              onTap: () {},
                                              decoration: const InputDecoration(
                                                  hintText: 'اكتب تعليق...',
                                                  hintStyle: TextStyle(
                                                      color: Colors.blueAccent),
                                                  border: InputBorder.none),
                                            ),
                                          ),

                                          //pick image from gallery button
                                          IconButton(
                                              onPressed: () async {
                                                _pickImage(
                                                  ImageSource.gallery,
                                                );
                                                // uploading & sending image one by one
                                              },
                                              icon: const Icon(Icons.image,
                                                  color: Colors.blueAccent,
                                                  size: 26)),

                                          //take image from camera button
                                          IconButton(
                                              onPressed: () async {
                                                _pickImage(
                                                  ImageSource.camera,
                                                );
                                              },
                                              icon: const Icon(
                                                  Icons.camera_alt_rounded,
                                                  color: Colors.blueAccent,
                                                  size: 26)),

                                          //adding some space
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .02),
                                        ],
                                      ),
                                    ),
                                  ),

                                  //send message button
                                  MaterialButton(
                                    onPressed: () async {
                                      String comment =
                                          _commentController.text.trim();
                                      if (_imageFile != null ||
                                          comment.isNotEmpty) {
                                        BlocProvider.of<addcommentCubit>(
                                                context)
                                            .addcomment(post.data!.post!.id!,
                                                comment, _imageFile);
                                        setState(() {
                                          _imageFile = null;
                                        });
                                        _commentController.clear();
                                      } else {
                                        showSnackbar(
                                            context: context,
                                            message: "ضع تعليق او صورة");
                                      }
                                    },
                                    minWidth: 0,
                                    padding: const EdgeInsets.only(
                                        top: 10,
                                        bottom: 10,
                                        right: 5,
                                        left: 10),
                                    shape: const CircleBorder(),
                                    color: Colors.green,
                                    child: const Icon(Icons.send,
                                        color: Colors.white, size: 28),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      /* Container(
                  height: 90,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 130, 128, 128),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Form(
                    key: formstate,
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        IconButton(
                          color: Colors.red,
                          onPressed: () async {
                            String comment = _commentController.text.trim();
                            if (comment.isNotEmpty) {
                              BlocProvider.of<addcommentCubit>(context)
                                  .addcomment(comment, post.id!, _imageFile!);
                              _commentController.clear();
                            } else {
                              showSnackbar(
                                  context: context,
                                  message: 'لا يمكن إرسال تعليق فارغ.');
                              // Show a SnackBar with an error message
                            }
                          },
                          icon: Icon(Icons.send),
                        ),
                        IconButton(
                          color: Colors.blue,
                          onPressed: () {},
                          icon: Icon(FontAwesomeIcons.microphone),
                        ),
                        IconButton(
                          color: Colors.blue,
                          onPressed: () {
                            _pickImage(
                              ImageSource.gallery,
                            );
                          },
                          icon: Icon(FontAwesomeIcons.image),
                        ),
                        Container(
                          width: 200,
                          child: TextFormField(
                            validator: (val) {
                              return Validator().Emptyvalidate(val!);
                            },
                            textInputAction: TextInputAction.newline,
                            textDirection: TextDirection.rtl,
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            controller: _commentController,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              hintText: "اكتب تعليق",
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),*/
                    ),
                  ])
                : Center(
                    child: Text(
                    "البوست غير موجود ربما تم حذفه",
                    style: TextStyle(fontSize: 15),
                  ));
          } else if (state is getpostFailure) {
            return errrowidget(erromessage: '${state.erro}');
          } else {
            return SpinKitSpinningLines(
              color: Color.fromARGB(255, 5, 52, 239),
              duration: Duration(milliseconds: 1000),
            );
          }
        }));
  }
}
