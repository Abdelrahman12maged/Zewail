import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repo/Authrepo.dart';
//import 'package:get/get.dart';
import 'states.dart';

enum CheckBoxState { checked, unchecked }

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit(this.authrep) : super(LoginInitialState());
  final authrepo authrep;
  void toggleCheckBox(bool isChecked) {
    emit(CheckBoxToggled(isChecked));
  }

  /* Login(
     String number,
    String password,
  ) async {
    emit(LoginLoadinglState());

    try {
    /*  var response = await Api().post(
        url: '$linklogin',
        body: {
          "st_mobile": number,
          "password": password,
        },
      );*/
      emit(LoginSucceslState());

      // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
      String? fcmToken;
      if (Firebase.apps.isNotEmpty) {
        fcmToken = await FirebaseMessaging.instance.getToken();
        print("FCM Token: $fcmToken");
      }

      //await sharedpref.saveToken(response["access_token"]);
      prefs!.setString("token", response["access_token"]);
      print("============================token${prefs!.getString("token")}");
      //for sending token to api to store it
      if (fcmToken != null) {
        sendfcmtoken(fcmtoken: fcmToken);
        //   await prefs!.setString("dtoken", fcmToken);
      }

//////////////////////////////
     

      ///////////////////
      print("============================${prefs!.getBool("ist")}");
      // print(prefs!.getInt("stid"));
    } on Exception catch (e) {
      emit(LoginErrorState(error: "errrrrrro"));
    }
  }

  LoginTeacher({
    required String number,
    required String password,
  }) async {
    emit(LoginTeacherLoadinglState());

    try {
      var response = await Api().post(
        url: '$linkloginTeacher',
        body: {
          "t_mobile": number,
          "password": password,
        },
      );
      emit(LoginTeacherSucceslState());
      final fcmToken = await FirebaseMessaging.instance.getToken();
      prefs!.setString("token", response["access_token"]);
/////////////
      await sendfcmtoken(fcmtoken: fcmToken!);
      await prefs!.setString("dtoken", fcmToken);
      //////////////////
      prefs!.setInt("teacherid", response['teacher']['t_id']);
      prefs!.setString("teachername", response['teacher']['t_name']);
      //////////////////
      //  print(response["access_token"]);

      prefs!.setBool("ist", response['isTeacher']);
      // print("============================${prefs!.getBool("ist")}");

      //print(prefs!.getInt("teacherid"));
    } on Exception catch (e) {
      emit(LoginTeacherErrorState(error: "errrrrrro"));
    }
  }*/

  Future<void> register(
    String numstudent,
    String password,
    String stdName,
    String gender,
    String resName,
    String numfather,
    String stdaddress,
  ) async {
    emit(RegisterLoadinglState());

    try {
      var result = await authrep.register(
        numstudent,
        password,
        stdName,
        gender,
        resName,
        numfather,
        stdaddress,
      );

      result.fold((failure) {
        emit(RegisterErrorState(failure.errormessage));
      }, (r) {
        emit(RegisterSucceslState());
      });
    } catch (e) {
      emit(RegisterErrorState(e.toString()));
    }
  }

  Future<void> Login(
    String number,
    String password,
  ) async {
    emit(LoginLoadinglState());

    var result = await authrep.Login(number, password);

    result.fold((failure) {
      emit(LoginErrorState(failure.errormessage));
    }, (sdata) {
      emit(LoginSucceslState(sdata));
    });
  }

  Future<void> LoginTeacher(
    String number,
    String password,
  ) async {
    emit(LoginTeacherLoadinglState());
    try {
      var result = await authrep.LoginTeacher(number, password);

      result.fold((failure) {
        emit(LoginTeacherErrorState(failure.errormessage));
      }, (tdata) {
        emit(LoginTeacherSucceslState(tdata));
      });
    } catch (e) {
      emit(LoginTeacherErrorState(e.toString()));
    }
  }
}
