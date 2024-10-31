import 'package:chatapp/features/message/domain/entities/message_entites.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel extends MessageEntites {
  const MessageModel(
      {required super.senderid,
      required super.messageId,
      required super.content,
      required super.timestamp,
      required super.messageType,
      required super.readType,
      super.replyMessage});

  factory MessageModel.fromjson(Map<String, dynamic> json) {
    return MessageModel(
        senderid: json['senderId'],
        messageId: json['messageId'],
        content: json['content'],
        timestamp: json['timestamp'] is Timestamp
            ? (json['timestamp'] as Timestamp).toDate()
            : DateTime.parse(json['timestamp']),
        //DateTime.parse(json['timestamp']),
        messageType: json['messageType'],
        readType: json['readStatus'],
        replyMessage: json['replyMessage']);
  }
  Map<String, dynamic> toFirestore() => {
        'senderId': senderid,
        'messageId': messageId,
        'content': content,
        'timestamp': timestamp.toIso8601String(),
        'messageType': messageType,
        'readStatus': readType,
        'replyMessage': replyMessage
      };
}

 