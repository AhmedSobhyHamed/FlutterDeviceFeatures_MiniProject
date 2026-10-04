import 'package:flutterdevicefeatures_miniproject/futures/audio/domain/audio.dart';
import 'package:flutterdevicefeatures_miniproject/futures/audio/domain/audio_files.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart' as rec;

class AudioSound extends Audio {
  bool _isRecorderInitialized = false;
  rec.AudioRecorder? _recorder;

  @override
  Future<void> initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw Exception('Microphone permission not granted');
    }
    _recorder = rec.AudioRecorder();
    if (!await _recorder!.hasPermission()) {
      throw Exception('Microphone permission not granted');
    }
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
    final path = '${folder.path}/${DateTime.now().millisecondsSinceEpoch}.m4a';
    await _recorder!.start(
      const rec.RecordConfig(
        encoder: rec.AudioEncoder.aacLc,
        sampleRate: 44100,
        numChannels: 1,
      ),
      path: path,
    );

    state = AudioState.recording;
    return state;
  }

  @override
  Future<AudioState> stopRecording() async {
    if (!_isRecorderInitialized || state != AudioState.recording) return state;
    await _recorder!.stop();
    state = AudioState.stopped;
    return state;
  }
}
