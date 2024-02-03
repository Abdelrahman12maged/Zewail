import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../PostsAndUsers/HomePage.dart';
import '../../Controller/groups/Cubit/cubit.dart';
import '../../Controller/login/cubit/cubit.dart';
import '../../Controller/login/cubit/states.dart';
import '../../Core/Constant/constants.dart';
import '../../Core/Function/Api.dart';
import '../../Core/Function/validation.dart';
import '../../data/repo/Authrepoimpliment.dart';

import 'component/customcomponent.dart';
import '../group/Groups.dart';

import '../../Core/Constant/links.dart';
import '../../main.dart';
import '../group/GroupsTeacher.dart';

class LoginTeacher extends StatefulWidget {
  @override
  State<LoginTeacher> createState() => _LoginTeacherState();
}

class _LoginTeacherState extends State<LoginTeacher> {
  TextEditingController password = TextEditingController();

  TextEditingController studntNumber = TextEditingController();

  GlobalKey<FormState> formstate = GlobalKey();

  bool isloading = false;

  bool isChecked = false;
  // final firbasemessag = FirebaseMessaging.instance;
  bool isShowpass = true;
/*  void fetchFCMToken() async {
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
        print("FCM Token: $fcmToken");
      }

      if (fcmToken != null) {
        await sendfcmtoken(fcmToken);
      }
      print(fcmToken);
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
            "$baseurl/student/updateDeviceToken?token=${prefs!.getString("token")}",
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
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LoginCubit(AuthRepoim(Apiservice(Dio()))),
        child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) {
            if (state is LoginTeacherLoadinglState) {
              isloading = true;
            } else if (state is LoginTeacherSucceslState) {
              if (state.teacherdata.accessToken != null) {
                prefs!.setString("token", state.teacherdata.accessToken!);
              }
              print(prefs!.getString("token"));
              //     fetchFCMToken();
              prefs!.setInt("teacherid", state.teacherdata.teacher!.tId!);
              prefs!
                  .setString("teachername", state.teacherdata.teacher!.tName!);

              prefs!.setBool("ist", state.teacherdata.isTeacher!);
              if (state.teacherdata.teacher!.profile != null) {
                prefs!
                    .setString("profilet", state.teacherdata.teacher!.profile!);
              }

              showSnackbar(
                  context: context,
                  message: "تم تسجيل الدخول بنجاح",
                  color: Colors.green,
                  colorback: Colors.blue[50]);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
                (route) => false,
              );
              isloading = false;
            } else if (state is LoginTeacherErrorState) {
              isloading = false;
              showSnackbar(
                  context: context, message: 'حدث خطأ تأكد من الرقم والباسورد');
            }
          },
          builder: (context, state) {
            if (state is CheckBoxToggled) {
              isChecked = state.isChecked;
            }
            return Scaffold(
              appBar: AppBar(
                backgroundColor: MyColors.kPrimaryColor,
              ),
              backgroundColor: MyColors.kPrimaryColor,
              body: Column(
                children: [
                  Container(
                    height: 150,
                    child: Stack(
                      children: [
                        Center(
                          child: Text(
                            "Zewail",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                              decorationStyle: TextDecorationStyle.wavy,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: MyColors.kBackgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: containerRadius,
                          topRight: containerRadius,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          children: [
                            Center(
                              child: Text(
                                "(للمدرسين فقط) سجل الدخول الأن بحسابك",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 12, 119, 206)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: Form(
                                key: formstate,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    SizedBox(height: 40),
                                    defaultTextform(
                                      validator: (val) {
                                        return Validator().numvalidate(val!);
                                      },
                                      controller: studntNumber,
                                      ontap: () {},
                                      type: TextInputType.number,
                                      label: 'الهاتف',
                                      prefix: Icons.phone,
                                      colorenable:
                                          Color.fromARGB(255, 19, 110, 152),
                                      colorfocus: Colors.white,
                                    ),
                                    SizedBox(height: 40),
                                    defaultTextform(
                                      obsecure: isShowpass,
                                      onpresedIcon: () {
                                        if (isShowpass == false) {
                                          setState(() {
                                            isShowpass = true;
                                          });
                                        } else {
                                          setState(() {
                                            isShowpass = false;
                                          });
                                        }
                                      },
                                      validator: (val) {
                                        return Validator().passvalidate(val!);
                                      },
                                      controller: password,
                                      type: TextInputType.text,
                                      label: 'كلمة السر',
                                      prefix: isShowpass
                                          ? FontAwesomeIcons.eyeSlash
                                          : FontAwesomeIcons.eye,
                                      sufix: Icon(Icons.lock,
                                          color: Color.fromARGB(
                                              255, 31, 101, 240)),
                                      colorenable:
                                          Color.fromARGB(255, 19, 110, 152),
                                      colorfocus: Colors.white,
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "أوافق على الشروط والأحكام",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        Checkbox(
                                          value: isChecked,
                                          onChanged: (bool? value) {
                                            context
                                                .read<LoginCubit>()
                                                .toggleCheckBox(value ?? false);
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        if (formstate.currentState!
                                            .validate()) {
                                          await BlocProvider.of<LoginCubit>(
                                                  context)
                                              .LoginTeacher(studntNumber.text,
                                                  password.text);
                                        } else {}
                                      },
                                      child: isloading
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Text(
                                                  'جار التحميل...',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                CircularProgressIndicator(
                                                  color: Colors.white,
                                                ),
                                              ],
                                            )
                                          : const Text(
                                              'دخول',
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  color: Colors.white),
                                            ),
                                      style: ElevatedButton.styleFrom(
                                          fixedSize:
                                              const Size(double.maxFinite, 53),
                                          backgroundColor:
                                              MyColors.kPrimaryColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
