abstract class unreadStates {}

class unreadInitialState extends unreadStates {}

class unreadLoadinglState extends unreadStates {}

class unreadSucceslState extends unreadStates {
  int? counts;

  unreadSucceslState(this.counts);
}

class unreadfailuerState extends unreadStates {
  final String error;
  unreadfailuerState(this.error);
}
