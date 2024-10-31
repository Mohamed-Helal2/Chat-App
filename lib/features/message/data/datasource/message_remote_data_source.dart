import 'dart:async';
import 'dart:io';

import 'package:chatapp/features/message/data/model/mesage_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

abstract class MessageRemoteDataSource {
  Future<void> sendmessage(
      {required String chatId,
      required MessageModel message,
      required Map between});
  Stream<List<MessageModel>> getMessages({required String chatId});
  Future<List<String>> uploadImages({required List<String> images});
  Future<String> UploadRecord(
      {required String audioname, required String audiopath});
  Future<String> uploadpdf({required String pdfpath});
}

class MessageRemoteDatSourceImpl implements MessageRemoteDataSource {
  @override
  Future<void> sendmessage(
      {required String chatId,
      required MessageModel message,
      required Map between}) async {
    DocumentReference messageRef = FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc(message.messageId);
    await messageRef.set(message.toFirestore());
    await FirebaseFirestore.instance.collection('chats').doc(chatId).update({
      'lastMessage': message.content,
      'lastMessageTimestamp': message.timestamp,
      'lastMessageFrom': message.senderid,
      'lastMessageID': message.messageId,
      'lastMessageType': message.messageType,
      'lastMessageRead': message.readType,
      'participants': between,
      'chatid': chatId
       
    });
  }
 
  @override
  Stream<List<MessageModel>> getMessages({required String chatId}) {
    return FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .asyncMap((snapshot) async {
       
      return snapshot.docs
          .map((doc) => MessageModel.fromjson(doc.data()))
          .toList();
    });
  }
 

  @override
  Future<List<String>> uploadImages({required List<String> images}) async {
    List<String> photourl = [];
    for (var image in images) {
      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      String imageName = "${basename(image)}_$timestamp";
      final storageRef =
          FirebaseStorage.instance.ref("messages Between Users/$imageName");
      await storageRef.putFile(File(image));
      String url = await storageRef.getDownloadURL();
      photourl.add(url);
    }
    return photourl;
  }

  Future<String> UploadRecord(
      {required String audioname, required String audiopath}) async {
    final storageRef =
        FirebaseStorage.instance.ref("audio Between Users/$audioname");
    File file = File(audiopath);
    await storageRef.putFile(file);
    String url = await storageRef.getDownloadURL();
    return url;
  }

  @override
  Future<String> uploadpdf({required String pdfpath}) async {
    final String pdfname = DateTime.now().millisecondsSinceEpoch.toString();

    final storageRef =
        FirebaseStorage.instance.ref("File Between Users/$pdfname");
    File file = File(pdfpath);
    await storageRef.putFile(file);
    String url = await storageRef.getDownloadURL();
    return url;
  }
}
