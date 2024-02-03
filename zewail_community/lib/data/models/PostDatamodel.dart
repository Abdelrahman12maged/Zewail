class PostdataModel {
  bool? success;
  String? msg;
  int? postid;
  Data? data;

  PostdataModel({this.success, this.msg, this.data, this.postid});

  PostdataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    msg = json['msg'];
    postid = json['post_id'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  Post? post;

  Data({this.post});

  Data.fromJson(Map<String, dynamic> json) {
    post = json['post'] != null ? new Post.fromJson(json['post']) : null;
  }
}

class Post {
  int? id;
  int? isTaecher;
  String? title;
  String? content;
  String? image;
  int? bookId;
  int? bookPage;
  String? ownerName;
  bool? teacherReplay;
  // int? stId;
  String? createdAt;
  String? updatedAt;
  String? questionNo;
  int? appGroupId;
  int? isImportant;
  String? timeAgo;
  String? avatar;
  //note that stid is String but i do dynamic and must be int =============================================================
  dynamic stid;
  Book? book;
  Student? student;
  List<Comments>? comments;

  Post(
      {this.id,
      this.isTaecher,
      this.title,
      this.content,
      this.image,
      this.bookId,
      this.bookPage,
      this.ownerName,
      this.teacherReplay,
      // this.stId,
      this.createdAt,
      this.updatedAt,
      this.questionNo,
      this.appGroupId,
      this.isImportant,
      this.timeAgo,
      this.avatar,
      this.stid,
      this.book,
      this.student,
      this.comments});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isTaecher = json['is_teacher'];
    title = json['title'];
    content = json['content'];
    image = json['image'];
    bookId = json['book_id'];
    bookPage = json['book_page'];
    ownerName = json['owner_name'];
    teacherReplay = json['teacherReplay'];
    //   stId = json['st_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    questionNo = json['question_no'];
    appGroupId = json['app_group_id'];
    isImportant = json['isImportant'];
    timeAgo = json['time_ago'];
    avatar = json['profile'];
    stid = json['st_id'];
    book = json['book'] != null ? new Book.fromJson(json['book']) : null;
    student =
        json['student'] != null ? new Student.fromJson(json['student']) : null;
    if (json['comments'] != null) {
      comments = List<Comments>.from(json['comments'].map((comment) {
        return Comments.fromJson(comment);
      }));
    }
  }
}

class Book {
  int? id;
  String? name;
  int? cId;
  String? createdAt;
  String? updatedAt;

  Book({this.id, this.name, this.cId, this.createdAt, this.updatedAt});

  Book.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    cId = json['c_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['c_id'] = this.cId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
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
  // Null? stFacebook;
  int? centerId;
  // Null? stSchool;
  String? stResponsibleName;
  // Null? stResponsibleJob;
  // Null? stResponsibleRelation;
  String? stResponsibleTelephone;
  // Null? notes;
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
      // this.stTelephone,
      this.stMobile,
      // this.stMobile2,
      // this.stEmail,
      // this.stFacebook,
      this.centerId,
      // this.stSchool,
      this.stResponsibleName,
      //  this.stResponsibleJob,
      // this.stResponsibleRelation,
      this.stResponsibleTelephone,
      // this.notes,
      this.stBalance,
      this.stageId,
      this.addingDate,
      //  this.eduMethod,
      this.token,
      this.feesPaid,
      this.isBlocked,
      //  this.cardCode,
      this.done});

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
    centerId = json['center_id'];
    //  stSchool = json['st_school'];
    stResponsibleName = json['st_responsible_name'];
    // stResponsibleJob = json['st_responsible_job'];
    // stResponsibleRelation = json['st_responsible_relation'];
    stResponsibleTelephone = json['st_responsible_telephone'];
    // notes = json['notes'];
    stBalance = json['st_balance'];
    stageId = json['stage_id'];
    addingDate = json['adding_date'];
    //  eduMethod = json['edu_method'];
    token = json['token'];
    feesPaid = json['fees_paid'];
    isBlocked = json['isBlocked'];
    //  cardCode = json['card_code'];
    done = json['done'];
  }
}

class Comments {
  int? id;
  String? content;
  String? image;
  String? ownerNamecomm;
  String? record;
  String? avatar;
  int? stId;
  int? postId;
  String? createdAt;
  String? updatedAt;
  // Null? tId;
  String? timeAgo;
  String? st_name;

  Comments(
      {this.id,
      this.content,
      this.image,
      this.ownerNamecomm,
      this.record,
      this.avatar,
      this.stId,
      this.postId,
      this.createdAt,
      this.updatedAt,
      // this.tId,
      this.timeAgo,
      this.st_name});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    image = json['image'];
    ownerNamecomm = json['owner_name'];
    record = json['record'];
    avatar = json['profile'];
    stId = json['st_id'];
    postId = json['post_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    // tId = json['t_id'];
    timeAgo = json['time_ago'];
    st_name = json['st_name'];
  }
}
