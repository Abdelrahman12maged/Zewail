import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/PostDatamodel.dart';
import '../../data/repo/PostsRepo.dart';
import 'states.dart';

class addcommentCubit extends Cubit<addcommentStates> {
  addcommentCubit(
    this.postrep,
  ) : super(addcommentInitial());

  final postrepo postrep;
  Future<void> addcomment(int postid, String content, File? imageFile) async {
    emit(addcommentLoading());
    try {
      if (imageFile != null) {
        var result = await postrep.addComment(postid, content, imageFile);
        result.fold((failure) {
          emit(addcommentFailure(failure.errormessage));
        }, (post) {
          emit(addcommentSuccess(post));
        });
      } else {
        var result = await postrep.addCommentWithoutimage(postid, content);
        result.fold((failure) {
          emit(addcommentFailure(failure.errormessage));
        }, (post) {
          emit(addcommentSuccess(post));
        });
      }
    } catch (e) {
      emit(addcommentFailure("faild"));
    }
  }

  Future<void> addRecord(int postid, File? record) async {
    emit(addReocrdLoading());
    try {
      var result = await postrep.addRecord(postid, record);

      emit(addRecordSuccess());
    } catch (e) {
      emit(addRecordFailure("failed"));
    }
  }

  PostdataModel? postt;
  Future<void> getpostData(int postid) async {
    emit(getpostLoadinglState());
    try {
      var result = await postrep.fetchpostData(postid);
      result.fold((failure) {
        emit(getpostFailure(failure.errormessage));
      }, (post) {
        postt = post;
        emit(getpostSucceslState());
      });
    } catch (e) {
      emit(getpostFailure(e.toString()));
    }
  }

  Future<void> deleteComment(int commentid) async {
    emit(deleteCommentLoading());
    try {
      var result = await postrep.deletecomment(commentid);

      emit(deleteCommentSuccess());
    } catch (e) {
      emit(deleteCommentFailure(e.toString()));
    }
  }
  /*bool isLoading = false;

  Future<void> fetchAllcomments(
    int gid,
  ) async {
    emit(commentLoadinglState());

    isLoading = true;

    var result = await postrep.fetchAllcomments(gid);
    result.fold((failure) {
      emit(commentfailuerState(failure.errormessage));
    }, (fetchedcomments) {
      isLoading = false;
      emit(commentSucceslState(fetchedcomments));
    });
  }*/
}
