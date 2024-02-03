import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../../Core/Constant/links.dart';
import '../../Core/Function/Api.dart';
import '../../Core/errors/faliure.dart';
import '../../main.dart';
import '../models/BooksModel.dart';
import '../models/PostDatamodel.dart';
import '../models/PostsModel.dart';
import '../models/UserModel.dart';
import 'PostsRepo.dart';

class postRepoim implements postrepo {
  @override
  final Apiservice Apiser;

  postRepoim(this.Apiser);
  int currentPage = 1; //
  @override
  Future<Either<failure, List<PostsModel>>> fetchAllgroupPosts(
      int gid, currentPage,
      [String? search]) async {
    try {
      var jsonData = await Apiser.getdio(queryParameters: {
        'page': currentPage
      }, url: "$baseurl/student/getPosts?app_group_id=$gid&search=$search&token=${prefs!.getString("token")}");

      final List<PostsModel> posts = [];

// final List<dynamic> groupsData = jsonData["data"]['groups'];
      print(jsonData["data"]['groups']["data"]);
      for (var postsData in jsonData["data"]['groups']["data"]) {
        final PostsModel post = PostsModel.fromJson(postsData);
        posts.add(post);
      }

      return right(posts);
    } catch (e) {
      if (e is DioException) {
        return left(serverFailure.fromDioerro(e));
      }
      return left(serverFailure(e.toString()));
    }
  }

  @override
  Future<Either<failure, List<PostsModel>>> fetchAllStudentPosts(
      int stid, currentPage) async {
    try {
      var jsonData = await Apiser.getdio(queryParameters: {
        'page': currentPage
      }, url: "$baseurl/student/getStudentPosts?st_id=$stid&token=${prefs!.getString("token")}");

      final List<PostsModel> stposts = [];
      print(jsonData["data"]['groups']["data"]);
// final List<dynamic> groupsData = jsonData["data"]['groups'];

      for (var postsData in jsonData["data"]['groups']["data"]) {
        final PostsModel post = PostsModel.fromJson(postsData);
        stposts.add(post);
      }

      return right(stposts);
    } catch (e) {
      if (e is DioException) {
        return left(serverFailure.fromDioerro(e));
      }
      return left(serverFailure(e.toString()));
    }
  }

  Future<Either<failure, PostdataModel>> addPost(int bookName, String bookPage,
      String questionNo, String content, int groupid, File? imageFile) async {
    try {
      FormData formData = FormData.fromMap({
        'book_id': bookName,
        'book_page': bookPage,
        'question_no': questionNo,
        'content': content,
        "app_group_id": groupid,
        'image': await MultipartFile.fromFile(imageFile!.path),
      });
      var jsonData = await Apiser.postdiofromdata(
        url: "$baseurl/student/storePost?token=${prefs!.getString("token")}",
        data: formData,
      );

      //  var request = http.MultipartRequest(
      //   'POST',
      //   Uri.parse(
      //        "$baseurl/student/storePost?token=${prefs!.getString("token")}"),
      // );
      /*  request.fields.addAll({
        'book_id': bookName.toString(),
        'book_page': bookPage,
        'question_no': questionNo,
        'content': content,
        "app_group_id": groupid.toString(),
      });*/

      //   request.files.add(
      //    await http.MultipartFile.fromPath('image', imageFile!.path),
      //  );

      //var response = await request.send();
      // if (response.statusCode == 200) {
      //  print(await response.stream.bytesToString());
      // } else {
      //  print('Erroraddddddddd: ${response.reasonPhrase}');
      //  }
      var postModel = PostdataModel.fromJson(jsonData);

      return right(postModel);
    } catch (e) {
      if (e is DioException) {
        return left(serverFailure.fromDioerro(e));
      }
      return left(serverFailure(e.toString()));
    }
  }

  Future<Either<failure, PostdataModel>> addPostWithoutImage(
    int bookName,
    String bookPage,
    String questionNo,
    String content,
    int groupId,
  ) async {
    try {
      var jsonData = await Apiser.postdio(
        queryParameters: {
          "app_group_id": groupId,
        },
        url: "$baseurl/student/storePost?token=${prefs!.getString("token")}",
        data: {
          'book_id': bookName,
          'book_page': bookPage,
          'question_no': questionNo,
          'content': content,
        },
      );
      var postModel = PostdataModel.fromJson(jsonData);

      return right(postModel);
    } catch (e) {
      if (e is DioException) {
        return left(serverFailure.fromDioerro(e));
      }
      return left(serverFailure(e.toString()));
    }
  }

  Future<void> updatePost(
    int bookName,
    String bookPage,
    String questionNo,
    String content,
    //int groupid,
    int postid,
    File? imageFile,
  ) async {
    try {
      // Create the multipart request for the API call
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '$baseurl/student/updatePost?token=${prefs!.getString("token")}'),
      );
      request.fields['book_id'] = bookName.toString();
      request.fields['book_page'] = bookPage;
      request.fields['question_no'] = questionNo;
      request.fields['content'] = content;
      //  request.fields['app_group_id'] = groupid.toString();
      request.fields['post_id'] = postid.toString();
      // Add fields to the request

      request.files.add(
        await http.MultipartFile.fromPath('image', imageFile!.path),
      );

