import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/features/message/domain/entities/message_entites.dart';
import 'package:chatapp/features/message/domain/repostories/message_repostories.dart';
import 'package:dartz/dartz.dart';

class SendMessageUsecase {
  final MessageRepostories messageRepostories;

  SendMessageUsecase({required this.messageRepostories});
  Future<Either<Failure, Unit>> sendMessage({required  String chatid,
  required MessageEntites messageentities,required Map between}) async {
    return await messageRepostories.sendMessage(chatid: chatid,
    messageentities: messageentities,between: between);
  }
  
}
