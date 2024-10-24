import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/features/message/domain/entities/message_entites.dart';
import 'package:dartz/dartz.dart';

abstract class MessageRepostories {
  Future<Either<Failure, Unit>> sendMessage(
      {required String chatid, required MessageEntites messageentities});
  Stream<Either<Failure, List<MessageEntites>>> getMessages(
      {required String chatId});
  Future<Either<Failure, List<String>>> uploadImages(
      {required List<String> images});
  Future<Either<Failure, String>> uploadaudio(
      {required String audiopath, required String audioname});
  Future<Either<Failure, Map<String,dynamic>>> uploadPdf( );
}
