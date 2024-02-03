abstract class checkEsixtStates {}

class checkExistInitialState extends checkEsixtStates {}

class checkExistLoadinglState extends checkEsixtStates {}

class checkExistSucceslState extends checkEsixtStates {
  bool? isExist;

  checkExistSucceslState(this.isExist);
}

class checkExistErrorState extends checkEsixtStates {
  dynamic error;
  checkExistErrorState(this.error);
}
