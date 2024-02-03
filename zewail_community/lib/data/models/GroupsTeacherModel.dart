class GroupTeacherModel {
  int id;
  String? courseName;
  String? image;
  String? teachername;
  GroupTeacherModel(
      {required this.id,
      required this.courseName,
      required this.image,
      required this.teachername});

  factory GroupTeacherModel.fromJson(dynamic json) {
    return GroupTeacherModel(
        teachername: json['teacher_name'],
        courseName: json['course_name'],
        id: json['id'],
        image: json['image']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['teacher_name'] = this.teachername;
    data['course_name'] = this.courseName;

    data['image'] = this.image;
    return data;
  }
}
