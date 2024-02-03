import 'package:dartz/dartz.dart';

import '../../Core/errors/faliure.dart';
import '../models/LoginStudentModel.dart';
import '../models/LoginTeachrModel.dart';

abstract class authrepo {
  Future<Either<failure, bool?>> checkStudentExist(String numberSt);
  Future<Either<failure, void>> register(
    String numstudent,
    String password,
    String stdName,
    String gender,
    String resName,
    String numfather,
    String stdaddress,
  );
  Future<Either<failure, loginstudentModel>> Login(
    String number,
    String password,
  );
  Future<Either<failure, loginTeacherModel>> LoginTeacher(
    String number,
    String password,
  );
  Future<Either<failure, void>> sendfcmtoken(
    String fcmtoken,
  );
}
