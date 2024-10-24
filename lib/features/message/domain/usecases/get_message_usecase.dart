import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/features/message/domain/entities/message_entites.dart';
import 'package:chatapp/features/message/domain/repostories/message_repostories.dart';
import 'package:dartz/dartz.dart';

class GetMessageUsecase {
  final MessageRepostories messageRepostories;

  GetMessageUsecase({required this.messageRepostories});
  Stream<Either<Failure, List<MessageEntites>>> getmessage(
      {required String chatId}) {
    return messageRepostories.getMessages(chatId: chatId);
  }
}
