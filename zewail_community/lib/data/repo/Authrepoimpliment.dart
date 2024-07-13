import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../models/ErroRegisterModel.dart';
import '../models/LoginTeachrModel.dart';
import 'PostsRepo.dart';
import '../../view/auth/LoginTeacher.dart';

import '../../Core/Constant/links.dart';
import '../../Core/Function/Api.dart';
import '../../Core/errors/faliure.dart';
import '../../main.dart';
import '../models/LoginStudentModel.dart';
import '../models/PostDatamodel.dart';
import 'Authrepo.dart';

class AuthRepoim implements authrepo {
  @override
  final Apiservice Apiser;

  AuthRepoim(this.Apiser);

  @override
  Future<Either<failure, bool?>> checkStudentExist(String numberSt) async {
    try {
      var jsonData = await Apiser.getdio(
          url: "$baseurl");

      bool? isExist = jsonData['isExist'];
      return right(isExist);
    } catch (e) {
      if (e is DioException) {
        return left(serverFailure.fromDioerro(e));
      }
      return left(serverFailure(e.toString()));
    }
  }

  Future<Either<failure, void>> register(
    String numstudent,
    String password,
    String stdName,
    String gender,
    String resName,
    String numfather,
    String stdaddress,
  ) async {
    try {
      var response = await Apiser.postdio(
        url: '$linksignup',
        data: {
          'st_mobile': numstudent,
          'password': password,
          'st_name': stdName,
          'st_gender': gender,
          'st_responsible_name': resName,
          'st_responsible_telephone': numfather,
          'st_address': stdaddress
        },
      );
      // var studentdata = Student.fromJson(response);
      //var errorsing = ErrorRegisterModel.fromJson(response);

      return right(response);
    } catch (e) {
      if (e is DioException) {
        return left(serverFailure.fromDioerro(e));
      }
      return left(serverFailure(e.toString()));
    }
  }

  Future<Either<failure, loginstudentModel>> Login(
    String number,
    String password,
  ) async {
    try {
      var response = await Apiser.postdio(
        url: '$linklogin',
        data: {
          "st_mobile": number,
          "password": password,
        },
      );

      final loginstudentModel stdata = loginstudentModel.fromJson(response);

      return right(stdata);
    } catch (e) {
      if (e is DioException) {
        return left(serverFailure.fromDioerro(e));
      }
      return left(serverFailure(e.toString()));
    }
  }

  Future<Either<failure, loginTeacherModel>> LoginTeacher(
    String number,
    String password,
  ) async {
    try {
      var response = await Apiser.postdio(
        url: '$linkloginTeacher',
        data: {
          "t_mobile": number,
          "password": password,
        },
      );

      final loginTeacherModel teacherdata =
          loginTeacherModel.fromJson(response);

      return right(teacherdata);
    } catch (e) {
      if (e is DioException) {
        return left(serverFailure.fromDioerro(e));
      }
      return left(serverFailure(e.toString()));
    }
  }

  Future<Either<failure, void>> sendfcmtoken(
    String fcmtoken,
  ) async {
    try {
      var response = await Apiser.postdio(
        url:
            "$baseurl/student/",
        data: {
          "device_token": fcmtoken,
        },
      );
      return right(response);
      // print(prefs!.getInt("stid"));
    } on Exception catch (e) {
      if (e is DioException) {
        return left(serverFailure.fromDioerro(e));
      }
      return left(serverFailure(e.toString()));
    }
  }
}
