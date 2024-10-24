part of 'message_cubit.dart';

sealed class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object> get props => [];
}

final class MessageInitial extends MessageState {}

final class LoadingMessageState extends MessageState {}

final class SucessMessageState extends MessageState {}

final class FailureMessagState extends MessageState {
  final String errorMessage;
  const FailureMessagState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class ChangeIconState extends MessageState {
  final bool isMic;

  const ChangeIconState({required this.isMic});
  @override
  List<Object> get props => [isMic];
}

final class LoadingGetMessageState extends MessageState {}

final class SucessGetMessageState extends MessageState {
  final List<MessageEntites> allmessage;

  const SucessGetMessageState({required this.allmessage});
  @override
  List<Object> get props => [allmessage];
}

final class FailureGetMessageState extends MessageState {
  final String errorMessage;
  const FailureGetMessageState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

final class replyMessagewState extends MessageState {
  final MessageEntites? replymessage;

  const replyMessagewState({required this.replymessage});
  // @override
  // List<Object> get props => [replymessage!];
}

final class cancelreplyMessagewState extends MessageState {}

final class showEmojiState extends MessageState {
  final bool isshowemoji;

  const showEmojiState({required this.isshowemoji});
  @override
  List<Object> get props => [isshowemoji];
}

final class showimagesstatesucess extends MessageState {
  final List<String> pickedImagesPathes;

  const showimagesstatesucess({required this.pickedImagesPathes});

  @override
  List<Object> get props => [pickedImagesPathes];
}

final class changephotonumberstate extends MessageState {
  final int index;

  const changephotonumberstate({required this.index});
}

final class changephotonumberstate2 extends MessageState {
  const changephotonumberstate2();
}

final class removeImagestate extends MessageState {
  final List<String> pickedImagesPathes;

  const removeImagestate({required this.pickedImagesPathes});
}

final class loadinguploadimageState extends MessageState {}

final class SucessuploadimageState extends MessageState {}

final class FailureuploadimageState extends MessageState {
  final String errorMessage;

  const FailureuploadimageState({required this.errorMessage});
}

final class ChangemicIconSizeState extends MessageState {
  const ChangemicIconSizeState();
}

final class ChangemicIconSizeState2 extends MessageState {
  const ChangemicIconSizeState2();
}

final class InitialrecordState extends MessageState {
  const InitialrecordState();
}

final class RecordingInProgressstate extends MessageState {
  final String duration;
  const RecordingInProgressstate({required this.duration});
}

final class startrecordstate extends MessageState {
  const startrecordstate();
}

final class RecordingStoppedState extends MessageState {
  const RecordingStoppedState();
}

class RecordingDurationUpdated extends MessageState {
  final String duration;
  const RecordingDurationUpdated(this.duration);
}

///
///

final class UploadrecordLoadingState extends MessageState {
  const UploadrecordLoadingState();
}

final class UploadrecordsUCESSState extends MessageState {
  const UploadrecordsUCESSState();
}

final class AudioLoadingState extends MessageState {
  const AudioLoadingState();
}

final class audiodurationstate extends MessageState {
  final int audioduration;
  const audiodurationstate({required this.audioduration});
}

final class timeprogrssstate extends MessageState {
  final int timeprogrss;
  const timeprogrssstate({required this.timeprogrss});
}

final class PlayerStateUpdate extends MessageState {
  final PlayerState playbackState;
  PlayerStateUpdate({required this.playbackState});
}

final class completestate extends MessageState {
  final PlayerState player;
  completestate({required this.player});
}

// location
final class LoadingLocation extends MessageState {}

final class failureLocationstate extends MessageState {
  final String error_message;
  @override
  List<Object> get props => [error_message];
  const failureLocationstate({required this.error_message});
}

final class SucessLocationState extends MessageState {}

/// containercolor

final class containercolorstate extends MessageState {}

final class containercolorstate2 extends MessageState {}
