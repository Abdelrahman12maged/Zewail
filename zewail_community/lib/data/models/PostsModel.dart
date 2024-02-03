class PostsModel {
  int? id;
  int? isteacher;
  int? isteachercomm;
  String? content;
  String? image;
  int? groupid;
  String? ownerName;
  String? timeago;
  Student? studentdata;
  int? stid;
  List<Comments>? comments;
  int? bookpage;
  BookM? bookName;
  String? qnum;
  String? avatar;
  bool? teachreply;
  PostsModel(
      {this.id,
      this.isteacher,
      this.isteachercomm,
      this.content,
      this.image,
      this.studentdata,
      this.stid,
      this.comments,
      this.bookpage,
      this.ownerName,
      this.bookName,
      this.qnum,
      this.avatar,
      this.teachreply});

  PostsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    content = json['content'];
    isteacher = json['isTeacher'];
    isteachercomm = json['is_teacher'];
    image = json['image'];
    groupid = json['app_group_id'];
    timeago = json['time_ago'];
    bookpage = json['book_page'];
    ownerName = json['owner_name'];
    qnum = json['question_no'];
    avatar = json['profile'];
    stid = json['st_id'];
    teachreply = json['teacherReplay'];
    bookName = json['book'] != null ? new BookM.fromJson(json['book']) : null;
    studentdata =
        json['student'] != null ? new Student.fromJson(json['student']) : null;

    if (json['comments'] != null) {
      comments = List<Comments>.from(json['comments'].map((comment) {
        return Comments.fromJson(comment);
      }));
    }
  }
}

class Student {
  int? stId;
  String? stName;
  String? stGender;
  String? stAddress;
  String? stImage;
  //Null? stTelephone;
  String? stMobile;
  // Null? stMobile2;
  // Null? stEmail;
//  Null? stFacebook;
//  int? centerId;
  // Null? stSchool;
  String? stResponsibleName;
  //Null? stResponsibleJob;
  // Null? stResponsibleRelation;
  String? stResponsibleTelephone;
  // Null? notes;
  String? stBalance;
  // int? stageId;
  String? addingDate;
//  Null? eduMethod;
  String? token;
  // int? feesPaid;
  //int? isBlocked;
  // Null? cardCode;
  // int? done;

  Student({
    this.stId,
    this.stName,
    this.stGender,
    this.stAddress,
    this.stImage,
    //   this.stTelephone,
    this.stMobile,
    //    this.stMobile2,
    //   this.stEmail,
    //   this.stFacebook,
    //  this.centerId,
    //   this.stSchool,
    this.stResponsibleName,
    //   this.stResponsibleJob,
    //   this.stResponsibleRelation,
    this.stResponsibleTelephone,
    //   this.notes,
    this.stBalance,
    // this.stageId,
    this.addingDate,
    //   this.eduMethod,
    this.token,
    // this.feesPaid,
    // this.isBlocked,
    //    this.cardCode,
    //   this.done
  });

  Student.fromJson(Map<String, dynamic> json) {
    stId = json['st_id'];
    stName = json['st_name'];
    stGender = json['st_gender'];
    stAddress = json['st_address'];
    stImage = json['st_image'];
    //  stTelephone = json['st_telephone'];
    stMobile = json['st_mobile'];
    //  stMobile2 = json['st_mobile2'];
    //  stEmail = json['st_email'];
    //  stFacebook = json['st_facebook'];
    // centerId = json['center_id'];
    //  stSchool = json['st_school'];
    stResponsibleName = json['st_responsible_name'];
    //  stResponsibleJob = json['st_responsible_job'];
    //   stResponsibleRelation = json['st_responsible_relation'];
    stResponsibleTelephone = json['st_responsible_telephone'];
    // notes = json['notes'];
    stBalance = json['st_balance'];
    //stageId = json['stage_id'];
    addingDate = json['adding_date'];
    //  eduMethod = json['edu_method'];
    token = json['token'];
    //  feesPaid = json['fees_paid'];
    // isBlocked = json['isBlocked'];
    //  cardCode = json['card_code'];
    //  done = json['done'];
  }
}

class Comments {
  int? id;
  String? content;
  String? ownerNamecomm;
  String? image;
  String? record;
  String? avatar;
  int? stId;
  int? postId;
  String? createdAt;
  String? updatedAt;
  String? timeAgo;
  //Null? tId;

  Comments(
      {this.id,
      this.content,
      this.ownerNamecomm,
      this.avatar,
      this.image,
      this.record,
      this.stId,
      this.postId,
      this.createdAt,
      this.updatedAt,
      this.timeAgo
      // this.tId
      });

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    ownerNamecomm = json['owner_name'];
    avatar = json['profile'];
    image = json['image'];
    record = json['record'];
    stId = json['st_id'];
    postId = json['post_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    timeAgo = json['time_ago'];
    // tId = json['t_id'];
  }
}

class BookM {
  int? id;
  String? name;
  // int? cId;
  // String? createdAt;
  // String? updatedAt;

  BookM({
    this.id,
    this.name,
    // this.cId,
    // this.createdAt,
    // this.updatedAt
  });

  BookM.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    //  cId = json['c_id'];
    //  createdAt = json['created_at'];
    // updatedAt = json['updated_at'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    // data['c_id'] = this.cId;
    //  data['created_at'] = this.createdAt;
    // data['updated_at'] = this.updatedAt;
    return data;
  }
}
