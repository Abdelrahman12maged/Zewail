import 'package:dartz/dartz.dart';
import '../../Core/errors/faliure.dart';
import '../models/Groups_model.dart';
import '../models/UserModel.dart';
import '../models/PostsModel.dart';
import '../models/notification.dart';

import '../models/GroupsTeacherModel.dart';

abstract class gruouprepo {
  Future<Either<failure, List<GroupModel>>> fetchAllgroups();
  Future<Either<failure, List<GroupTeacherModel>>> fetchAllgroupsTeacher();
  Future<Either<failure, int?>> fetchUnreadnotif();
  Future<Either<failure, notificationModel>> getNotifcation();
}
