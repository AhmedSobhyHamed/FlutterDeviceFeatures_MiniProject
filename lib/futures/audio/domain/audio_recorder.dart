import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutterdevicefeatures_miniproject/futures/audio/domain/audio_files.dart';
import 'package:flutterdevicefeatures_miniproject/futures/audio/domain/audio.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioRecorder extends Audio {
  bool _isRecorderInitialized = false;
  FlutterSoundRecorder? _recorder;

  @override
  Future<void> initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }

    final recorder = FlutterSoundRecorder();
    await recorder.openRecorder();

    _recorder = recorder;
    _isRecorderInitialized = true;
  }

  @override
  Future<AudioState> startStopRecording() async {
    if (state == AudioState.recording) {
      return stopRecording();
    }
    return startRecording();
  }

  @override
  Future<AudioState> startRecording() async {
    if (!_isRecorderInitialized) return state;

    final folder = await AudioFiles.getAudiosFolder();
    final pathToAudio = '${folder.path}/${DateTime.now().millisecondsSinceEpoch}.aac';

    await _recorder!.startRecorder(
      toFile: pathToAudio,
      codec: Codec.aacADTS,
    );

    state = AudioState.recording;
    return state;
  }

  @override
  Future<AudioState> stopRecording() async {
    if (!_isRecorderInitialized || state != AudioState.recording) return state;

    await _recorder!.stopRecorder();

    state = AudioState.stopped;
    return state;
  }
}
