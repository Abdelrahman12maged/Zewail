import 'package:bloc/bloc.dart';

import '../../data/models/PostsModel.dart';
import '../../data/models/UserModel.dart';
import '../../data/repo/PostsRepo.dart';
import 'states.dart';

class getUserCubit extends Cubit<UserStates> {
  getUserCubit(
    this.postrep,
  ) : super(getUserInitialState());

  final postrepo postrep;
  int currentPage = 1;
  int loadedPostsCount = 0;
  bool isLoading = false;
  bool hasMoreData = true;
  List<PostsModel> posts = [];
  bool isLoadingMore = false;
  Future<void> fetchStudentPosts(int stid) async {
    emit(postsUserLoadinglState());
    currentPage = 1;
    loadedPostsCount = 0;
    isLoading = true;
    hasMoreData = true; // إعادة تعيين حالة وجود المزيد من البيانات
    posts = []; // إعادة تعيين قائمة البوستات

    var result = await postrep.fetchAllStudentPosts(stid, currentPage);
    result.fold((failure) {
      emit(postsUserFailure(failure.errormessage));
    }, (fetchedPosts) {
      loadedPostsCount = fetchedPosts.length;
      if (fetchedPosts.length == 0) {
        hasMoreData = false;
      }
      isLoading = false;
      posts.addAll(fetchedPosts); // إضافة البوستات المحملة إلى القائمة
      emit(postsUserSucceslState(posts));
    });
  }

  int? stid;
  Future<void> loadMorePosts(stid) async {
    if (isLoading || !hasMoreData) {
      return;
    }

    isLoadingMore = true; // تعيين حالة التحميل عند الضغط على زر "Load More"
    currentPage++;

    var result = await postrep.fetchAllStudentPosts(stid, currentPage);
    result.fold((failure) {
      isLoadingMore = false;
      emit(postsUserFailure(failure.errormessage));
    }, (newPosts) {
      loadedPostsCount += newPosts.length;
      if (newPosts.length == 0) {
        hasMoreData = false;
      }
      isLoadingMore = false;
      posts.addAll(newPosts); // إضافة البوستات الجديدة إلى القائمة
      emit(postsUserSucceslState(posts));
    });
  }

  Future<void> deletePost(int postid) async {
    emit(deleteUserPostLoading());
    try {
      var result = await postrep.deletePost(postid);

      emit(deleteUserPostSuccess());
    } catch (e) {
      emit(deleteUserPostFailure(e.toString()));
    }
  }

///////////////////////////////
  UserModel? userr;
  Future<void> getuserData() async {
    emit(getUserLoadinglState());
    try {
      var result = await postrep.fetchUser();
      result.fold((failure) {
        emit(getUserFailure(failure.errormessage));
      }, (user) {
        userr = user;
        emit(getUserSucceslState());
      });
    } catch (e) {
      emit(getUserFailure(e.toString()));
    }
  }
}
