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
    List messagemodeltojson =
        allmessages.map<Map<String, dynamic>>((e) => e.toFirestore()).toList();
    sharedPreferences.setString(chatid, json.encode(messagemodeltojson));

    return Future.value(unit);
  }

  @override
  Future<List<MessageModel>> getcachedMessage({required String chatid}) {
     final messageString = sharedPreferences.getString(chatid);
    if (messageString != null) {
       List decodejsonData = json.decode(messageString);
      List<MessageModel> allMessage = decodejsonData
          .map<MessageModel>((e) => MessageModel.fromjson(e))
          .toList();
       return Future.value(allMessage);
    } else {
      throw EmptyMessageException();
    }
  }
}
