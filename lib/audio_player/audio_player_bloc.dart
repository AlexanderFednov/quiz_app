import 'package:easy_dispose/easy_dispose.dart';
import 'package:quiz_app/audio_player/audio_player_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioPlayerBloc extends DisposableOwner {
  AudioPlayerBloc() {
    _loadIsSoundEnabled();

    _audioPlayerStateSubject.disposeWith(this);
  }

  static final AudioPlayerModel _audioPlayerModel = AudioPlayerModel();

  final BehaviorSubject<AudioPlayerModel> _audioPlayerStateSubject =
      BehaviorSubject.seeded(_audioPlayerModel);

  AudioPlayerModel get audioPlayerState => _audioPlayerStateSubject.value;

  Stream<bool?> get isSoundEnabledStream => _audioPlayerStateSubject.stream
      .map((audioPlayerModel) => audioPlayerModel.isSoundEnabled)
      .distinct();

  Stream<AudioPlayerStatus> get audioPlayerStatusStream =>
      _audioPlayerStateSubject.stream
          .map((audioPlayerModel) => audioPlayerModel.audioPlayerStatus)
          .distinct();

  void setIsSoundEnabled() async {
    var prefs = await SharedPreferences.getInstance();

    if (audioPlayerState.isSoundEnabled!) {
      _audioPlayerStateSubject.add(
        audioPlayerState.copyWith(isSoundEnabled: false),
      );

      await prefs.setBool('isAudioPlaying', false);
    } else {
      _audioPlayerStateSubject.add(
        audioPlayerState.copyWith(isSoundEnabled: true),
      );

      await prefs.setBool('isAudioPlaying', true);
    }
  }

  void _loadIsSoundEnabled() async {
    var prefs = await SharedPreferences.getInstance();

    var savedIsAudioPlaying = (prefs.getBool('isAudioPlaying') ?? true);

    _audioPlayerStateSubject.add(
      audioPlayerState.copyWith(isSoundEnabled: savedIsAudioPlaying),
    );
  }

  void audioPlayerInitialized() {
    _audioPlayerStateSubject.add(
      audioPlayerState.copyWith(
        audioPlayerStatus: AudioPlayerStatus.initialized,
      ),
    );
  }

  void playing() {
    _audioPlayerStateSubject.add(
      audioPlayerState.copyWith(
        audioPlayerStatus: AudioPlayerStatus.playing,
      ),
    );
  }

  void paused() {
    _audioPlayerStateSubject.add(
      audioPlayerState.copyWith(
        audioPlayerStatus: AudioPlayerStatus.paused,
      ),
    );
  }

  void stopped() {
    _audioPlayerStateSubject.add(
      audioPlayerState.copyWith(
        audioPlayerStatus: AudioPlayerStatus.stopped,
      ),
    );
  }
}
