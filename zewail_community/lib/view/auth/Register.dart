import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../Core/Constant/constants.dart';
import '../../Core/Function/Api.dart';
import '../../Core/Function/validation.dart';
import 'Login.dart';
import 'component/customcomponent.dart';

import '../../Controller/login/cubit/cubit.dart';
import '../../Controller/login/cubit/states.dart';
import '../../data/repo/Authrepoimpliment.dart';
import '../../Core/Function/AlertExit.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isMaleSelected = false;
  bool isFemaleSelected = false;
  bool isAgree = false;
  TextEditingController studentName = TextEditingController();
  TextEditingController studntNumber = TextEditingController();
  TextEditingController fathernumber = TextEditingController();
  TextEditingController fatherName = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpasscontroller = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey();
  bool isShowpass = true;
  bool isShowconfirmpass = true;
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LoginCubit(AuthRepoim(Apiservice(Dio()))),
        child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) {
            if (state is RegisterLoadinglState) {
              isloading = true;
            } else if (state is RegisterSucceslState) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Login(
                          phone: studntNumber.text,
                        )),
              );

              isloading = false;
              AwesomeDialog(
                autoHide: Duration(seconds: 5),

                context: context,
                dialogType: DialogType.success,
                //  animType: AnimType.rightSlide,
                title: 'تم التسجيل بنجاح سجل دخول الان',
              )..show();
              FocusScope.of(context).unfocus();
            } else if (state is RegisterErrorState) {
              isloading = false;
              showSnackbar(
                  context: context,
                  message: '${state.error['error']['st_mobile'][0]}');
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: MyColors.kPrimaryColor,
                title: Center(
                  child: Text(
                    "سجل الأن",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                      decorationStyle: TextDecorationStyle.wavy,
                    ),
                  ),
                ),
              ),
              backgroundColor: MyColors.kPrimaryColor,
              body: Column(
                textDirection: TextDirection.rtl,
                children: [
                  //First let's create the Story time line container
                  Container(
                    height: 20,
                    child: Stack(
                      children: [
                        //    Image.asset(
                        //      "assets/logo.png",
                        //      height: 100,
                        //      color: Colors.lightBlueAccent,
                        //    ),
                      ],
                    ),
                  ),

                  //Now let's create our chat timeline
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 220, 212, 212),
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
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: Form(
                                key: formstate,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    //  Text(
                                    //    "التسجيل",
                                    //      style: TextStyle(fontSize: 30),
                                    //     ),
                                    SizedBox(height: 15),
                                    defaultTextform(
                                      controller: studentName,
                                      validator: (val) {
                                        return Validator().namevalidate(val!);
                                      },
                                      ontap: () {},
                                      type: TextInputType.name,
                                      label: 'اسم الطالب',
                                      prefix: Icons.person,
                                      colorenable:
                                          Color.fromARGB(255, 19, 110, 152),
                                      colorfocus: Colors.white,
                                    ),
                                    SizedBox(height: 15),
                                    defaultTextform(
                                      controller: studntNumber,
                                      validator: (val) {
                                        return Validator().numvalidate(val!);
                                      },
                                      ontap: () {},
                                      type: TextInputType.number,
                                      label: 'رقم الطالب',
                                      prefix: Icons.phone,
                                      colorenable:
                                          Color.fromARGB(255, 19, 110, 152),
                                      colorfocus: Colors.white,
                                    ),
                                    SizedBox(height: 15),
                                    defaultTextform(
                                      controller: fatherName,
                                      validator: (val) {
                                        return Validator().namevalidate(val!);
                                      },
                                      ontap: () {},
                                      type: TextInputType.name,
                                      label: 'اسم ولي الامر',
                                      prefix: Icons.person,
                                      colorenable:
                                          Color.fromARGB(255, 19, 110, 152),
                                      colorfocus: Colors.white,
                                    ),

                                    SizedBox(height: 15),
                                    defaultTextform(
                                      controller: fathernumber,
                                      validator: (val) {
                                        return Validator().numvalidate(val!);
                                      },
                                      ontap: () {},
                                      type: TextInputType.number,
                                      label: 'رقم ولي الأمر',
                                      prefix: Icons.phone,
                                      colorenable:
                                          Color.fromARGB(255, 19, 110, 152),
                                      colorfocus: Colors.white,
                                    ),
                                    SizedBox(height: 15),
                                    defaultTextform(
                                      controller: address,
                                      validator: (val) {
                                        return Validator().Emptyvalidate(val!);
                                      },
                                      ontap: () {},
                                      type: TextInputType.text,
                                      label: 'العنوان',
                                      prefix: Icons.home,
                                      colorenable:
                                          Color.fromARGB(255, 19, 110, 152),
                                      colorfocus: Colors.white,
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          children: [
                                            Text('ذكر',
                                                textDirection:
                                                    TextDirection.rtl),
                                            Checkbox(
                                              value: isMaleSelected,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  isMaleSelected = value!;
                                                  print("i am male$value");
                                                  if (isMaleSelected) {
                                                    isFemaleSelected = false;
                                                  }
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text('أنثي',
                                                textDirection:
                                                    TextDirection.rtl),
                                            Checkbox(
                                              value: isFemaleSelected,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  isFemaleSelected = value!;
                                                  print("i am female$value");
                                                  if (isFemaleSelected) {
                                                    isMaleSelected = false;
                                                  }
                                                });
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    defaultTextform(
                                      controller: passwordcontroller,
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
                                      ontap: () {},
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
                                    SizedBox(height: 15),
                                    defaultTextform(
                                      controller: confirmpasscontroller,
                                      obsecure: isShowconfirmpass,
                                      onpresedIcon: () {
                                        if (isShowconfirmpass == false) {
                                          setState(() {
                                            isShowconfirmpass = true;
                                          });
                                        } else {
                                          setState(() {
                                            isShowconfirmpass = false;
                                          });
                                        }
                                      },
                                      validator: (val) {
                                        return Validator().passvalidate(val!);
                                      },
                                      ontap: () {},
                                      type: TextInputType.text,
                                      label: 'تأكيد كلمة السر',
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
                                      height: 15,
                                    ),
                                    Center(
                                      child: Row(
                                        textDirection: TextDirection.rtl,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Checkbox(
                                            value: isAgree,
                                            onChanged: (value) {
                                              setState(() {
                                                isAgree = value!;
                                              });
                                            },
                                          ),
                                          Text("أوافق على الشروط والأحكام"),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        if (formstate.currentState!
                                            .validate()) {
                                          if ((isMaleSelected &&
                                                      !isFemaleSelected ||
                                                  isFemaleSelected &&
                                                      !isMaleSelected) &&
                                              isAgree) {
                                            if (confirmpasscontroller.text ==
                                                passwordcontroller.text) {
                                              await BlocProvider.of<LoginCubit>(
                                                      context)
                                                  .register(
                                                      studntNumber.text,
                                                      passwordcontroller.text,
                                                      studentName.text,
                                                      isMaleSelected
                                                          ? "male"
                                                          : "female",
                                                      fatherName.text,
                                                      fathernumber.text,
                                                      address.text);
                                            } else {
                                              showSnackbar(
                                                  context: context,
                                                  message:
                                                      "كلمة السر غير متطابقة");
                                            }
                                          } else {
                                            showSnackbar(
                                                context: context,
                                                message:
                                                    "خطأ تأكد من اختيار الجنس والموافقة عل الشروط");
                                          }
                                        }
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
                                              'تسجيل',
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
                                      height: 15,
                                    ),
                                    /* Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          child: Text(
                                            "سجل الدخول",
                                            style: TextStyle(
                                                fontSize: 22,
                                                color: Colors.blue),
                                          ),
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, "homelogin");
                                          },
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          " لديك حساب بالفعل",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ],
                                    ), */
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
