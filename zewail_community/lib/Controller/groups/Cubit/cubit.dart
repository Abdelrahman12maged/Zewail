import 'package:flutter_bloc/flutter_bloc.dart';
import 'states.dart';
import '../../../Core/Shared/sharedpref.dart';
import '../../../Core/errors/faliure.dart';
import '../../../data/repo/groupRepoimp.dart';
import '../../../data/repo/grouprepo.dart';

class groupCubit extends Cubit<groupStates> {
  groupCubit(this.grouprep) : super(groupInitialState());
  final gruouprepo grouprep;

  Future<void> fetchgroups() async {
    emit(groupLoadinglState());
    var result = await grouprep.fetchAllgroups();
    result.fold((failure) {
      emit(groupfailuerState(failure.errormessage));
    }, (groups) {
      emit(groupSucceslState(groups));
    });
  }
}
