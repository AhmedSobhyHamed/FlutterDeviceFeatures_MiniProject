import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

enum AudioSpeed {
  x0_5(0.5),
  x1(1.0),
  x1_5(1.5),
  x2(2.0),
  x3(3.0);

  const AudioSpeed(this.value);
  final double value;
}

enum AudioState {
  playing,
  paused,
  stopped,
  recording,
}

class SoundPlayerPage extends StatefulWidget {
  const SoundPlayerPage({super.key});

  @override
  State<SoundPlayerPage> createState() => _SoundPlayerPageState();
}
class _SoundPlayerPageState extends State<SoundPlayerPage> {
  AudioState _state = AudioState.stopped;
  double _volume = 0.5;
  AudioSpeed _speed = AudioSpeed.x1;
  final _player = AudioPlayer();
  bool _haveSource = false;
  List<String> _audioFiles = [];
  FlutterSoundRecorder? _recorder;
  bool _isRecorderInitialized = false;

  @override
  void initState() {
    super.initState();
    _loadAudioFiles();
    _initRecorder();
  }

  Future<void> _initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }

    final recorder = FlutterSoundRecorder();
    await recorder.openRecorder();
    if (!mounted) return;
    setState(() {
      _recorder = recorder;
      _isRecorderInitialized = true;
    });
  }

  Future<Directory> _audiosFolder() async {
    final documents = await getApplicationDocumentsDirectory();
    final folder = Directory('${documents.path}/audios');
    if (!await folder.exists()) {
      await folder.create(recursive: true);
    }
    return folder;
  }
  Future<void> _loadAudioFiles() async {
    final folder = await _audiosFolder();
    final files = folder
        .listSync()
        .whereType<File>()
        .map((file) => file.path)
        .where((path) =>
            path.endsWith('.mp3') ||
            path.endsWith('.wav') ||
            path.endsWith('.ogg') ||
            path.endsWith('.m4a') ||
            path.endsWith('.aac'))
        .toList();
    if (!mounted) return;
    setState(() {
      _audioFiles = files;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sound Player'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            _audioRecorder(),
            _audioPlayer(),
            Expanded(
              child: _audiofiles(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _audioRecorder() {
    return Container(
      width: double.infinity,
      height: 100,
      color: Colors.black,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(onPressed: _startStopRecording, icon: _state == AudioState.recording ? const Icon(Icons.stop) : const Icon(Icons.mic)),
          ],
        ),
      ),
    );
  }

  Widget _audioPlayer() {
    return Container(
      width: double.infinity,
      height: 100,
      color: Colors.blue,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(children: [
              IconButton(onPressed: _backwardAudio, icon: const Icon(Icons.arrow_back)),
              IconButton(onPressed: _playPauseAudio, icon: _state == AudioState.playing ? const Icon(Icons.pause) : const Icon(Icons.play_arrow)),
              IconButton(onPressed: _stopAudio, icon: const Icon(Icons.stop)),
              IconButton(onPressed: _forwardAudio, icon: const Icon(Icons.arrow_forward)),
            ]),
            IconButton(onPressed: () {_setVolume(_volume + 0.1);}, icon: const Icon(Icons.volume_up)),
            IconButton(onPressed: () {_setVolume(_volume - 0.1);}, icon: const Icon(Icons.volume_down)),
            TextButton(onPressed: _setSpeed, child: Text('X${_speed.value}')),
          ],
        ),
      ),
    );
  }

  Widget _audiofiles() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: ListView.builder(itemCount: _audioFiles.length, itemBuilder: (context, index) {
        return ListTile(
          title: Text(_audioFiles[index].split('/').last),
          onTap: () {_setSource(_audioFiles[index]);},
        );
      }),
    );
  }

  Future<void> _playPauseAudio() async {
    if (!_haveSource) return;
    if (_state == AudioState.playing) {
      await _player.pause();
    } else {
      await _player.resume();
    }
    setState(() {
      _state = _state == AudioState.playing ? AudioState.paused : AudioState.playing;
    });
  }

  Future<void> _stopAudio() async {
    if (!_haveSource) return;
    await _player.stop();
    setState(() {
      _state = AudioState.stopped;
    });
  }

  Future<void> _backwardAudio() async {
    if (!_haveSource) return;
    await _player.seek(Duration(seconds: -10));
  }

  Future<void> _forwardAudio() async {
    if (!_haveSource) return;
    await _player.seek(Duration(seconds: 10));
  }

  Future<void> _setVolume(double volume) async {
    await _player.setVolume(volume);
    setState(() {
      _volume = volume;
    });
  }

  Future<void> _setSpeed() async {
    const speeds = AudioSpeed.values;
    final next = speeds[(speeds.indexOf(_speed) + 1) % speeds.length];
    await _player.setPlaybackRate(next.value);
    setState(() {
      _speed = next;
    });
  }

  Future<void> _setSource(String path) async {
    await _player.setSource(DeviceFileSource(path));
    setState(() {
      _haveSource = true;
    });
  }

  Future<void> _startStopRecording() async {
    if (_state == AudioState.recording) {
      await _stopRecording();
    } else {
      await _startRecording();
    }
  }

  Future<void> _startRecording() async {
    if (!_isRecorderInitialized) return;

    final folder = await _audiosFolder();
    final pathToAudio = '${folder.path}/${DateTime.now().millisecondsSinceEpoch}.aac';

    await _recorder!.startRecorder(
      toFile: pathToAudio,
      codec: Codec.aacADTS,
    );

    setState(() {
      _state = AudioState.recording;
    });
  }

  Future<void> _stopRecording() async {
    if (!_isRecorderInitialized || _state != AudioState.recording) return;

    await _recorder!.stopRecorder();

    setState(() {
      _state = AudioState.stopped;
    });
  }
}