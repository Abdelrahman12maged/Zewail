import '../../data/models/GroupsTeacherModel.dart';

abstract class groupTeacherStates {}

class groupTeacherinitialState extends groupTeacherStates {}

class groupTeacherLoadinglState extends groupTeacherStates {}

class groupTeacherSucceslState extends groupTeacherStates {
  final List<GroupTeacherModel> groups;

  groupTeacherSucceslState(this.groups);
}

class groupTeacherfailuerState extends groupTeacherStates {
  final String error;
  groupTeacherfailuerState(this.error);
}
