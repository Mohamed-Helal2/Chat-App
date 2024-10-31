import 'package:equatable/equatable.dart';

// Entity class for chat data
class MychatsEntities extends Equatable {
  final String chatid;
  final dynamic lastMessage;
  final String lastMessageFrom;
  final String lastMessageID;
  final bool lastMessageRead;
  final DateTime lastMessageTimestamp;
  final String lastMessageType;
  final String otherParticipantName;
  final String otherParticipantId;
  final String otherParticipantEmail;
  final bool otherParticipantInchat;

  final String? otherParticipantPhotoUrl;
  final Map<String, Participantentites> participants;

  const MychatsEntities(
      {required this.chatid,
      required this.lastMessage,
      required this.lastMessageFrom,
      required this.lastMessageID,
      required this.lastMessageRead,
      required this.lastMessageTimestamp,
      required this.lastMessageType,
      required this.participants,
      required this.otherParticipantName,
      this.otherParticipantPhotoUrl,
      required this.otherParticipantEmail,
      required this.otherParticipantId,
      required this.otherParticipantInchat
      });

  @override
  List<Object?> get props => [
        chatid,
        lastMessage,
        lastMessageFrom,
        lastMessageID,
        lastMessageRead,
        lastMessageTimestamp,
        lastMessageType,
        participants,
        otherParticipantName,
        otherParticipantPhotoUrl,
        otherParticipantInchat
      ];
}

// Entity class for participant data with added toFirestore method
class Participantentites extends Equatable {
  final String name;
  final String? photoUrl;
    final String id;

  final String? email;
    final bool isinchat;

  const Participantentites({
    required this.name,
    required this.email,
    required this.id,
    required this.isinchat,
    this.photoUrl,
  });

  Map<String, dynamic> toFirestore() => {
        'Name': name,
        'photoUrl': photoUrl,
        'id':id,
        'email':email,
        'isInChat':isinchat
      };

  @override
  List<Object?> get props => [name, photoUrl,email,id,isinchat];
}
