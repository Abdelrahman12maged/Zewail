class BooksModel {
  bool? success;
  String? msg;
  Data? data;

  BooksModel({this.success, this.msg, this.data});

  BooksModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<Books>? books;

  Data({this.books});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['books'] != null) {
      books = <Books>[];
      json['books'].forEach((v) {
        books!.add(new Books.fromJson(v));
      });
    }
  }
}

class Books {
  int? id;
  String? name;

  Books({this.id, this.name});

  Books.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
