class GroupModel {
  int id;
  String? name;
  String? image;
  String? teachername;
  GroupModel(
      {required this.id,
      required this.name,
      required this.image,
      required this.teachername});

  factory GroupModel.fromJson(dynamic json) {
    return GroupModel(
      id: json['id'],
      name: json['course_name'],
      teachername: json['teacher_name'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['teacher_name'] = this.teachername;
    data['course_name'] = this.name;

    data['image'] = this.image;
    return data;
  }
}
