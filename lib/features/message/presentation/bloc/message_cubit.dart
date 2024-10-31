import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:chatapp/core/error/erro_strings.dart';
import 'package:chatapp/core/error/failure.dart';
import 'package:chatapp/features/home/domain/entities/user_entites.dart';
import 'package:chatapp/features/message/data/model/mesage_model.dart';
import 'package:chatapp/features/message/data/repostories/record_repostories.dart';
import 'package:chatapp/features/message/domain/entities/message_entites.dart';
import 'package:chatapp/features/message/domain/usecases/get_message_usecase.dart';
import 'package:chatapp/features/message/domain/usecases/send_message_usecase.dart';
import 'package:chatapp/features/message/domain/usecases/upload_audio_usecase.dart';
import 'package:chatapp/features/message/domain/usecases/upload_images_usecase.dart';
import 'package:chatapp/features/message/domain/usecases/upload_my_location_usecase.dart';
import 'package:chatapp/features/message/domain/usecases/upload_pdf_usecase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:image_picker/image_picker.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  MessageCubit(
      {required this.sendMessageUsecase,
      required this.getMessageUsecase,
      required this.uploadImagesUsecase,
      required this.recordRepository,
      required this.uploadAudioUsecase,
      required this.getMyLocationUseCase,
      required this.uploadPdfUsecase})
      : super(MessageInitial());
  final SendMessageUsecase sendMessageUsecase;
  final GetMessageUsecase getMessageUsecase;
  final UploadImagesUsecase uploadImagesUsecase;
  final UploadAudioUsecase uploadAudioUsecase;
  final GetMyLocationUseCase getMyLocationUseCase;
  final UploadPdfUsecase uploadPdfUsecase;
  final RecordRepository recordRepository;
  TextEditingController messagecontroller = TextEditingController();
  final ScrollController listscrollcontroler = ScrollController();
  FocusNode focusNode = FocusNode();
  MessageEntites? replyMessage;
  bool isMic = true;
  bool isshowemoji = false;
  final picker = ImagePicker();
  final PageController pageController = PageController();
  int photonumber = 0;
  TextEditingController photocaptioncontroller = TextEditingController();
  double micIconSize = 25;
  Color micColor = const Color.fromARGB(255, 152, 152, 167);
  bool isrecord = false;
  final recorder = FlutterSoundRecorder();
  String? recordername;
  // play audio
  int audiotime = 0;
  // final AudioPlayer audioPlayer = AudioPlayer();

  List<AudioPlayer> audioPlayers = [];
  List<int?> audioDurations = [];
  List<int?> audioProgresses = [];
  List<PlayerState> playbackStates = [];
  Color containercolor = Colors.transparent;
  int? repliedindex;
  test(int index) {
    print("ss----------  $index");
  }

  int getMessageIndexById({required List messages, required String messageId}) {
    return messages.indexWhere((message) => message.messageId == messageId);
  }

  int? selectedIndex;
  changecolor({required List messages, required String messageId}) async {
    selectedIndex =
        getMessageIndexById(messageId: messageId, messages: messages);
    await scrollToIndex(selectedIndex!);
    //  indexcolor = 3;
    //  selectedIndex = index;
    containercolor = Colors.blue;
    print("-------------- ff");
    emit(containercolorstate());
    Future.delayed(const Duration(milliseconds: 1500), () {
      print("------------- gooo");
      selectedIndex = null;
      containercolor = Colors.transparent;
      emit(containercolorstate2());
    });
  }

  Future scrollToIndex(int index) async {
    print("--------- enter");
    // double targetScrollPosition = index *
    //     ScreenUtil().screenHeight *
    //     0.5; // Assuming 10% of screen height for each message

    double targetScrollPosition = index * 70;
    listscrollcontroler.animateTo(
      targetScrollPosition.h,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
    print("----- dnn");
  }

  Future<void> startRecording() async {
    micColor = Colors.green;
    micIconSize = 50;
    isrecord = true;
    await recordRepository.initRecorder();
    recordername = await recordRepository.startRecording();
    recordRepository.subscribeToRecorderStream().listen((duration) {
      emit(const startrecordstate());
      audiotime = duration;
      emit(RecordingInProgressstate(duration: audiotime.toString()));
    });
  }

  Future<void> showemoji() async {
    await Future.delayed(const Duration(milliseconds: 100)).then(
      (value) {
        isshowemoji = !isshowemoji;
      },
    );
    emit(showEmojiState(isshowemoji: isshowemoji));
  }

  void changeIcon() {
    if (messagecontroller.text.trim().isEmpty) {
      if (!isMic) {
        isMic = true;
        emit(const ChangeIconState(isMic: true));
      }
    } else {
      if (isMic) {
        isMic = false;
        emit(const ChangeIconState(isMic: false));
      }
    }
  }

  bool? myuserinchat;
  bool? otheruserinchat;
  sendMessage({
    required String chatid,
    required String messagetype,
    required dynamic content,
    required UserEntites userentites,
  }) async {
    final mchatid =
        _generateChatId(chatid, FirebaseAuth.instance.currentUser!.uid);
    emit(LoadingMessageState());

    final messageId = FirebaseFirestore.instance
        .collection('chats')
        .doc(mchatid)
        .collection('messageda')
        .doc()
        .id;

    final response = await sendMessageUsecase.sendMessage(
        chatid: mchatid,
        messageentities: MessageModel(
            senderid: FirebaseAuth.instance.currentUser!.uid,
            messageId: messageId,
            content: content,
            //messagecontroller.text.trim(),
            timestamp: DateTime.now(),
            messageType: messagetype,
            // 'text',
            readType: otheruserinchat!,
            replyMessage: replyMessage != null
                ? {
                    'replycontent': replyMessage?.content,
                    'senderid': replyMessage?.senderid,
                    'messageId': replyMessage?.messageId
                  }
                : null),
        between: {
          FirebaseAuth.instance.currentUser!.uid: {
            'photoUrl': FirebaseAuth.instance.currentUser?.photoURL,
            'Name': FirebaseAuth.instance.currentUser!.displayName,
            'email': FirebaseAuth.instance.currentUser!.email,
            'id': FirebaseAuth.instance.currentUser!.uid,
            'isInChat': myuserinchat
          },
          chatid: {
            'photoUrl': userentites.photourl,
            'Name': userentites.name,
            'email': userentites.email,
            'id': chatid,
            'status': userentites.status,
            'isInChat': otheruserinchat
          }
        });

    response.fold(
      (l) {
        emit(FailureMessagState(errorMessage: _mapFailutrToMessage(l)));
      },
      (r) {
        isMic = true;

        messagecontroller.clear();
        audioProgresses.add(0);
        audioPlayers.add(AudioPlayer());
        replyMessage = null;
        if (messagetype == 'text') {
          listscrollcontroler.animateTo(0,
              duration: const Duration(seconds: 1), curve: Curves.easeInOut);
        }

        emit(SucessMessageState());
      },
    );
  }

  Future<void> setUserInChatStatus(String chatId, String mchatid) async {
    final userid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('chats').doc(mchatid).update({
      'participants.$userid.isInChat': true,
    });
    final chatDoc =
        await FirebaseFirestore.instance.collection('chats').doc(mchatid).get();
    otheruserinchat =
        chatDoc.data()?['participants'][chatId]['isInChat'] ?? false;
    myuserinchat = chatDoc.data()?['participants'][userid]['isInChat'] ?? false;

  }

  void getMessages({required String chatId}) async {
    final mchatid =
        _generateChatId(chatId, FirebaseAuth.instance.currentUser!.uid);
    emit(LoadingGetMessageState());
    await setUserInChatStatus(chatId, mchatid);
    getMessageUsecase.getmessage(chatId: mchatid).listen((response) {
  
      response.fold((failure) {
        emit(FailureGetMessageState(
            errorMessage: _mapFailutrToMessage(failure)));
      }, (messages) {
        print("------------------ 333");
        int unreadCount = 0;
        for (int i = 0; i < messages.length; i++) {
          final message = messages[i];

          audioProgresses.add(0);
          audioPlayers.add(AudioPlayer());
          playbackStates.add(PlayerState.paused);
          final int duration = message.messageType == 'record'
              ? message.content['audiotime']
              : 0;
          audioDurations.add(duration);         
        }
        print("666-------------------- $unreadCount");
        emit(SucessGetMessageState(allmessage: messages));
      });
    });
  }

  readType({required String chatid, required String messageid}) async {
    final mchatid =
        _generateChatId(chatid, FirebaseAuth.instance.currentUser!.uid);
    if (chatid != FirebaseAuth.instance.currentUser!.uid) {
      final message = FirebaseFirestore.instance
          .collection('chats')
          .doc(mchatid)
          .collection('messages')
          .doc(messageid);

      await message.update({'readStatus': true});
    }
  }

  void listscroll() {
    listscrollcontroler.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.easeInOut);
  }

  String _generateChatId(String userId1, String userId2) {
    List<String> ids = [userId1, userId2];
    ids.sort();
    return ids.join();
  }

  replyToMessage(MessageEntites messageEntites, int index) {
    emit(cancelreplyMessagewState());
    if (isshowemoji) {
      repliedindex = index;
      replyMessage = messageEntites;
      // focusNode.requestFocus();
    } else {
      repliedindex = index;
      replyMessage = messageEntites;
      focusNode.requestFocus();
    }
    emit(replyMessagewState(replymessage: replyMessage!));
  }

  cancelReplyToMessage() {
    replyMessage = null;
    emit(cancelreplyMessagewState());
  }

  showImages() async {
    final List<XFile>? ListpickedImage = await picker.pickMultiImage();
    if (ListpickedImage != null && ListpickedImage.isNotEmpty) {
      List<String> PickedImagesPathes =
          ListpickedImage.map((e) => e.path).toList();

      emit(showimagesstatesucess(pickedImagesPathes: PickedImagesPathes));
    }
  }

  removephoto({required int index, required List<String> allimages}) {
    allimages.removeAt(index);

    emit(changephotonumberstate(index: photonumber));
    emit(removeImagestate(pickedImagesPathes: allimages));
  }

  changephotonumer({required int index}) {
    pageController.jumpToPage(index);
    photonumber = index;
    emit(changephotonumberstate(index: photonumber));
  }

  changephotonumer2({required int index2}) {
    // pageController.jumpToPage(index0);
    photonumber = index2;
    emit(const changephotonumberstate2());
  }

  sendimages({
    required List<String> images,
    required String chatid,
    required UserEntites userentites,
    // String? photourl,
    // required String name,
  }) async {
    emit(loadinguploadimageState());
    final response = await uploadImagesUsecase.uploadImages(images: images);
    response.fold(
      (l) {
        emit(FailureuploadimageState(errorMessage: _mapFailutrToMessage(l)));
      },
      (r) {
        sendMessage(
          chatid: chatid,
          messagetype: 'photo',
          content: {
            'allphotos': r,
            'photocaption': photocaptioncontroller.text.trim().isEmpty
                ? null
                : photocaptioncontroller.text
          },
          userentites: userentites,
        );
        emit(SucessuploadimageState());
      },
    );
  }

  sendrecord({
    required String chatid,
    required UserEntites userentites,
    // String? photourl,
    // required String name,
  }) async {
    emit(const UploadrecordLoadingState());
    micColor = const Color.fromARGB(255, 152, 152, 167);
    micIconSize = 25;
    isrecord = false;
    String audiopath = await recordRepository.stopRecording();
    print("--------------- upload11");
    final response = await uploadAudioUsecase.uploadAudio(
        audiopath: audiopath, audioname: recordername!);
    print("--------------- upload222");
    response.fold(
      (l) {
        print("---------------- ff");
        emit(FailureuploadimageState(errorMessage: _mapFailutrToMessage(l)));
      },
      (r) {
        print("--------------- upload333");
        sendMessage(
            chatid: chatid,
            messagetype: 'record',
            content: {
              'record': r,
              'audiotime': audiotime,
            },
            userentites: userentites);
        print("--------------- upload444");
        emit(const UploadrecordsUCESSState());
      },
    );
  }

  // int? audioDuration;
  // int audioProgress = 0;
  Future<void> playAudio({required String audioUrl, required int index}) async {
    // for (int i = 0; i < audioPlayers.length; i++) {
    //   if (i != index) {
    //     await audioPlayers[i].stop();
    //   }
    // }
    await audioPlayers[index].play(UrlSource(audioUrl));
    audioPlayers[index].onDurationChanged.listen((Duration duration) {
      audioDurations[index] = duration.inMilliseconds;
      emit(audiodurationstate(audioduration: audioDurations[index]!));
    });

    audioPlayers[index].onPositionChanged.listen((Duration position) {
      emit(const AudioLoadingState());
      audioProgresses[index] = position.inMilliseconds;
      emit(timeprogrssstate(timeprogrss: audioProgresses[index]!));
    });
    audioPlayers[index].onPlayerComplete.listen((_) {
      playbackStates[index] = PlayerState.completed;
      emit(completestate(player: playbackStates[index]));
    });
  }

  int? playindex;
  Future<void> longPlay({required String audioUrl, required int index}) async {
    // if (playindex != null) {
    //   print("--------------------- playindex");
    //   audioPlayers[playindex!].pause();
    //   playbackStates[playindex!] = PlayerState.paused;
    //   // emit(PlayerStateUpdate(playbackState: playbackStates[playindex!]));
    // }
    if (playindex != null && playindex != index) {
      await audioPlayers[playindex!].pause();
      playbackStates[playindex!] = PlayerState.paused;
    }
    // Manage playback state for the selected index
    switch (playbackStates[index]) {
      case PlayerState.paused:
      case PlayerState.stopped:
        print("------------- enter ");
        await playAudio(index: index, audioUrl: audioUrl);
        playbackStates[index] = PlayerState.playing;
        playindex = index;
        print("---------------- play$index");
        emit(PlayerStateUpdate(playbackState: playbackStates[index]));
        break;

      case PlayerState.playing:
        // await _stopAudio(index: index);
        //  print("------------- close ");
        await audioPlayers[index].pause();
        playbackStates[index] = PlayerState.paused;
        //  playbackStates[index] = PlayerState.stopped;
        playindex = null;
        print("---------------- stop$index");
        emit(PlayerStateUpdate(playbackState: playbackStates[index]));
        break;

      case PlayerState.completed:
        print("---------------- completed");
        await playAudio(index: index, audioUrl: audioUrl);
        playindex = index;
        playbackStates[index] = PlayerState.playing;
        emit(PlayerStateUpdate(playbackState: playbackStates[index]));
        break;

      default:
        break;
    }
  }

  Future<void> _stopAudio({required int index}) async {
    await audioPlayers[index].stop();
    playbackStates[index] = PlayerState.stopped;
    emit(PlayerStateUpdate(playbackState: playbackStates[index]));
  }

  void seekTo(int sec, int index) {
    Duration newPosition = Duration(seconds: sec);
    audioPlayers[index].seek(newPosition);
  }

  sendMyLocation({
    required String chatid,
    // String? photourl,
    // required String name,
    required UserEntites userentites,
  }) async {
    emit(LoadingLocation());
    final response = await getMyLocationUseCase.getMyLocation();
    response.fold(
      (l) {
        emit(failureLocationstate(error_message: _mapFailutrToMessage(l)));
      },
      (r) {
        sendMessage(
            chatid: chatid,
            messagetype: 'Location',
            content: {'latitude': r.latitude, 'longitude': r.longitude},
            userentites: userentites);
        emit(SucessLocationState());
      },
    );
  }

  uploadpdf({
    required String chatid,
    // String? photourl,
    // required String name,
    required UserEntites userentites,
  }) async {
    final response = await uploadPdfUsecase.UploadPd();
    response.fold(
      (l) {
        print('---------------- $l');
      },
      (r) {
        sendMessage(
            chatid: chatid,
            messagetype: 'Pdf',
            content: {'pdfName': r['pdfName'], 'PdfUrl': r['PdfUrl']},
            userentites: userentites);
      },
    );
  }

  String _mapFailutrToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case FirebaseFailure:
        return (failure as FirebaseFailure).message ??
            'Unexpected Firebase Error';
      case OffLineFailure:
        return ErroStrings.offlineFailure;
      case EmptyMessageFailure:
        return ErroStrings.emptymessagecachefailure;
      default:
        return 'Un Expected Error';
    }
  }

  @override
  Future<void> close() {
    for (var player in audioPlayers) {
      player.dispose();
    }
    return super.close();
  }
}
