abstract class bookStates {}

class BooksInitiaState extends bookStates {}

class BooksLoadingState extends bookStates {}

class BooksSuccesState extends bookStates {
//  final BooksModel bookmodel;

  //BooksSucceslState(
  //   this.bookmodel,
//  );
}

class BookFailure extends bookStates {
  final String erro;

  BookFailure(this.erro);
}
