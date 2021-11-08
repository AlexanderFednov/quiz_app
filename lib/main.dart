import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:quiz_app/audio_player/audio_player_bloc.dart';
import 'package:quiz_app/audio_player/audio_player_widget.dart';

import 'package:quiz_app/current_user/current_user_bloc.dart';
import 'package:quiz_app/leaderboard/leaderboard_bloc.dart';
import 'package:quiz_app/localization/localization_bloc.dart';
import 'package:quiz_app/questions/questions_bloc.dart';
import 'package:quiz_app/quiz_screen/quiz_logic_bloc.dart';

import 'package:quiz_app/leaderboard/models/moor_database.dart';
import 'package:quiz_app/quiz_screen/quiz_logic_model.dart';
import 'package:quiz_app/quiz_audioplayer.dart';
import 'package:quiz_app/error/error_screen.dart';
import 'package:quiz_app/quiz_screen/widgets/result.dart';
import 'package:quiz_app/registration/registration_bloc.dart';
import 'package:quiz_app/routes/routes.dart';
import 'package:quiz_app/user_list/user_list_bloc.dart';
import 'package:quiz_app/user_information/user_information_bloc.dart';

import 'quiz_screen/quiz_widget.dart';
import 'main_page/main_page_widget.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'generated/l10n.dart';
import 'registration/models/hive_user_data.dart';

import './quiz_audioplayer.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

import 'package:easy_dispose_provider/easy_dispose_provider.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserResultAdapter());
  Hive.registerAdapter(UserDataAdapter());
  Hive.registerAdapter(CategoryAdapter());
  await Hive.openBox<UserData>('UserData1');
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          create: (context) => CurrentUserBloc(),
        ),
        DisposableProvider<UserListBloc>(
          create: (context) => UserListBloc(
            currentUserBloc:
                Provider.of<CurrentUserBloc>(context, listen: false),
          ),
        ),
        DisposableProvider<RegistrationBloc>(
          create: (context) => RegistrationBloc(
            userListBloc: Provider.of<UserListBloc>(context, listen: false),
          ),
        ),

        DisposableProvider<LocalizationBloc>(
          create: (context) => LocalizationBloc(),
        ),
        DisposableProvider<UserInformationBloc>(
          create: (context) => UserInformationBloc(),
        ),
        DisposableProvider<AudioPlayerBloc>(
          create: (context) => AudioPlayerBloc(),
        ),
        // ChangeNotifierProvider.value(
        //   value: LoadQuestionsData(),
        // ),
      ],
      child: const QuizMaterialApp(),
    );
  }
}

class QuizMaterialApp extends StatelessWidget {
  const QuizMaterialApp();

  @override
  Widget build(BuildContext context) {
    var localizationBloc = Provider.of<LocalizationBloc>(context);

    return StreamBuilder<Locale>(
      stream: localizationBloc.localizationStream,
      initialData: Locale('ru', 'RU'),
      builder: (context, snapshot) {
        var locale = snapshot.data;

        return MaterialApp(
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          locale: locale,
          theme: ThemeData(
              // platform: TargetPlatform.iOS,
              ),
          onGenerateRoute: RouteGenerator.generateRoute,
          initialRoute: '/',
          home: const QuizAppScaffold(),
        );
      },
    );
  }
}

class QuizAppScaffold extends StatelessWidget {
  const QuizAppScaffold();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            S.of(context).titleAppbar,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
            icon: Icon(
              Icons.emoji_events,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pushNamed(context, RouteGenerator.leaderboard);
            },
          ),
          QuizAudioPlayerWidget(),
        ],
      ),
      body: const QuizAppScaffoldBodyWidget(),
    );
  }
}

class QuizAppScaffoldBodyWidget extends StatelessWidget {
  const QuizAppScaffoldBodyWidget();

  @override
  Widget build(BuildContext context) {
    var logicBloc = Provider.of<QuizLogicBloc>(context);

    return StreamBuilder<QuizStatus>(
      stream: logicBloc.quizStatusStream,
      builder: (context, snapshot) {
        var quizStatus = snapshot.data;

        switch (quizStatus) {
          case QuizStatus.notStarted:
            return const MainPageWidget();
          case QuizStatus.inProgress:
            return QuizScreenWidget(
              imageUrl: _calculateImageUrlForQuizScreen(
                logicBloc.logicState.category!,
              ),
            );
          case QuizStatus.completed:
            return const Result();
          case QuizStatus.error:
            return ErrorScreenWidget(
              errorText: S.of(context).httpServerError,
              buttonText: S.of(context).toMainPage,
              imageUrl: _calculateImageUrlForQuizScreen(
                logicBloc.logicState.category!,
              ),
            );
          default:
            return Container();
        }
      },
    );
  }

  String _calculateImageUrlForQuizScreen(Category category) {
    switch (category) {
      case Category.generalQuestions:
        return 'https://pryamoj-efir.ru/wp-content/uploads/2017/08/Andrej-Malahov-vedushhij-Pryamoj-efir.jpg';
      case Category.moviesOfUSSSR:
        return 'https://ic.pics.livejournal.com/dubikvit/65747770/4248710/4248710_original.jpg';
      case Category.space:
        return 'https://cubiq.ru/wp-content/uploads/2020/02/Space-780x437.jpg';
      case Category.sector13:
        return 'https://cdngol.nekkimobile.ru/images/original/materials/sections/69670/69670.png';
      default:
        throw 'Invalid category';
    }
  }
}
