import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../Controller/addcomment/cubit.dart';
import '../../Controller/addpost/addpostCubit.dart';
import '../../Controller/addpost/states.dart';
import '../../Controller/booksCubit/Cubit.dart';
import '../../Controller/booksCubit/states.dart';
import '../../Controller/posts/PostCubit.dart';
import '../../Controller/profile/cubit.dart';
import '../../Core/Constant/constants.dart';
import '../../Core/Function/validation.dart';
import '../../Core/errors/Customerrowidget.dart';
import '../../data/models/BooksModel.dart';
import '../../data/models/PostsModel.dart';
import '../../main.dart';
import '../auth/component/customcomponent.dart';
import '../intro/component/custom_buttons.dart';
import 'comments.dart';

class AddPost extends StatefulWidget {
  AddPost(
      {super.key,
      this.groupid,
      this.postid,
      this.bookbage,
      this.content,
      this.image,
      this.groupidpost,
      this.qunm,
      this.selectedbook});
  // PostsModel? post;
  int? postid;
  int? bookbage;
  String? content;
  String? image;
  int? selectedbook;
  String? qunm;
  int? groupidpost;
  /////////////
  int? groupid;
  ////////////
  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  //TextEditingController bookNameController = TextEditingController();
  TextEditingController bookPageController = TextEditingController();
  TextEditingController questionNoController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey();
  bool isloading = false;
  bool? isteacher = prefs!.getBool('ist');
  void dispose() {
    //  bookNameController.dispose();
    bookPageController.dispose();
    questionNoController.dispose();
    contentController.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    if (widget.postid != null) {
      var bookcubit =
          BlocProvider.of<booksCubit>(context).getbooks(widget.groupidpost!);
    } else {
      var bookcubit =
          BlocProvider.of<booksCubit>(context).getbooks(widget.groupid!);
    }
    if (widget.postid != null) {
      // If 'post' is not null, it means we are updating an existing post
      // Set the initial values of the form fields using 'post' data

      selectedBook = widget.selectedbook;

      widget.bookbage != null
          ? bookPageController.text = widget.bookbage.toString()
          : bookPageController.text = 0.toString();
      widget.qunm != null
          ? questionNoController.text = widget.qunm!
          : questionNoController.text = '';
      widget.content != null
          ? contentController.text = widget.content!
          : contentController.text = "";

      // _imageFile = widget.post!.image as File?;
      // You may also set the value of '_imageFile' if 'post.image' is not null
    }
  }

  int? selectedBook;
  File? _imageFile;

