import 'package:audioplayers/audioplayers.dart';
import 'package:quiz_app/audio_player/audio_player_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioPlayerBloc {
  AudioPlayerBloc() {
    _loadSavedIsSoundEnabled();

    _audioPlayerInit();
  }

  static final AudioPlayerModel _audioPlayerModel = AudioPlayerModel();

  late AudioCache _audioCache;
  final AudioPlayer _audioPlayer = AudioPlayer();

  final BehaviorSubject<AudioPlayerModel> _audioPlayerStateSubject =
      BehaviorSubject.seeded(_audioPlayerModel);

  bool get isSoundEnabled => _audioPlayerStateSubject.value.isSoundEnabled!;

  AudioPlayerModel get audioPlayerState => _audioPlayerStateSubject.value;

  Stream<bool?> get isSoundEnabledStream => _audioPlayerStateSubject.stream
      .map((audioPlayerModel) => audioPlayerModel.isSoundEnabled)
      .distinct();

  Stream<AudioPlayerStatus> get audioPlayerStatusStream =>
      _audioPlayerStateSubject.stream
          .map((audioPlayerModel) => audioPlayerModel.audioPlayerStatus)
          .distinct();

  void _audioPlayerInit() async {
    _audioCache =
        AudioCache(prefix: 'assets/music/', fixedPlayer: _audioPlayer);

    _audioPlayerStateSubject.add(
      audioPlayerState.copyWith(
        audioPlayerStatus: AudioPlayerStatus.initialized,
      ),
    );

    await _audioCache.loop(
      'Shadowing - Corbyn Kites.mp3',
      isNotification: true,
    );

    _audioPlayerStateSubject.add(
      audioPlayerState.copyWith(audioPlayerStatus: AudioPlayerStatus.playing),
    );

    if (!isSoundEnabled) {
      pause();
    }
  }

  void _loadSavedIsSoundEnabled() async {
    var prefs = await SharedPreferences.getInstance();

    var savedIsAudioPlaying = (prefs.getBool('isAudioPlaying') ?? true);

    _audioPlayerStateSubject.add(
      audioPlayerState.copyWith(isSoundEnabled: savedIsAudioPlaying),
    );
  }

  void setIsSoundEnabled() async {
    var prefs = await SharedPreferences.getInstance();

    if (isSoundEnabled) {
      _audioPlayerStateSubject.add(
        audioPlayerState.copyWith(isSoundEnabled: false),
      );

      await prefs.setBool('isAudioPlaying', false);

      pause();
    } else {
      _audioPlayerStateSubject.add(
        audioPlayerState.copyWith(isSoundEnabled: true),
      );

      await prefs.setBool('isAudioPlaying', true);

      resume();
    }
  }

  void resume() async {
    await _audioPlayer.resume();

    _audioPlayerStateSubject.add(
      audioPlayerState.copyWith(audioPlayerStatus: AudioPlayerStatus.playing),
    );
  }

  void pause() async {
    await _audioPlayer.pause();

    _audioPlayerStateSubject.add(
      audioPlayerState.copyWith(audioPlayerStatus: AudioPlayerStatus.paused),
    );
  }

  void stop() async {
    await _audioPlayer.stop();
    await _audioPlayer.release();

    _audioPlayerStateSubject.add(
      audioPlayerState.copyWith(audioPlayerStatus: AudioPlayerStatus.stopped),
    );
  }

  void dispose() async {
    await _audioPlayerStateSubject.close();
    await _audioPlayer.release();
    await _audioPlayer.dispose();
    await _audioCache.clearAll();
  }
}
