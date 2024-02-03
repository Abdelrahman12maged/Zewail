import '../../data/models/PostDatamodel.dart';

abstract class addpostStates {}

class addPostInitial extends addpostStates {}

class addPostLoading extends addpostStates {}

class addPostSuccess extends addpostStates {
  final PostdataModel msg;

  addPostSuccess(this.msg);
}

class addPostFailure extends addpostStates {
  final dynamic erro;

  addPostFailure(this.erro);
}

class updatePostLoading extends addpostStates {}

class updatePostSuccess extends addpostStates {}

class updatePostFailure extends addpostStates {
  final String erro;

  updatePostFailure(this.erro);
}

class BooksInitialState extends addpostStates {}

class BooksLoadinglState extends addpostStates {}

class BooksSucceslState extends addpostStates {
//  final BooksModel bookmodel;

  //BooksSucceslState(
  //   this.bookmodel,
//  );
}

class BooksFailure extends addpostStates {
  final String erro;

  BooksFailure(this.erro);
}
