import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Controller/CheckStudentExist.dart/Cubit.dart';
import '../../Controller/CheckStudentExist.dart/States.dart';
import '../../Core/Constant/constants.dart';
import 'Login.dart';
import 'Register.dart';

import '../../Core/Function/Api.dart';
import '../../Core/Function/validation.dart';
import '../../Core/Function/validation.dart';
import '../../Core/Function/validation.dart';
import '../../data/repo/Authrepoimpliment.dart';

class Welcome extends StatefulWidget {
  Welcome({Key? key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  GlobalKey<FormState> formstate = GlobalKey();
  bool isloading = false;
  final TextEditingController studntNumber = TextEditingController();
  @override
  void dispose() {
    void dispose() {
      studntNumber.dispose();
      super.dispose();
    }

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckECubit(AuthRepoim(Apiservice(Dio()))),
      child: BlocConsumer<CheckECubit, checkEsixtStates>(
        listener: (context, state) {
          if (state is checkExistLoadinglState) {
            isloading = true;
          } else if (state is checkExistSucceslState) {
            if (state.isExist == true) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Login(
                          phone: studntNumber.text,
                        )),
              );

              AwesomeDialog(
                autoHide: Duration(seconds: 7),

                context: context,
                dialogType: DialogType.success,
                //  animType: AnimType.rightSlide,
                title: 'لديك حساب بالفعل قم بكتابة الباسورد وسجل الدخول',
              )..show();
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Register()),
              );

              AwesomeDialog(
                autoHide: Duration(seconds: 7),

                context: context,
                dialogType: DialogType.info,
                //  animType: AnimType.rightSlide,
                title: 'ليس لديك حساب قم بأنشاء حساب ثم سجل الدخول',
              )..show();
            }
            isloading = false;
          } else if (state is checkExistErrorState) {
            isloading = false;

            showSnackbar(context: context, message: 'حدث خطأ تأكد من الرقم ');
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Color(0xfff7f6fb),
            body: ListView(children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 18,
                    ),
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        'assets/welcome.png',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      '(طلاب فقط)',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "ادخل رقم الهاتف اذا كان لديك حساب في منصة روزويل سيتم توجيهك مباشرة الي صفحة تسجيل الدخول ادخل بها رقم الهاتف وكلمة السر الخاصة بالمنصة وسيتم الدخول مباشرة واذا لم يكن الرقم غير مسجل بالمنصة روزويل سيتم توجيهك الي صفحة انشاء الحساب ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 28,
                    ),
                    Container(
                      padding: EdgeInsets.all(28),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Form(
                        key: formstate,
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (value) {
                                return Validator().numvalidate(value!);
                              },
                              onChanged: (value) {
                                setState(() {
                                  studntNumber.text = value;
                                });
                              },
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black12),
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black12),
                                    borderRadius: BorderRadius.circular(10)),
                                prefix: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    '(+20)',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                suffixIcon: studntNumber.text.length == 11
                                    ? Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                        size: 32,
                                      )
                                    : Icon(
                                        Icons.check_circle,
                                        color: Color.fromARGB(255, 242, 15, 15),
                                        size: 32,
                                      ),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (formstate.currentState!.validate()) {
                                    BlocProvider.of<CheckECubit>(context)
                                        .checkExist(studntNumber.text);
                                  }
                                  FocusScope.of(context).unfocus();
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
                                            fontSize: 24, color: Colors.white),
                                      ),
                                style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(double.maxFinite, 53),
                                    backgroundColor: MyColors.kPrimaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          );
        },
      ),
    );
  }
}
