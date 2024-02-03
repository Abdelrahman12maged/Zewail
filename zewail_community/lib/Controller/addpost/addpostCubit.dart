import 'dart:ffi';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'states.dart';
import '../../Core/errors/faliure.dart';
import '../../data/models/BooksModel.dart';
import '../../data/repo/PostsRepo.dart';
import 'package:http/http.dart' as http;

import '../../Core/Constant/links.dart';
import '../../main.dart';

class addpostCubit extends Cubit<addpostStates> {
  addpostCubit(
    this.postrep,
  ) : super(addPostInitial());

  final postrepo postrep;
  Future<void> addPosts(int bookName, String bookPage, String questionNo,
      String content, int groupId, File? imageFile) async {
    emit(addPostLoading());
    //try {
    if (imageFile != null) {
      var result = await postrep.addPost(
        bookName,
        bookPage,
        questionNo,
        content,
        groupId,
        imageFile,
      );
      result.fold((failure) {
        emit(addPostFailure(failure.errormessage));
      }, (post) {
        emit(addPostSuccess(post));
      });
    } else {
      // Handle the case when the imageFile is not provided
      var result = await postrep.addPostWithoutImage(
        bookName,
        bookPage,
        questionNo,
        content,
        groupId,
      );

      result.fold((failure) {
        emit(addPostFailure(failure.errormessage));
      }, (post) {
        emit(addPostSuccess(post));
      });
    }
    // } catch (e) {
    //   emit(addPostFailure(e.toString()));
    // }
  }

  BooksModel? bookss;
  Future<void> getbooks(int gid) async {
    emit(BooksLoadinglState());
    try {
      var result = await postrep.fetchBooks(gid);
      result.fold((failure) {
        emit(BooksFailure(failure.errormessage));
      }, (books) {
        bookss = books;
        emit(BooksSucceslState());
      });
    } catch (e) {
      emit(BooksFailure(e.toString()));
    }
  }

  /////////////////
  ///
  Future<void> updatpost(
    int bookName,
    String bookPage,
    String questionNo,
    String content,
    // int groupid,
    int postid,
    File? imageFile,
  ) async {
    emit(updatePostLoading());
    try {
      if (imageFile != null) {
        var result = await postrep.updatePost(
          bookName,
          bookPage,
          questionNo,
          content,
          //  groupid,
          postid,
          imageFile,
        );
      } else {
        var result = await postrep.updatePostWithoutImage(
            bookName,
            bookPage,
            questionNo,
            content,

            //groupid,
            postid);
      }
      emit(updatePostSuccess());
    } catch (e) {
      emit(updatePostFailure(e.toString()));
    }
  }

  // ...
}
