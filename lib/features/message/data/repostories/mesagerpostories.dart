
import 'package:chatapp/core/error/exception.dart';
import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/core/error/network/network_info.dart';
import 'package:chatapp/features/message/data/datasource/message_local_data_source.dart';
import 'package:chatapp/features/message/data/datasource/message_remote_data_source.dart';
import 'package:chatapp/features/message/data/model/mesage_model.dart';
import 'package:chatapp/features/message/domain/entities/message_entites.dart';
import 'package:chatapp/features/message/domain/repostories/message_repostories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';

class MesagerpostoriesImpl implements MessageRepostories {
  final MessageRemoteDataSource messageRemoteDatSource;
  final MessageLocalDataSource messageLocalDataSource;
  final NetworkInfo networkInfo;

  MesagerpostoriesImpl(
      {required this.messageRemoteDatSource,
      required this.networkInfo,
      required this.messageLocalDataSource});
  @override
  Future<Either<Failure, Unit>> sendMessage(
      {required String chatid, required MessageEntites messageentities}) async {
    if (await networkInfo.isconnected) {
      try {
        final MessageModel messageModel = MessageModel(
            senderid: messageentities.senderid,
            messageId: messageentities.messageId,
            content: messageentities.content,
            timestamp: messageentities.timestamp,
            messageType: messageentities.messageType,
            readType: messageentities.readType,
            replyMessage: messageentities.replyMessage);

        await messageRemoteDatSource.sendmessage(
            chatId: chatid, message: messageModel);
        return right(unit);
      } on FirebaseException catch (e) {
        return left(FirebaseFailure(message: e.message));
      }
    } else {
      return left(OffLineFailure());
    }
  }

  @override
  Stream<Either<Failure, List<MessageEntites>>> getMessages(
      {required String chatId}) async* {
    if (await networkInfo.isconnected) {
      try {
        print("------------------ 44");
        yield* messageRemoteDatSource
            .getMessages(chatId: chatId)
            .map((messages) {
          List<MessageEntites> allmessage = messages
              .map((msg) => MessageEntites(
                  senderid: msg.senderid,
                  messageId: msg.messageId,
                  content: msg.content,
                  timestamp: msg.timestamp,
                  messageType: msg.messageType,
                  readType: msg.readType,
                  replyMessage: msg.replyMessage))
              .toList();
          print("------------------------- 99");
          messageLocalDataSource.cachedMessages(
              allmessages: messages, chatid: chatId);
          return right(allmessage);
        });
      } on FirebaseException catch (e) {
        yield left(FirebaseFailure(message: e.message));
      }
    } else {
      try {
        print("get 222-----------------$chatId");
        final localMessage =
            await messageLocalDataSource.getcachedMessage(chatid: chatId);
        yield right(localMessage);
      } on EmptyMessageException {
        print("----------------- emoooooooooo ");
        yield left(EmptyMessageFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<String>>> uploadImages(
      {required List<String> images}) async {
    if (await networkInfo.isconnected) {
      try {
        final response =
            await messageRemoteDatSource.uploadImages(images: images);
        return right(response);
      } on FirebaseException catch (e) {
        return left(FirebaseFailure(message: e.message));
      }
    } else {
      return left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, String>> uploadaudio(
      {required String audioname, required String audiopath}) async {
    if (await networkInfo.isconnected) {
      try {
        final response = await messageRemoteDatSource.UploadRecord(
            audioname: audioname, audiopath: audiopath);
        return right(response);
      } on FirebaseException catch (e) {
        return left(FirebaseFailure(message: e.message));
      }
    } else {
      return left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, Map<String,dynamic>>> uploadPdf() async {
    try {
      final result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf'],
          allowMultiple: false);
      if (result != null) {
     String   filename = result.files.first.name;
        var pickedFile = result.files.first;
        String? pickedFilePath = pickedFile.path;
        final pdfUrl =
            await messageRemoteDatSource.uploadpdf(pdfpath: pickedFilePath!);
        // String filename = result.files.first.name;
        // var  pickedfile = result.files.first;
        // var  filetodisplay = File(pickedfile.path.toString());
        return right({
          'PdfUrl': pdfUrl,
          'pdfName':filename
        });
      } else {
        return left(getpdfFailure());
      }
    } on FirebaseException catch (e) {
      return left(FirebaseFailure(message: e.message));
    }
  }
}
