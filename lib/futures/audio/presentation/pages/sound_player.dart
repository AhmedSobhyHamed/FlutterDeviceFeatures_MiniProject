import 'package:flutter/material.dart';
import 'package:flutterdevicefeatures_miniproject/futures/audio/domain/audio.dart';
import 'package:flutterdevicefeatures_miniproject/futures/audio/domain/audio_files.dart';
import 'package:flutterdevicefeatures_miniproject/futures/audio/domain/audio_sound.dart';

class SoundPlayerPage extends StatefulWidget {
  const SoundPlayerPage({super.key});

  @override
  State<SoundPlayerPage> createState() => _SoundPlayerPageState();
}
class _SoundPlayerPageState extends State<SoundPlayerPage> {
  AudioState _state = AudioState.stopped;
  double _volume = 0.5;
  AudioSpeed _speed = AudioSpeed.x1;
  List<String> _audioFiles = [];
  Audio _audio = AudioSound();

  @override
  void initState() {
    super.initState();
    _loadAudioFiles();
    _audio.initRecorder();
  }

  Future<void> _loadAudioFiles() async {
    final audioFiles = await AudioFiles.getAudioFiles();
    setState(() {
      _audioFiles = audioFiles;
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
              IconButton(onPressed: _audio.backwardAudio, icon: const Icon(Icons.arrow_back)),
              IconButton(onPressed: _playPauseAudio, icon: _state == AudioState.playing ? const Icon(Icons.pause) : const Icon(Icons.play_arrow)),
              IconButton(onPressed: _stopAudio, icon: const Icon(Icons.stop)),
              IconButton(onPressed: _audio.forwardAudio, icon: const Icon(Icons.arrow_forward)),
            ]),
            IconButton(onPressed: _volumeUp, icon: const Icon(Icons.volume_up)),
            IconButton(onPressed: _volumeDown, icon: const Icon(Icons.volume_down)),
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
          onTap: () {_audio.setSource(_audioFiles[index]);},
        );
      }),
    );
  }

  _playPauseAudio() async {
    final state = await _audio.playPauseAudio();
    setState(() {
      _state = state;
    });
  }

  _stopAudio() async {
    final state = await _audio.stopAudio();
    setState(() {
      _state = state;
    });
  }

  _startStopRecording() async {
    final state = await _audio.startStopRecording();
    setState(() {
      _state = state;
    });
  }

  _volumeUp() {
    _audio.setVolume(_volume += 0.1);
    setState(() {});
  }

  _volumeDown() {
    _audio.setVolume(_volume -= 0.1);
    setState(() {});
  }

  _setSpeed() async {
    final speed = await _audio.setSpeed();
    setState(() {
      _speed = speed;
    });
  }
}