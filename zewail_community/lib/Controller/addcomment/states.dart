import '../../data/models/PostDatamodel.dart';

abstract class addcommentStates {}

class addcommentInitial extends addcommentStates {}

class addcommentLoading extends addcommentStates {}

class addcommentSuccess extends addcommentStates {
  final PostdataModel msg;

  addcommentSuccess(this.msg);
}

class addcommentFailure extends addcommentStates {
  final String erro;

  addcommentFailure(this.erro);
}

class addReocrdLoading extends addcommentStates {}

class addRecordSuccess extends addcommentStates {}

class addRecordFailure extends addcommentStates {
  final String erro;

  addRecordFailure(this.erro);
}

class getpostInitialState extends addcommentStates {}

class getpostLoadinglState extends addcommentStates {}

class getpostSucceslState extends addcommentStates {}

class getpostFailure extends addcommentStates {
  final String erro;

  getpostFailure(this.erro);
}

class deleteCommentLoading extends addcommentStates {}

class deleteCommentSuccess extends addcommentStates {}

class deleteCommentFailure extends addcommentStates {
  final String erro;

  deleteCommentFailure(this.erro);
}



/*
class commentInitialState extends addcommentStates {}

class commentLoadinglState extends addcommentStates {}

class commentSucceslState extends addcommentStates {
  final CommentsModel comments;

  commentSucceslState(this.comments);
}

class commentfailuerState extends addcommentStates {
  final String error;
  commentfailuerState(this.error);
}*/
