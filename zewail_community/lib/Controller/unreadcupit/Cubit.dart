import 'package:bloc/bloc.dart';
import 'States.dart';

import '../../data/repo/grouprepo.dart';

class unreadCubit extends Cubit<unreadStates> {
  unreadCubit(this.grouprep) : super(unreadInitialState());
  final gruouprepo grouprep;

  Future<void> fetchUnreadnotif() async {
    emit(unreadLoadinglState());
    var result = await grouprep.fetchUnreadnotif();
    result.fold((failure) {
      emit(unreadfailuerState(failure.errormessage));
    }, (count) {
      emit(unreadSucceslState(count));
    });
  }
}
