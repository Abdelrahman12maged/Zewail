import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import '../../../Core/Constant/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../data/models/PostDatamodel.dart';
import '../../../data/models/PostsModel.dart';
import '../../../main.dart';
import 'Alert.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'fullscreen.dart';

class CardPost extends StatelessWidget {
  CardPost(
      {super.key,
      this.isteacher,
      required this.content,
      this.image,
      this.ontapcomment,
      required this.studenName,
      required this.timeago,
      this.numcomments,
      this.ontapIconcomment,
      this.bookname,
      this.bookpage,
      this.qnum,
      this.avatar,
      this.teacherreplay,
      this.onPressed});
  final String? content;
  final String? image;
  int? isteacher;
  void Function()? ontapcomment;
  void Function()? ontapIconcomment;
  final String? studenName;
  final String? timeago;
  final int? numcomments;
  final String? bookname;
  final String? avatar;
  final int? bookpage;
  final String? qnum;
  final bool? teacherreplay;
  void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Stack(
        children: [
          Card(
            color: Color.fromARGB(255, 250, 247, 247),
            // color: Color.fromARGB(255, 147, 143, 143),
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Color.fromARGB(255, 244, 239, 239)),
            ), // OutlineInputBorder(
            //  borderRadius: BorderRadius.circular(15),
            //  ),

            //  color: MyColors.kBackgroundColor,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 20.0,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                textDirection: TextDirection.rtl,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    textDirection: TextDirection.rtl,
                    children: [
                      avatar == null || avatar == ""
                          ? CircleAvatar()
                          : CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage("$avatar")),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                          child: Column(
                        textDirection: TextDirection.rtl,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          studenName == null || studenName == ""
                              ? Text("not found")
                              : Text("$studenName ",
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      height: 1.5)),
                          Text(
                            "$timeago",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      )),
                      isteacher == 1 && isteacher != null
                          ? Icon(
                              Icons.check_circle_sharp,
                              color: Colors.blue,
                              size: 27,
                            )
                          : Container(),
                      IconButton(
                          onPressed: onPressed,
                          icon: Icon(FontAwesomeIcons.ellipsis)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      width: double.infinity,
                      height: 1.0,
                      color: Colors.grey[400],
                    ),
                  ),
                  content == null || content == ""
                      ? Text("")
                      : SelectableText(
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                          textDirection: TextDirection.rtl,
                          "$content",
                        ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Row(
                        textDirection: TextDirection.rtl,
                        children: [
                          Icon(
                            Icons.book,
                            color: Colors.blue,
                            size: 12,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          bookname == null || bookname == ""
                              ? Text(
                                  ' no name',
                                )
                              : Text("$bookname",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Row(
                        textDirection: TextDirection.rtl,
                        children: [
                          Icon(
                            FontAwesomeIcons.bookOpen,
                            color: Colors.blue,
                            size: 10,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          bookpage == null
                              ? Text('no page')
                              : Text("${bookpage.toString()}",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Row(
                        textDirection: TextDirection.rtl,
                        children: [
                          Icon(
                            FontAwesomeIcons.question,
                            color: Colors.blue,
                            size: 12,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          qnum == null || qnum == ""
                              ? Text('no numQ')
                              : Text("$qnum",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold)),
                        ],
                      )
                    ],
                  ),
                  image == null || image == "" || image == "-"
                      ? Container()
                      : CachedNetworkImage(
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator()),
                          imageUrl: "$image",
                          imageBuilder: (context, imageProvider) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FullScreenImagePage(
                                        imageUrl: image as String),
                                  ),
                                );
                              },
                              child: Container(
                                height: 200,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.0),
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.fill)),
                              ),
                            );
                          },
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: InkWell(
                              onTap: ontapIconcomment,
                              child: Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.commentDots,
                                    size: 20.0,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  numcomments != null
                                      ? Text("${numcomments.toString()}")
                                      : Text("0")
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: InkWell(
                              onTap: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(thickness: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: ontapcomment,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Color.fromARGB(255, 234, 230, 218)),
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  ".....اكتب تعليق",
                                  style: TextStyle(fontSize: 16, height: 1.3),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      //      Text(
                      //         "أعجبني",
                      //         style: TextStyle(
                      //            fontSize: 17,
                      //            fontWeight: FontWeight.bold,
                      ///            height: 1.3),
                      //  )
                    ],
                  )
                ],
              ),
            ),
          ),
          teacherreplay != null && teacherreplay == true
              ? Positioned(
                  top: 15,
                  right: -15,
                  child: Transform.rotate(
                    angle: 0.785398, // الزاوية المائلة بالراديان (45 درجة)
                    child: Container(
                        child: Text(
                          "تمت الاجابة",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        width: 70,
                        color: Colors.green, // لون الشريط
                        height: 16 // ارتفاع الشريط
                        ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
