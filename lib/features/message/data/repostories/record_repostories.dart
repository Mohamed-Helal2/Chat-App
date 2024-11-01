import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:audioplayers/audioplayers.dart';

class RecordRepository {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final AudioPlayer audioplayer = AudioPlayer();
  // Initialize the recorder with permission checks
  Future<void> initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw "Microphone permission not granted";
    }
    await _recorder.openRecorder();
    _recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  // Start recording with a specified file name
  Future<String> startRecording() async {
    String recordername =
        "${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}${DateTime.now().hour}${DateTime.now().second}${DateTime.now().microsecond}";
    final path = 'audio_$recordername.aac'; // Use .aac extension
    await _recorder.startRecorder(toFile: path);
    return recordername;
  }

  // Stop recording and close the recorder
  Future<String> stopRecording() async {
    String? audiopath = await _recorder.stopRecorder();
    await _recorder.closeRecorder();
     return audiopath!;
  }

  // Subscribe to the recorder's onProgress stream
  Stream<int> subscribeToRecorderStream() {
    return _recorder.onProgress!.map((data) => data.duration.inMilliseconds);
  }

////// play audio
  
}
