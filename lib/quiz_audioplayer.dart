import 'dart:io';

import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizAudioPlayer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return QuizAudioPlayerState();
  }
}

class QuizAudioPlayerState extends State<QuizAudioPlayer>
    with WidgetsBindingObserver {
  String mp3Uri;
  bool isAudionPlaying = true;
  AudioPlayer audioPlugin = AudioPlayer();
  Duration position;

  var _futureloadIsPlaying;

  void loadMusic() async {
    final data =
        await rootBundle.load('assets/music/Shadowing - Corbyn Kites.mp3');
    var tempDir = await getTemporaryDirectory();
    var tempFile = File('${tempDir.path}/Shadowing - Corbyn Kites.mp3');
    await tempFile.writeAsBytes(data.buffer.asUint8List(), flush: true);
    mp3Uri = tempFile.uri.toString();
    await audioPlugin.stop();
    if (isAudionPlaying) {
      await audioPlugin.play(mp3Uri);
    }
    audioPlugin.onPlayerStateChanged.listen((event) {
      if (event == AudioPlayerState.COMPLETED) {
        audioPlugin.play(mp3Uri);
      }
    });
    audioPlugin.onAudioPositionChanged.listen((event) {
      position = event;
    });
  }

  void soundButton() async {
    var prefs = await SharedPreferences.getInstance();
    if (isAudionPlaying) {
      await audioPlugin.pause();
      setState(() {
        isAudionPlaying = false;
      });
      await prefs.setBool('isAudioPlaying', false);
    } else {
      await audioPlugin.play(mp3Uri);
      setState(() {
        isAudionPlaying = true;
      });
      await prefs.setBool('isAudioPlaying', true);
    }
  }

  Future loadIsPlaying() async {
    var prefs = await SharedPreferences.getInstance();
    isAudionPlaying = (prefs.getBool('isAudioPlaying') ?? true);

    return Future.value(isAudionPlaying);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _futureloadIsPlaying,
      builder: (context, snapshot) {
        return IconButton(
          icon: isAudionPlaying
              ? Icon(
                  Icons.music_note,
                  color: Colors.black,
                )
              : Icon(
                  Icons.music_off,
                  color: Colors.black,
                ),
          onPressed: soundButton,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _futureloadIsPlaying = loadIsPlaying();
    loadMusic();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        print('Inactive');
        audioPlugin.pause();
        break;
      case AppLifecycleState.paused:
        print('Paused');
        audioPlugin.pause();
        break;
      case AppLifecycleState.resumed:
        print('Resumed');
        audioPlugin.play(mp3Uri);
        break;
      case AppLifecycleState.detached:
        print('detached');
        audioPlugin.stop();
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
    audioPlugin.stop();
    WidgetsBinding.instance.removeObserver(this);
  }
}
