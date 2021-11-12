// import 'package:audioplayer/audioplayer.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/audio_player/audio_player_bloc.dart';

import 'package:quiz_app/main.dart';

class QuizAudioPlayerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => QuizAudioPlayerWidgetState(
        audioPlayerBloc: Provider.of<AudioPlayerBloc>(
          navigatorKey.currentContext!,
          listen: false,
        ),
      );
}

class QuizAudioPlayerWidgetState extends State<QuizAudioPlayerWidget>
    with WidgetsBindingObserver {
  QuizAudioPlayerWidgetState({required this.audioPlayerBloc});

  final AudioPlayerBloc audioPlayerBloc;

  @override
  Widget build(BuildContext context) {
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
  void dispose() {
    super.dispose();

    WidgetsBinding.instance!.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.inactive:
        print('Inactive');
        audioPlayerBloc.pause();
        break;
      case AppLifecycleState.paused:
        print('Paused');
        audioPlayerBloc.pause();
        break;
      case AppLifecycleState.resumed:
        print('Resumed');
        if (audioPlayerBloc.isSoundEnabled) {
          audioPlayerBloc.resume();
        }
        break;
      case AppLifecycleState.detached:
        print('detached');
        audioPlayerBloc.stop();
        break;
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addObserver(this);
  }
}
