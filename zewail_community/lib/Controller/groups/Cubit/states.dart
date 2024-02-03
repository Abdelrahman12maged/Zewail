import '../../../data/models/Groups_model.dart';

abstract class groupStates {}

class groupInitialState extends groupStates {}

class groupLoadinglState extends groupStates {}

class groupSucceslState extends groupStates {
  final List<GroupModel> groups;

  groupSucceslState(this.groups);
}

class groupfailuerState extends groupStates {
  final String error;
  groupfailuerState(this.error);
}
