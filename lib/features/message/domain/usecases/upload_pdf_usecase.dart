import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/features/message/domain/repostories/message_repostories.dart';
import 'package:dartz/dartz.dart';

class UploadPdfUsecase {
  final MessageRepostories messageRepostories;
  UploadPdfUsecase({required this.messageRepostories});
   Future<Either<Failure,  Map<String,dynamic>>> UploadPd( ) async {
  return  await messageRepostories.uploadPdf( );
  }
}
