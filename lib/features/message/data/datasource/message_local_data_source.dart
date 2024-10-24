import 'dart:convert';

import 'package:chatapp/core/error/exception.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/mesage_model.dart';

abstract class MessageLocalDataSource {
  Future<Unit> cachedMessages(
      {required List<MessageModel> allmessages, required String chatid});
  Future<List<MessageModel>> getcachedMessage({required String chatid});
}

class MessageLocalDataSourceImpl implements MessageLocalDataSource {
  final SharedPreferences sharedPreferences;

  MessageLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<Unit> cachedMessages(
      {required List<MessageModel> allmessages, required String chatid}) {
    print("saved------------------- 111");
    List messagemodeltojson =
        allmessages.map<Map<String, dynamic>>((e) => e.toFirestore()).toList();
    print("saved---------------------- 22222");
    sharedPreferences.setString(chatid, json.encode(messagemodeltojson));

    print("saved---------------------- saved ok");
    print("saved-------------- $chatid");
    return Future.value(unit);
  }

  @override
  Future<List<MessageModel>> getcachedMessage({required String chatid}) {
    print("get ----------------- 22");
    final messageString = sharedPreferences.getString(chatid);
    if (messageString != null) {
      print("get ----------------- 33");
      List decodejsonData = json.decode(messageString);
      List<MessageModel> allMessage = decodejsonData
          .map<MessageModel>((e) => MessageModel.fromjson(e))
          .toList();
      print("get ----------------- 44");
      return Future.value(allMessage);
    } else {
      throw EmptyMessageException();
    }
  }
}
