import 'package:bloc/bloc.dart';

import '../../data/models/BooksModel.dart';
import '../../data/repo/PostsRepo.dart';
import 'states.dart';

class booksCubit extends Cubit<bookStates> {
  booksCubit(
    this.postrep,
  ) : super(BooksInitiaState());

  final postrepo postrep;

  BooksModel? bookss;
  Future<void> getbooks(int gid) async {
    emit(BooksLoadingState());
    try {
      var result = await postrep.fetchBooks(gid);
      result.fold((failure) {
        emit(BookFailure(failure.errormessage));
      }, (books) {
        bookss = books;
        emit(BooksSuccesState());
      });
    } catch (e) {
      emit(BookFailure(e.toString()));
    }
  }
}
