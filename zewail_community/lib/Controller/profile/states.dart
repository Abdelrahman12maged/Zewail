import '../../data/models/PostsModel.dart';

abstract class UserStates {}

class getUserInitialState extends UserStates {}

class getUserLoadinglState extends UserStates {}

class getUserSucceslState extends UserStates {}

class getUserFailure extends UserStates {
  final String erro;

  getUserFailure(this.erro);
}

class postsUserInitialState extends UserStates {}

class postsUserLoadinglState extends UserStates {}

class postsUserSucceslState extends UserStates {
  final List<PostsModel> posts;

  postsUserSucceslState(this.posts);
}

class postsUserFailure extends UserStates {
  final String erro;

  postsUserFailure(this.erro);
}

class postSelectedstid extends UserStates {
  final int stid;

  postSelectedstid({required this.stid});
}

class deleteUserPostLoading extends UserStates {}

class deleteUserPostSuccess extends UserStates {}

class deleteUserPostFailure extends UserStates {
  final String erro;

  deleteUserPostFailure(this.erro);
}
