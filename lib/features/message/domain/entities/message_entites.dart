import 'package:equatable/equatable.dart';

class MessageEntites extends Equatable {
  final String senderid;
  final String? messageId;
  final dynamic content;
  final DateTime timestamp;
  final String messageType;
  final bool readType;
  final Map? replyMessage;

  const MessageEntites(
      {required this.senderid,
      this.messageId,
      required this.content,
      required this.timestamp,
      required this.messageType,
      required this.readType,
      this.replyMessage});

  @override
  // TODO: implement props
  // List<Object?> get props => throw UnimplementedError();

  @override
  List<Object?> get props => [
        senderid,
        messageId,
        content,
        timestamp,
        content,
        readType,
        replyMessage
      ];
}
