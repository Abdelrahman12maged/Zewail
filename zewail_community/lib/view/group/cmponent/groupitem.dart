import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../Controller/groups/Cubit/cubit.dart';
import '../../../Controller/groups/Cubit/states.dart';
import '../../../Core/Constant/LoadingIndic.dart';
import '../../../Core/errors/Customerrowidget.dart';
import '../../../data/models/Groups_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../PostsAndUsers/componentPosts/fullscreen.dart';

class BoxItems extends StatelessWidget {
  const BoxItems({
    super.key,
    required this.image,
    required this.name,
    required this.teacherName,
  });
  final String? image;
  final String? name;
  final String? teacherName;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: "${image}",
        placeholder: (context, url) =>
            Center(child: CircularProgressIndicator()),
        imageBuilder: (context, imageProvider) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                image: image == null || image!.isEmpty
                    ? DecorationImage(image: AssetImage("assets/logof.png"))
                    : DecorationImage(image: imageProvider, fit: BoxFit.cover)),
            child: DefaultTextStyle(
                style: TextStyle(color: Colors.white, fontSize: 30),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          borderRadius: BorderRadius.circular(40)),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 200,
                            child: name == null
                                ? Text(
                                    "غير موجودة",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Text(
                                    '${name}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                          ),
                          teacherName == null
                              ? Text(
                                  textDirection: TextDirection.rtl,
                                  "",
                                  style: TextStyle(fontSize: 20),
                                )
                              : Text(
                                  textDirection: TextDirection.rtl,
                                  '${teacherName}',
                                  style: TextStyle(fontSize: 20),
                                ),
                        ],
                      ),
                    )
                  ],
                )),
          );
        });
  }
}
