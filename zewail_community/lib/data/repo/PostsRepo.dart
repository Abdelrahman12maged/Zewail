import 'dart:io';

import 'package:dartz/dartz.dart';
import '../models/BooksModel.dart';
import '../models/PostsModel.dart';

import '../../Core/errors/faliure.dart';
import '../models/Commentsmodel.dart';
import '../models/PostDatamodel.dart';
import '../models/UserModel.dart';

abstract class postrepo {
  Future<Either<failure, List<PostsModel>>> fetchAllgroupPosts(
      int gid, int currentPage,
      [String? search]);
  Future<Either<failure, List<PostsModel>>> fetchAllStudentPosts(
      int stid, int currentPage);
  Future<Either<failure, PostdataModel>> addPost(int bookName, String bookPage,
      String questionNo, String content, int groupid, File? imageFile);
  Future<Either<failure, PostdataModel>> addPostWithoutImage(
    int bookName,
    String bookPage,
    String questionNo,
    String content,
    int groupId,
  );
  Future<Either<failure, UserModel>> fetchUser();
  Future<Either<failure, BooksModel>> fetchBooks(int gid);
  Future<Either<failure, PostdataModel>> addComment(
      int postid, String content, File? imageFile);
  Future<Either<failure, PostdataModel>> addCommentWithoutimage(
      int postid, String content);
  Future<void> addRecord(int postid, File? record);
  Future<Either<failure, PostdataModel>> fetchpostData(
    int postid,
  );
  Future<void> deletePost(int postid);
  Future<void> deletecomment(int commentid);
  Future<void> updatePost(
    int bookName,
    String bookPage,
    String questionNo,
    String content,
    //  int groupid,
    int postid,
    File? imageFile,
  );
  Future<void> updatePostWithoutImage(
    int bookName,
    String bookPage,
    String questionNo,
    String content,
    //   int groupid,
    int postid,
  );
}
