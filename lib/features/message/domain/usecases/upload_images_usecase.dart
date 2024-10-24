import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/features/message/domain/repostories/message_repostories.dart';
import 'package:dartz/dartz.dart';

class UploadImagesUsecase {
  final MessageRepostories messageRepostories;

  UploadImagesUsecase({required this.messageRepostories});

  Future<Either<Failure, List<String>>> uploadImages(
      {required List<String> images}) async {
    return await messageRepostories.uploadImages(images: images);
  }
}
