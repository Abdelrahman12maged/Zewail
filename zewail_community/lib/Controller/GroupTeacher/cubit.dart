import 'package:bloc/bloc.dart';

import '../../data/repo/grouprepo.dart';
import 'States.dart';

class groupTeacherCubit extends Cubit<groupTeacherStates> {
  groupTeacherCubit(this.grouprep) : super(groupTeacherinitialState());
  final gruouprepo grouprep;

  Future<void> fetchgroupsTeacher() async {
    emit(groupTeacherLoadinglState());
    var result = await grouprep.fetchAllgroupsTeacher();
    result.fold((failure) {
      emit(groupTeacherfailuerState(failure.errormessage));
    }, (groups) {
      emit(groupTeacherSucceslState(groups));
    });
  }
}