  Future<File?> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });

      return _imageFile;
    }

    return null;
  }

  Widget buildBlocWidget() {
    return BlocConsumer<addpostCubit, addpostStates>(
      listener: (context, state) {
        if (state is addPostLoading) {
          isloading = true;
        } else if (state is addPostSuccess) {
          isloading = false;

          showSnackbar(
              context: context,
              message: "${state.msg.msg}",
              color: Colors.green,
              colorback: Colors.blue[50]);

          Navigator.pop(context);
          BlocProvider.of<postCubit>(context).fetchgroupPosts(widget.groupid!);
          if (state.msg.postid != null) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => comments(
                          postid: state.msg.postid,
                        )));
          }
        } else if (state is addPostFailure) {
          isloading = false;

          showSnackbar(context: context, message: "${state.erro}");
        } else if (state is updatePostLoading) {
          isloading = true;
        } else if (state is updatePostSuccess) {
          isloading = false;
          showSnackbar(
              context: context,
              message: "تم تعديل السؤال بنجاح",
              color: Colors.green,
              colorback: Colors.blue[50]);
          Navigator.pop(context);
          Navigator.pop(context);
          BlocProvider.of<postCubit>(context)
              .fetchgroupPosts(widget.groupidpost!);

          if (isteacher == false && prefs!.getInt("stid") != null) {
            BlocProvider.of<getUserCubit>(context)
                .fetchStudentPosts(prefs!.getInt("stid") as int);
          }
          BlocProvider.of<addcommentCubit>(context).getpostData(widget.postid!);
        } else if (state is updatePostFailure) {
          //     setState(() {
          isloading = false;
          //       });
          showSnackbar(context: context, message: "حدث خطأ تأكد من البيانات");
        }
      },
      builder: (context, state) {
        return allpage(context);
      },
    );
  }

  Widget blocbooks() {
    return BlocBuilder<booksCubit, bookStates>(
      builder: (context, state) {
        if (state is BooksSuccesState) {
          final books = BlocProvider.of<booksCubit>(context).bookss;
          return widgtDropdown(books);
        } else if (state is BookFailure) {
          return Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        if (widget.postid != null) {
                          var bookcubit = BlocProvider.of<booksCubit>(context)
                              .getbooks(widget.groupidpost!);
                        } else {
                          var bookcubit = BlocProvider.of<booksCubit>(context)
                              .getbooks(widget.groupid!);
                        }
                      },
                      icon: Icon(
                        Icons.refresh,
                        color: Colors.black,
                        size: 50,
                      )),
                  Text(
                    " تأكد من الاتصال بالانترنت لتحميل الكتب",
                    style: TextStyle(fontSize: 12, color: Colors.red),
                  ),
                ],
              ),
            ],
          );
        }
        return SizedBox(
            height: 60,
            child: Center(
                child: Text(
              " انتظر جار تحميل الكتب",
              style: TextStyle(color: Colors.red, fontSize: 15),
            )));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //  final int groupid = ModalRoute.of(context)!.settings.arguments as int;

    // var bookcubit = BlocProvider.of<addpostCubit>(context).getbooks(groupid);

    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            widget.postid != null ? "تعديل المنشور" : "أضف سؤالك",
            style: TextStyle(fontSize: 30, color: Colors.black),
          )),
          backgroundColor: Color.fromARGB(255, 223, 225, 232),
          // backgroundColor: Color.fromARGB(255, 220, 212, 212),
          //  backgroundColor: Color.fromARGB(255, 34, 56, 69),
        ),
        //  backgroundColor: Color.fromARGB(255, 34, 56, 69),
        //  backgroundColor: Color.fromARGB(255, 220, 212, 212),
        backgroundColor: Color.fromARGB(255, 223, 225, 232),
        body: buildBlocWidget()
        //     } else if (state is BooksFailure) {
        //       return errrowidget(erromessage: state.erro);
        //     }
        //     return Loading();
        //    }
        );
  }

  Widget allpage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: ListView(children: [
        Form(
          key: formstate,
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            SizedBox(
              height: 30,
            ),
            Text(
              "اسم الكتاب",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            blocbooks(),
            /*   defaultTextform(
                    controller: bookNameController,
                    ontap: () {},
                    type: TextInputType.text,
                    label: 'اسم الكتاب',
                    suffix: FontAwesomeIcons.bookBookmark,
                    colorenable: Color.fromARGB(255, 19, 110, 152),
                    colorfocus: Colors.black,
                  ),*/

            Text(
              "رقم الصفحة",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            defaultTextform(
              validator: (val) {
                return Validator().Emptyvalidate(val!);
              },
              controller: bookPageController,
              ontap: () {},
              type: TextInputType.number,
              label: "رقم الصفحة",
              prefix: FontAwesomeIcons.bookOpen,
              colorenable: Color.fromARGB(255, 19, 110, 152),
              colorfocus: Colors.black,
            ),
            Text(
              "رقم السؤال",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            defaultTextform(
              validator: (val) {
                return Validator().Emptyvalidate(val!);
              },
              controller: questionNoController,
              ontap: () {},
              type: TextInputType.text,
              label: "رقم السؤال",
              prefix: FontAwesomeIcons.question,
              colorenable: Color.fromARGB(255, 19, 110, 152),
              colorfocus: Colors.black,
            ),
            Center(
                child: Text(
              "النص",
              style: TextStyle(color: Colors.black, fontSize: 20),
            )),
            TextFormField(
              controller: contentController,
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                hintText: "اضف سؤالك",
                hintTextDirection: TextDirection.rtl,
                fillColor: Colors.white,
                filled: true,
                label: Text(
                  "النص",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 19, 110, 152),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10)),
              ),
              minLines: 1,
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              onSaved: (value) {},
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              textDirection: TextDirection.rtl,
              children: [
                IconButton(
                  color: Colors.blue,
                  onPressed: () {
                    _pickImage(
                      ImageSource.gallery,
                    );
                  },
                  icon: Icon(
                    FontAwesomeIcons.image,
                    size: 40,
                  ),
                ),
                Text("المعرض"),
                SizedBox(
                  width: 40,
                ),
                IconButton(
                    onPressed: () async {
                      _pickImage(
                        ImageSource.camera,
                      );
                    },
                    icon: const Icon(Icons.camera_alt_rounded,
                        color: Colors.blueAccent, size: 40)),
                Text("الكامير"),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            _imageFile != null
                ? Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: FileImage(_imageFile!),
                        )),
                    height: 400,
                    width: MediaQuery.of(context).size.width,
                  )
                : Container(),
            widget.postid != null && widget.image != null && _imageFile == null
                ? Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: NetworkImage(widget.image!))),
                    height: 400,
                    width: MediaQuery.of(context).size.width,
                  )
                : Container(),
            SizedBox(
              height: 10,
            ),
            Center(
              child: PrimaryButton(
                isloading: isloading,
                onTap: () async {
                  if (formstate.currentState!.validate()) {
                    if (_imageFile != null ||
                        contentController.text.trim().isNotEmpty ||
                        (widget.postid != null &&
                            widget.image != null &&
                            _imageFile == null)) {
                      if (widget.postid != null) {
                        // If 'post' is not null, it means we are updating an existing post
                        await BlocProvider.of<addpostCubit>(context).updatpost(
                          selectedBook!,
                          bookPageController.text,
                          questionNoController.text,
                          contentController.text,
                          // widget.groupid!,
                          widget.postid!,
                          _imageFile,
                        );
                      } else {
                        // If 'post' is null, it means we are adding a new post
                        await BlocProvider.of<addpostCubit>(context).addPosts(
                          selectedBook!,
                          bookPageController.text,
                          questionNoController.text,
                          contentController.text,
                          widget.groupid!,
                          _imageFile,
                        );
                      }
                    } else {
                      showSnackbar(context: context, message: "ضع نص او صورة");
                    }
                  }
                },
                text: widget.postid != null ? "حدّث" : "ارسل",
              ),
            ),
            SizedBox(
              height: 15,
            )
          ]),
        ),
      ]),
    );
  }

  Widget widgtDropdown(BooksModel? books) {
    return DropdownButtonFormField<int>(
      validator: (val) {
        if (selectedBook != null) {
          return null;
        }
        return "اختر كتابا";
      },
      decoration: InputDecoration(
        hintText: "اختر كتابا",
        hintTextDirection: TextDirection.rtl,
        fillColor: Colors.white,
        filled: true,
        label: Text(
          "اسم الكتاب",
          textDirection: TextDirection.rtl,
          style: TextStyle(fontSize: 22, color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 19, 110, 152),
          ),
        ),
        suffixIcon: IconButton(
          onPressed: () {},
          icon: Icon(
            color: Color.fromARGB(255, 31, 101, 240),
            FontAwesomeIcons.bookBookmark,
          ),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(10)),
        // تفاصيل الزخرفة هنا
      ),
      value: selectedBook,
      items: books?.data?.books?.map((book) {
        return DropdownMenuItem<int>(
          value: book.id,
          child: Text("${book.name}"),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedBook = value as int;
        });
      },
    );
  }
}
