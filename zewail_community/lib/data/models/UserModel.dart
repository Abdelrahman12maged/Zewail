class UserModel {
  bool? success;
  Student? data;

  UserModel({this.success, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data =
        json['data'] != null ? Student.fromJson(json['data']['student']) : null;
  }
}

class Student {
  int? stId;
  String? stName;
  String? stGender;
  String? stAddress;
  String? stImage;
  // Null? stTelephone;
  String? stMobile;
//  Null? stMobile2;
//  Null? stEmail;
//  Null? stFacebook;
  int? centerId;
//  Null? stSchool;
  String? stResponsibleName;
  // Null? stResponsibleJob;
  // Null? stResponsibleRelation;
  String? stResponsibleTelephone;
  //Null? notes;
  String? stBalance;
  int? stageId;
  String? addingDate;
  // Null? eduMethod;
  String? token;
  int? feesPaid;
  int? isBlocked;
  // Null? cardCode;
  int? done;

  Student(
      {this.stId,
      this.stName,
      this.stGender,
      this.stAddress,
      this.stImage,
      //   this.stTelephone,
      this.stMobile,
      //   this.stMobile2,
      //   this.stEmail,
      //   this.stFacebook,
      this.centerId,
      //   this.stSchool,
      this.stResponsibleName,
      //   this.stResponsibleJob,
      //   this.stResponsibleRelation,
      this.stResponsibleTelephone,
      //   this.notes,
      this.stBalance,
      this.stageId,
      this.addingDate,
      //   this.eduMethod,
      this.token,
      this.feesPaid,
      this.isBlocked,
      // this.cardCode,
      this.done});

  Student.fromJson(Map<String, dynamic> json) {
    stId = json['st_id'];
    stName = json['st_name'];
    stGender = json['st_gender'];
    stAddress = json['st_address'];
    stImage = json['st_image'];
    // stTelephone = json['st_telephone'];
    stMobile = json['st_mobile'];
    //  stMobile2 = json['st_mobile2'];
    //  stEmail = json['st_email'];
    //  stFacebook = json['st_facebook'];
    centerId = json['center_id'];
    //  stSchool = json['st_school'];
    stResponsibleName = json['st_responsible_name'];
    //  stResponsibleJob = json['st_responsible_job'];
    //  stResponsibleRelation = json['st_responsible_relation'];
    stResponsibleTelephone = json['st_responsible_telephone'];
    // notes = json['notes'];
    stBalance = json['st_balance'];
    stageId = json['stage_id'];
    addingDate = json['adding_date'];
    // eduMethod = json['edu_method'];
    token = json['token'];
    feesPaid = json['fees_paid'];
    isBlocked = json['isBlocked'];
    // cardCode = json['card_code'];
    done = json['done'];
  }
}