      // Send the request and get the response
      final response = await http.Response.fromStream(await request.send());
      if (response.statusCode == 200) {
      } else {
        print('Errorlkkkkkkkkkk: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Errorkkkkkkkkkkkkk: $e');
    }
  }

  Future<void> updatePostWithoutImage(
    int bookName,
    String bookPage,
    String questionNo,
    String content,
    //  int groupid,
    int postid,
  ) async {
    try {
      var jsonData = await Apiser.postdio(
        queryParameters: {
          //"app_group_id": groupid,

          "post_id": postid
        },
        url: "$baseurl/student/updatePost?token=${prefs!.getString("token")}",
        data: {
          'book_id': bookName,
          'book_page': bookPage,
          'question_no': questionNo,
          'content': content,
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }
  // Rest of the code...

  /* Future<void> addPost(
    int bookName,
    String bookPage,
    String questionNo,
    String content,
    int groupid,
    File? imageFile,
  ) async {
    try {
      var jsonData = await Apiser.postdio(
          queryParameters: {
            "app_group_id": groupid,
          },
          url: "$baseurl/student/storePost?token=${prefs!.getString("token")}",
          data: {
            'book_id': bookName,
            'book_page': bookPage,
            'question_no': questionNo,
            'content': content,
            'image': await MultipartFile.fromFileSync(
              imageFile!.path,
            )
          });
    } catch (e) {
      print(e.toString());
    }
  }*/

  @override
  Future<Either<failure, UserModel>> fetchUser() async {
    try {
      var jsonData = await Apiser.getdio(
          url:
              "$baseurl/student/getStudent?&token=${prefs!.getString("token")}");

      //  var userdata = jsonData['data']['student'];

      final UserModel user = UserModel.fromJson(jsonData);

      return right(user);
    } catch (e) {
      if (e is DioException) {
        return left(serverFailure.fromDioerro(e));
      }
      return left(serverFailure(e.toString()));
    }

    // throw UnimplementedError();
  }

  Future<Either<failure, BooksModel>> fetchBooks(int gid) async {
    try {
      var jsonData = await Apiser.getdio(
          url:
              "$baseurl/student/getBooks?app_group_id=$gid?&token=${prefs!.getString("token")}");

      final BooksModel booksmodel = BooksModel.fromJson(jsonData);

      return right(booksmodel);
    } catch (e) {
      if (e is DioException) {
        return left(serverFailure.fromDioerro(e));
      }

      return left(serverFailure(e.toString()));
    }

    // throw UnimplementedError();
  }

  @override
  Future<Either<failure, PostdataModel>> addComment(
      int postid, String content, File? imageFile) async {
    try {
      FormData formData = FormData.fromMap({
        'post_id': postid,
        'content': content,
        'image': await MultipartFile.fromFile(imageFile!.path),
      });
      var jsonData = await Apiser.postdiofromdata(
        url: "$baseurl/student/storeComment?token=${prefs!.getString("token")}",
        data: formData,
      );

      var postModel = PostdataModel.fromJson(jsonData);
      return right(postModel);
    } catch (e) {
      if (e is DioException) {
        return left(serverFailure.fromDioerro(e));
      }
      return left(serverFailure(e.toString()));
    }
  }

/*  Future<Either<failure, PostdataModel>> addComment(
      int postid, String content, File? imageFile) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            "$baseurl/student/storeComment?token=${prefs!.getString("token")}"),
      );
      request.fields.addAll({
        'post_id': postid.toString(),
        'content': content,
      });
      request.files.add(
        await http.MultipartFile.fromPath('image', imageFile!.path),
      );

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseText = await response.stream.bytesToString();
        var responseData = jsonDecode(responseText);
        var postModel = PostdataModel.fromJson(responseData);
        return right(postModel);
        // print("========================${responseData}");
      } else {
        throw Exception('Error: ${response.reasonPhrase}');
        // print('Error: ${response.reasonPhrase}');
      }
      /* var jsonData = await Apiser.postdio(
          queryParameters: {'post_id': postid},
          url:
              "$baseurl/student/storeComment?token=${prefs!.getString("token")}",
          data: {
            'content': content,
          });*/
    } catch (e) {
    
    }
    // throw Exception('Error: ${response.reasonPhrase}');
    throw Exception('Unexpected error occurred');
  }*/

  Future<Either<failure, PostdataModel>> addCommentWithoutimage(
      int postid, String content) async {
    try {
      var jsonData = await Apiser.postdio(
        queryParameters: {
          'post_id': postid,
        },
        url: "$baseurl/student/storeComment?token=${prefs!.getString("token")}",
        data: {
          'content': content,
        },
      );

      var postModel = PostdataModel.fromJson(jsonData);
      return right(postModel);
    } catch (e) {
      if (e is DioException) {
        return left(serverFailure.fromDioerro(e));
      }
      return left(serverFailure(e.toString()));
    }
  }

  Future<void> addRecord(int postid, File? record) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            "$baseurl/student/storeComment?token=${prefs!.getString("token")}"),
      );
      request.fields.addAll({
        'post_id': postid.toString(),
      });
      request.files.add(
        await http.MultipartFile.fromPath('record', record!.path),
      );

      var response = await request.send();
      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<Either<failure, PostdataModel>> fetchpostData(
    int postid,
  ) async {
    try {
      var jsonData = await Apiser.getdio(
          queryParameters: {},
          url:
              "$baseurl/student/getPost?post_id=$postid&token=${prefs!.getString("token")}");

      final PostdataModel post = PostdataModel.fromJson(jsonData);

      return right(post);
    } catch (e) {
      if (e is DioException) {
        return left(serverFailure.fromDioerro(e));
      }
      return left(serverFailure(e.toString()));
    }

    // throw UnimplementedError();
  }

  @override
  Future<void> deletePost(int postid) async {
    try {
      var jsonData = await Apiser.getdio(
        url:
            "$baseurl/student/deletePost?post_id=$postid&token=${prefs!.getString("token")}",
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deletecomment(int commentid) async {
    try {
      var jsonData = await Apiser.getdio(
        url:
            "$baseurl/student/deleteComment?comment_id=$commentid&token=${prefs!.getString("token")}",
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
