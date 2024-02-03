import 'package:bloc/bloc.dart';

import '../../data/repo/grouprepo.dart';
import 'states.dart';

class notificationCubit extends Cubit<getnotificationStates> {
  notificationCubit(this.grouprep) : super(notifcationinitialState());
  final gruouprepo grouprep;

  Future<void> fetchNotifications() async {
    emit(notifcationLoadinglState());
    var result = await grouprep.getNotifcation();
    result.fold((failure) {
      emit(notifcationfailuerState(failure.errormessage));
    }, (notifs) {
      emit(notifcationSucceslState(notifs));
    });
  }
}
