class notificationModel {
  bool? success;
  List<Data>? data;

  notificationModel({this.success, this.data});

  notificationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = List<Data>.from(json['data'].map((data) {
        return Data.fromJson(data);
      }));
    }
  }
}

class Data {
  String? title;
  String? body;
  String? url;
  String? image;
  int? postId;
  String? timeAgo;

  Data(
      {this.title, this.body, this.url, this.image, this.postId, this.timeAgo});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    url = json['url'];
    image = json['image'];
    postId = json['post_id'];
    timeAgo = json['time_ago'];
  }
}
