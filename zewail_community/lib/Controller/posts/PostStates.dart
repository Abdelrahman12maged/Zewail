import '../../data/models/PostsModel.dart';

abstract class postStates {}

class PostInitialState extends postStates {}

class PostLoadinglState extends postStates {}

class PostSucceslState extends postStates {
  final List<PostsModel> posts;

  PostSucceslState(this.posts);
}

class PostfailuerState extends postStates {
  final String error;
  PostfailuerState(this.error);
}

class postSelectedgrouid extends postStates {
  final int groupid;

  postSelectedgrouid({required this.groupid});
}

class postSelected extends postStates {
  final String groupName;

  postSelected({required this.groupName});
}

class deletePostInitial extends postStates {}

class deletePostLoading extends postStates {}

class deletePostSuccess extends postStates {}

class deletePostFailure extends postStates {
  final String erro;

  deletePostFailure(this.erro);
}
