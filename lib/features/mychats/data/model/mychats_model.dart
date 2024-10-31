import 'package:chatapp/features/mychats/domain/entites/mychats_entities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyChatsModel extends MychatsEntities {
  const MyChatsModel(
      {required super.chatid,
      required super.lastMessage,
      required super.lastMessageFrom,
      required super.lastMessageID,
      required super.lastMessageRead,
      required super.lastMessageTimestamp,
      required super.lastMessageType,
      required super.participants,
      required super.otherParticipantName,
      super.otherParticipantPhotoUrl,
      required super.otherParticipantEmail,
      required super.otherParticipantId,
      required super.otherParticipantInchat});

  factory MyChatsModel.fromJson(Map<String, dynamic> json) {
    final participants = json['participants'] as Map<String, dynamic>;
    final myid = FirebaseAuth.instance.currentUser!.uid;

    final otherParticipantEntry = participants.entries
        .firstWhere((entry) => entry.key != myid)
        .value as Map<String, dynamic>;
    return MyChatsModel(
        chatid: json['chatid'] as String,
        lastMessage: json['lastMessage'],
        lastMessageFrom: json['lastMessageFrom'] as String,
        lastMessageID: json['lastMessageID'] as String,
        lastMessageRead: json['lastMessageRead'] as bool,
        lastMessageTimestamp:
            (json['lastMessageTimestamp'] as Timestamp).toDate(),
        lastMessageType: json['lastMessageType'] as String,
        participants: (json['participants'] as Map<String, dynamic>).map(
          (key, value) => MapEntry(key, ParticipantModel.fromJson(value)),
        ),
        otherParticipantName: otherParticipantEntry['Name'] as String,
        otherParticipantPhotoUrl: otherParticipantEntry['photoUrl'] as String,
        otherParticipantEmail: otherParticipantEntry['email'] as String,
        otherParticipantId: otherParticipantEntry['id'] as String,
        otherParticipantInchat: otherParticipantEntry['isInChat'] as bool);
  }

  Map<String, dynamic> toFirestore() => {
        'chatid': chatid,
        'lastMessage': lastMessage,
        'lastMessageFrom': lastMessageFrom,
        'lastMessageID': lastMessageID,
        'lastMessageRead': lastMessageRead,
        'lastMessageTimestamp': lastMessageTimestamp,
        'lastMessageType': lastMessageType,
        'participants': participants
            .map((key, value) => MapEntry(key, value.toFirestore())),
        'otherParticipantName': otherParticipantName,
        'otherParticipantPhotoUrl': otherParticipantPhotoUrl,
      };
}

class ParticipantModel extends Participantentites {
  const ParticipantModel(
      {required super.name,
      super.photoUrl,
      required super.email,
      required super.isinchat,
      required super.id});

  factory ParticipantModel.fromJson(Map<String, dynamic> json) {
    return ParticipantModel(
      name: json['Name'] as String,
      photoUrl: json['photoUrl'] as String,
      email: json['email'] as String,
      id: json['id'] as String,
      isinchat: json['isInChat'] as bool,
    );
  }

  Map<String, dynamic> toFirestore() => {
        'Name': name,
        'photoUrl': photoUrl,
        'email': email,
        'id': id,
        'isInChat': isinchat,
      };
}
