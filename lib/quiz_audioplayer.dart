// import 'package:audioplayer/audioplayer.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizAudioPlayer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return QuizAudioPlayerState();
  }
}

class QuizAudioPlayerState extends State<QuizAudioPlayer>
    with WidgetsBindingObserver {
  bool isAudioPlaying = true;
  late AudioCache audioCache;
  AudioPlayer audioPlayer = AudioPlayer();

  var _futureloadIsPlaying;

  void _playerInit() async {
    audioCache = AudioCache(prefix: 'assets/music/', fixedPlayer: audioPlayer);
    // audioCache.clearCache();
    await audioCache.loop('Shadowing - Corbyn Kites.mp3', isNotification: true);

    if (!isAudioPlaying) {
      await audioPlayer.pause();
    }
  }

  void _soundButton() async {
    var prefs = await SharedPreferences.getInstance();
    if (isAudioPlaying) {
      await audioPlayer.pause();
      setState(() {
        isAudioPlaying = false;
      });
      await prefs.setBool('isAudioPlaying', false);
    } else {
      await audioPlayer.resume();
      setState(() {
        isAudioPlaying = true;
      });
      await prefs.setBool('isAudioPlaying', true);
    }
  }

  Future<bool> loadIsPlaying() async {
    var prefs = await SharedPreferences.getInstance();
    isAudioPlaying = (prefs.getBool('isAudioPlaying') ?? true);

    return isAudioPlaying;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _futureloadIsPlaying,
      builder: (context, snapshot) {
        return IconButton(
          icon: isAudioPlaying
              ? Icon(
                  Icons.music_note,
                  color: Colors.black,
                )
              : Icon(
                  Icons.music_off,
                  color: Colors.black,
                ),
          onPressed: _soundButton,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _futureloadIsPlaying = loadIsPlaying();
    _playerInit();

    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        print('Inactive');
        audioPlayer.pause();
        break;
      case AppLifecycleState.paused:
        print('Paused');
        audioPlayer.pause();
        break;
      case AppLifecycleState.resumed:
        print('Resumed');
        if (isAudioPlaying) {
          audioPlayer.resume();
        }
        break;
      case AppLifecycleState.detached:
        print('detached');
        audioPlayer.stop();
        audioPlayer.release();
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
