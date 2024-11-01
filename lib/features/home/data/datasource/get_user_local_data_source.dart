import 'dart:convert';

import 'package:chatapp/core/error/exception.dart';
import 'package:chatapp/core/strings/strings.dart';
import 'package:chatapp/features/home/data/model/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class GetUserLocalDataSource {
  Future<Unit> cachedusers(List<UsersModel> Allusers);
  Future<List<UsersModel>> getcachedusers();
}

class GetUserLocalDataSourceImpl implements GetUserLocalDataSource {
  final SharedPreferences sharedPreferences;

  GetUserLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<Unit> cachedusers(List<UsersModel> Allusers) {
    List postModelToJson = Allusers.map<Map<String, dynamic>>(
      (e) => e.tojson(),
    ).toList();
    sharedPreferences.setString(cached_user, json.encode(postModelToJson));
    return Future.value(unit);
  }

  @override
  Future<List<UsersModel>> getcachedusers() async {
    final jsonString = sharedPreferences.getString(cached_user);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<UsersModel> Allusers = decodeJsonData
          .map<UsersModel>((e) => UsersModel.fromjson(e))
          .toList();
      return Future.value(Allusers);
    } else {
      throw EmptyUserException();
    }
  }
}
