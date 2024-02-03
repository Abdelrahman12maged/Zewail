import '../../../data/models/PostDatamodel.dart';

import '../../../data/models/LoginStudentModel.dart';
import '../../../data/models/LoginTeachrModel.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadinglState extends LoginStates {}

class LoginSucceslState extends LoginStates {
  final loginstudentModel stdata;

  LoginSucceslState(this.stdata);
}

class CheckBoxInitial extends LoginStates {}

class CheckBoxToggled extends LoginStates {
  final bool isChecked;

  CheckBoxToggled(this.isChecked);
}

class LoginErrorState extends LoginStates {
  dynamic error;
  LoginErrorState(this.error);
}

class LoginTeacherLoadinglState extends LoginStates {}

class LoginTeacherSucceslState extends LoginStates {
  final loginTeacherModel teacherdata;

  LoginTeacherSucceslState(this.teacherdata);
}

class LoginTeacherErrorState extends LoginStates {
  dynamic error;
  LoginTeacherErrorState(this.error);
}

class RegisterLoadinglState extends LoginStates {}

class RegisterSucceslState extends LoginStates {}

class RegisterErrorState extends LoginStates {
  dynamic error;
  RegisterErrorState(this.error);
}

class sendcmmloading extends LoginStates {}

class sendfcmsuccess extends LoginStates {}

class sendfcmerror extends LoginStates {
  String error;
  sendfcmerror(this.error);
}
