import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/features/message/domain/repostories/message_repostories.dart';
import 'package:dartz/dartz.dart';

class UploadAudioUsecase {
  final MessageRepostories messageRepostories;
  UploadAudioUsecase({required this.messageRepostories});
  Future<Either<Failure, String>> uploadAudio(
      {required String audiopath,required String audioname}) async {
    return await messageRepostories.uploadaudio(audiopath: audiopath,audioname: audioname);
  }
}
