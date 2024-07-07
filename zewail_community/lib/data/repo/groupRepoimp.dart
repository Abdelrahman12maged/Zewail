import 'dart:convert';

import 'package:dio/dio.dart';
import '../../Core/Constant/constants.dart';
import '../../Core/Constant/links.dart';
import '../../Core/Function/Api.dart';
import '../../Core/Function/Api.dart';
import '../models/Groups_model.dart';
import '../../Core/errors/faliure.dart';
import 'package:dartz/dartz.dart';
import '../models/notification.dart';
import 'grouprepo.dart';
import '../models/UserModel.dart';
import '../models/PostsModel.dart';
import '../../main.dart';

import '../models/GroupsTeacherModel.dart';

class groupRepoim implements gruouprepo {
  @override
  final Apiservice Apiser;

  groupRepoim(this.Apiser);

  @override
  Future<Either<failure, List<GroupModel>>> fetchAllgroups() async {
    try {
      String url =
          "$baseurl/student/getGroups?token=${prefs!.getString("token")}";

      var jsonData = await Apiser.getdio(url: url);

      final List<GroupModel> groups = [];

// final List<dynamic> groupsData = jsonData["data"]['groups'];

      for (var groupData in jsonData["data"]['groups']) {
        final GroupModel group = GroupModel.fromJson(groupData);

        groups.add(group);
      }

      return right(groups);
    } catch (e) {
      if (e is DioException) {
        return left(serverFailure.fromDioerro(e));
      }
      return left(serverFailure(e.toString()));
    }

    // throw UnimplementedError();
  }

  @override
  Future<Either<failure, List<GroupTeacherModel>>>
      fetchAllgroupsTeacher() async {
    try {
      String url =
          "$baseurl/teacher/";
      var jsonData = await Apiser.getdio(url: url);
      final List<GroupTeacherModel> groups = [];

// final List<dynamic> groupsData = jsonData["data"]['groups'];

      for (var groupData in jsonData["data"]['groups']) {
        final GroupTeacherModel group = GroupTeacherModel.fromJson(groupData);
        groups.add(group);
      }

      print(jsonData);
      return right(groups);
    } catch (e) {
      if (e is DioException) {
        return left(serverFailure.fromDioerro(e));
      }
      return left(serverFailure(e.toString()));
    }
  }

  @override
  Future<Either<failure, int?>> fetchUnreadnotif() async {
    try {
      var jsonData = await Apiser.getdio(
          url:
              "$baseurl/student/");

      int? unread = jsonData['count'];
      return right(unread);
    } catch (e) {
      if (e is DioException) {
        return left(serverFailure.fromDioerro(e));
      }
      return left(serverFailure(e.toString()));
    }
  }

  @override
  Future<Either<failure, notificationModel>> getNotifcation() async {
    try {
      var jsonData = await Apiser.getdio(
          url:
              "$baseurl/student/");

      final notificationModel notifs = notificationModel.fromJson(jsonData);
      //   print(jsonData);
      return right(notifs);
    } catch (e) {
      if (e is DioException) {
        return left(serverFailure.fromDioerro(e));
      }
      return left(serverFailure(e.toString()));
    }
  }
}
