import 'package:audioplayers/audioplayers.dart';
import 'package:meta/meta.dart';

enum AudioState {
  stopped,
  playing,
  paused,
  recording,
}

enum AudioSpeed {
  x0_5(0.5),
  x1(1.0),
  x1_5(1.5),
  x2(2.0),
  x3(3.0);

  const AudioSpeed(this.value);
  final double value;
}

abstract class Audio {
  bool _haveSource = false;
  AudioState _state = AudioState.stopped;
  AudioSpeed _speed = AudioSpeed.x1;

  final _player = AudioPlayer();

  @protected
  AudioState get state => _state;

  @protected
  set state(AudioState value) => _state = value;

  Future<AudioState> playPauseAudio() async {
    if (!_haveSource) return _state;
    if (_state == AudioState.playing) {
      await _player.pause();
      _state = AudioState.paused;
    } else {
      await _player.resume();
      _state = AudioState.playing;
    }
    return _state;
  }

  Future<AudioState> stopAudio() async {
    if (!_haveSource) return _state;
    await _player.stop();
    _state = AudioState.stopped;
    return _state;
  }

  Future<void> backwardAudio() async {
    if (!_haveSource) return;
    await _player.seek(const Duration(seconds: -10));
  }

  Future<void> forwardAudio() async {
    if (!_haveSource) return;
    await _player.seek(const Duration(seconds: 10));
  }

  Future<void> setVolume(double volume) async {
    await _player.setVolume(volume);
  }

  Future<AudioSpeed> setSpeed() async {
    const speeds = AudioSpeed.values;
    final next = speeds[(speeds.indexOf(_speed) + 1) % speeds.length];
    await _player.setPlaybackRate(next.value);
    _speed = next;
    return next;
  }

  Future<bool> setSource(String path) async {
    await _player.setSource(DeviceFileSource(path));
    _haveSource = true;
    return _haveSource;
  }

  Future<void> initRecorder() async => throw UnimplementedError();
  Future<AudioState> startStopRecording() async => throw UnimplementedError();
  Future<AudioState> startRecording() async => throw UnimplementedError();
  Future<AudioState> stopRecording() async => throw UnimplementedError();
}
