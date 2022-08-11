import 'package:easy_dispose_provider/easy_dispose_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/audio_player/audio_player_bloc.dart';
import 'package:quiz_app/current_user/current_user_bloc.dart';
import 'package:quiz_app/generated/l10n.dart';
import 'package:quiz_app/leaderboard/leaderboard_bloc.dart';
import 'package:quiz_app/leaderboard/models/moor_database.dart';
import 'package:quiz_app/localization/localization_bloc.dart';
import 'package:quiz_app/main.dart';
import 'package:quiz_app/questions/questions_bloc.dart';
import 'package:quiz_app/quiz_screen/quiz_logic_bloc.dart';
import 'package:quiz_app/registration/models/hive_user_data.dart';
import 'package:quiz_app/registration/registration_bloc.dart';
import 'package:quiz_app/routes/routes.dart';
import 'package:quiz_app/user_information/user_information_bloc.dart';
import 'package:quiz_app/user_list/user_list_bloc.dart';

Widget app({required Widget child, required Box<UserData> hiveBox}) {
  return MultiProvider(
      providers: [
        Provider<MyDatabase>(
          create: (_) => MyDatabase(),
        ),
        DisposableProvider<LeaderboardBloc>(
          create: (context) => LeaderboardBloc(
            moorDatabase: Provider.of<MyDatabase>(context, listen: false),
          ),
        ),
        DisposableProvider<QuestionsBloc>(
          create: (context) => QuestionsBloc(),
        ),
        DisposableProvider<QuizLogicBloc>(
          create: (context) => QuizLogicBloc(
            moorDatabase: Provider.of<MyDatabase>(context, listen: false),
            leaderboardBloc:
                Provider.of<LeaderboardBloc>(context, listen: false),
            questionsBloc: Provider.of<QuestionsBloc>(context, listen: false),
          ),
        ),
        DisposableProvider<CurrentUserBloc>(
          create: (context) => CurrentUserBloc(
            hiveBox: hiveBox,
          ),
        ),
        DisposableProvider<UserListBloc>(
          create: (context) => UserListBloc(
            currentUserBloc:
                Provider.of<CurrentUserBloc>(context, listen: false),
            hiveBox: hiveBox,
          ),
        ),
        DisposableProvider<RegistrationBloc>(
          create: (context) => RegistrationBloc(
            userListBloc: Provider.of<UserListBloc>(context, listen: false),
            hiveBox: hiveBox,
          ),
        ),

        DisposableProvider<LocalizationBloc>(
          create: (context) => LocalizationBloc(),
        ),
        DisposableProvider<UserInformationBloc>(
          create: (context) => UserInformationBloc(),
        ),
        Provider<AudioPlayerBloc>(
          create: (context) => AudioPlayerBloc(),
          dispose: (context, audioPlayerBloc) => audioPlayerBloc.dispose(),
        ),
        // ChangeNotifierProvider.value(
        //   value: LoadQuestionsData(),
        // ),
      ],
      child: MaterialApp(
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        locale: Locale('ru', 'RU'),
        theme: ThemeData(
            // platform: TargetPlatform.iOS,
            ),
        navigatorKey: navigatorKey,
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: '/',
        home: child,
      ));
}
