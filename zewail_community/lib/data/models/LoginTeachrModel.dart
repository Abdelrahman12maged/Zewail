class loginTeacherModel {
  String? accessToken;
  String? tokenType;
  int? expiresIn;
  bool? isTeacher;
  Teacher? teacher;

  loginTeacherModel(
      {this.accessToken,
      this.tokenType,
      this.expiresIn,
      this.isTeacher,
      this.teacher});

  loginTeacherModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    isTeacher = json['isTeacher'];
    teacher =
        json['teacher'] != null ? new Teacher.fromJson(json['teacher']) : null;
  }
}

class Teacher {
  int? tId;
  String? tName;
  String? tAddress;
//  Null? tTelephone;
  String? tMobile;
  // Null? tEmail;
  // Null? tFacebook;
  int? countryId;
  String? bio;
  int? govId;
  int? cityId;
  String? password;
//  Null? rememberToken;
  String? profile;

  Teacher(
      {this.tId,
      this.tName,
      this.tAddress,
      // this.tTelephone,
      this.tMobile,
      //  this.tEmail,
      //  this.tFacebook,
      this.countryId,
      this.bio,
      this.govId,
      this.cityId,
      this.password,
      //  this.rememberToken,
      this.profile});

  Teacher.fromJson(Map<String, dynamic> json) {
    tId = json['t_id'];
    tName = json['t_name'];
    tAddress = json['t_address'];
    //tTelephone = json['t_telephone'];
    tMobile = json['t_mobile'];
    // tEmail = json['t_email'];
    //  tFacebook = json['t_facebook'];
    countryId = json['country_id'];
    bio = json['bio'];
    govId = json['gov_id'];
    cityId = json['city_id'];
    password = json['password'];
    //  rememberToken = json['remember_token'];
    profile = json['profile'];
  }
}
