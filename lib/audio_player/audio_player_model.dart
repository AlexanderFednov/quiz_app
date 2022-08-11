import 'package:equatable/equatable.dart';

enum AudioPlayerStatus { notInitialized, initialized, playing, paused, stopped }

class AudioPlayerModel extends Equatable {
  final bool? isSoundEnabled;
  final AudioPlayerStatus audioPlayerStatus;

  AudioPlayerModel({
    this.isSoundEnabled = false,
    this.audioPlayerStatus = AudioPlayerStatus.notInitialized,
  });

  AudioPlayerModel copyWith({
    bool? isSoundEnabled,
    AudioPlayerStatus? audioPlayerStatus,
  }) {
    return AudioPlayerModel(
      isSoundEnabled: isSoundEnabled ?? this.isSoundEnabled,
      audioPlayerStatus: audioPlayerStatus ?? this.audioPlayerStatus,
    );
  }

  @override
  List<Object?> get props => [isSoundEnabled, audioPlayerStatus];
}
