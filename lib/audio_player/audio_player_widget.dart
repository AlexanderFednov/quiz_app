// import 'package:audioplayer/audioplayer.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/audio_player/audio_player_bloc.dart';
import 'package:quiz_app/audio_player/audio_player_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizAudioPlayerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return QuizAudioPlayerWidgetState();
  }
}

class QuizAudioPlayerWidgetState extends State<QuizAudioPlayerWidget>
    with WidgetsBindingObserver {
  late AudioCache audioCache;
  AudioPlayer audioPlayer = AudioPlayer();

  void _playerInit(
    bool isSoundEnabled,
    Function playerInitialized,
  ) async {
    audioCache = AudioCache(prefix: 'assets/music/', fixedPlayer: audioPlayer);
    await audioCache.loop('Shadowing - Corbyn Kites.mp3', isNotification: true);

    if (!isSoundEnabled) {
      await audioPlayer.pause();
    }

    playerInitialized();
  }

  void _soundButton(bool isSoundEnabled) async {
    if (isSoundEnabled) {
      await audioPlayer.resume();
    } else {
      await audioPlayer.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    var audioPlayerBloc = Provider.of<AudioPlayerBloc>(context);

    audioPlayerBloc.isSoundEnabledStream.listen((event) {
      if (audioPlayerBloc.audioPlayerState.audioPlayerStatus ==
          AudioPlayerStatus.notInitialized) {
        _playerInit(event!, audioPlayerBloc.audioPlayerInitialized);
      } else {
        _soundButton(event!);
      }
    });

    return StreamBuilder<bool?>(
      stream: audioPlayerBloc.isSoundEnabledStream,
      initialData: true,
      builder: (context, snapshot) {
        var isSoundEnabled = snapshot.data;

        return IconButton(
          icon: isSoundEnabled!
              ? Icon(
                  Icons.music_note,
                  color: Colors.black,
                )
              : Icon(
                  Icons.music_off,
                  color: Colors.black,
                ),
          onPressed: () => audioPlayerBloc.setIsSoundEnabled(),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    var prefs = await SharedPreferences.getInstance();
    var isAudioPlaying = (prefs.getBool('isAudioPlaying') ?? true);

    switch (state) {
      case AppLifecycleState.inactive:
        print('Inactive');
        await audioPlayer.pause();
        break;
      case AppLifecycleState.paused:
        print('Paused');
        await audioPlayer.pause();
        break;
      case AppLifecycleState.resumed:
        print('Resumed');
        if (isAudioPlaying) {
          await audioPlayer.resume();
        }
        break;
      case AppLifecycleState.detached:
        print('detached');
        await audioPlayer.stop();
        await audioPlayer.release();
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.release();
    audioPlayer.dispose();
    audioCache.clearAll();
    WidgetsBinding.instance!.removeObserver(this);
  }
}
