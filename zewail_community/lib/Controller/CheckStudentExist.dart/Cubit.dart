import 'package:bloc/bloc.dart';
import '../../data/repo/Authrepo.dart';

import '../../Core/Function/Api.dart';
import 'States.dart';

class CheckECubit extends Cubit<checkEsixtStates> {
  CheckECubit(this.authrep) : super(checkExistInitialState());
  final authrepo authrep;
  checkExist(
    String number,
  ) async {
    emit(checkExistLoadinglState());

    var result = await authrep.checkStudentExist(number);

    result.fold((failure) {
      emit(checkExistErrorState(failure.errormessage));
    }, (sucess) {
      emit(checkExistSucceslState(sucess));
    });
  }
}
