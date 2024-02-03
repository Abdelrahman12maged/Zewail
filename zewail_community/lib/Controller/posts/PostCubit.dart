import 'package:flutter_bloc/flutter_bloc.dart';
import 'PostStates.dart';
import '../groups/Cubit/states.dart';
import '../../Core/Shared/sharedpref.dart';
import '../../Core/errors/faliure.dart';
import '../../data/models/PostsModel.dart';
import '../../data/repo/PostsRepo.dart';
import '../../data/repo/groupRepoimp.dart';
import '../../data/repo/grouprepo.dart';
import '../../main.dart';

import '../../Core/Constant/links.dart';

class postCubit extends Cubit<postStates> {
  postCubit(
    this.postrep,
  ) : super(PostInitialState());
  final postrepo postrep;
  int currentPage = 1;
  int loadedPostsCount = 0;
  bool isLoading = false;
  bool hasMoreData = true;
  List<PostsModel> posts = [];
  bool isLoadingMore = false;
  Future<void> fetchgroupPosts(int gid, [String? search]) async {
    emit(PostLoadinglState());
    currentPage = 1;
    loadedPostsCount = 0;
    isLoading = true;
    hasMoreData = true; // إعادة تعيين حالة وجود المزيد من البيانات
    posts = []; // إعادة تعيين قائمة البوستات

    var result = await postrep.fetchAllgroupPosts(gid, currentPage, search);
    result.fold((failure) {
      emit(PostfailuerState(failure.errormessage));
    }, (fetchedPosts) {
      loadedPostsCount = fetchedPosts.length;
      if (fetchedPosts.length == 0) {
        hasMoreData = false;
      }
      isLoading = false;
      posts.addAll(fetchedPosts); // إضافة البوستات المحملة إلى القائمة
      emit(PostSucceslState(posts));
    });
  }

  int? gid;
  Future<void> loadMorePosts(gid) async {
    if (isLoading || !hasMoreData) {
      return;
    }

    isLoadingMore = true; // تعيين حالة التحميل عند الضغط على زر "Load More"
    currentPage++;

    var result = await postrep.fetchAllgroupPosts(gid, currentPage);
    result.fold((failure) {
      isLoadingMore = false;
      emit(PostfailuerState(failure.errormessage));
    }, (newPosts) {
      loadedPostsCount += newPosts.length;
      if (newPosts.length == 0) {
        hasMoreData = false;
      }
      isLoadingMore = false;
      posts.addAll(newPosts); // إضافة البوستات الجديدة إلى القائمة
      emit(PostSucceslState(posts));
    });
  }

  Future<void> deletePost(int postid) async {
    emit(deletePostLoading());
    try {
      var result = await postrep.deletePost(postid);

      emit(deletePostSuccess());
    } catch (e) {
      emit(deletePostFailure(e.toString()));
    }
  }

/*
  Future<void> addPost(
    String bookName,
    String bookPage,
    String questionNo,
    String content,
    int groupId,
  ) async {
    try {
      emit(addPostLoading());

      final jsonData = await Apiser.postdio(
        url: "$baseurl/student/storePost?token=${prefs!.getString("token")}",
        data: {
          'book': bookName,
          'book_page': bookPage,
          'question_no': questionNo,
          'content': content,
          'group_id': groupId,
        },
      );

      // Handle the response data as needed
      // ...

      emit(addPostSuccess());
    } catch (e) {
      print(e.toString());
      emit(addPostFailure("errorrrrr"));
    }
  }*/
}
