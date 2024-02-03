import '../../data/models/notification.dart';

abstract class getnotificationStates {}

class notifcationinitialState extends getnotificationStates {}

class notifcationLoadinglState extends getnotificationStates {}

class notifcationSucceslState extends getnotificationStates {
  final notificationModel notifs;

  notifcationSucceslState(this.notifs);
}

class notifcationfailuerState extends getnotificationStates {
  final String error;
  notifcationfailuerState(this.error);
}
