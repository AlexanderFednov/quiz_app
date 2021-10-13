import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:quiz_app/current_user/current_user_bloc.dart';
import 'package:quiz_app/leaderboard/leaderboard_bloc.dart';
import 'package:quiz_app/localization/localization_bloc.dart';
import 'package:quiz_app/questions/questions_bloc.dart';
import 'package:quiz_app/questions/questions_model.dart';
import 'package:quiz_app/quizScreen/quiz_logic_bloc.dart';
import 'package:quiz_app/data/load_questions_data.dart';
import 'package:quiz_app/models/moor_database.dart';
import 'package:quiz_app/quizScreen/quiz_logic_model.dart';
import 'package:quiz_app/quiz_audioplayer.dart';
import 'package:quiz_app/screens/registration/registration_bloc.dart';
import 'package:quiz_app/user_list/user_list_bloc.dart';
import 'package:quiz_app/user_information/user_information_bloc.dart';

import 'leaderboard/leaderboard_widget.dart';
import 'quizScreen/quiz_widget.dart';
import 'screens/main_page.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'generated/l10n.dart';
import 'models/hive_user_data.dart';


import './quiz_audioplayer.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

import './data/load_questions_data.dart';
import 'package:easy_dispose_provider/easy_dispose_provider.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserResultAdapter());
  Hive.registerAdapter(UserDataAdapter());
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
        DisposableProvider<QuizLogicBloc>(
          create: (context) => QuizLogicBloc(
            moorDatabase: Provider.of<MyDatabase>(context, listen: false),
            leaderboardBloc:
                Provider.of<LeaderboardBloc>(context, listen: false),
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
        DisposableProvider<QuestionsBloc>(
          create: (context) => QuestionsBloc(),
        ),
        DisposableProvider<LocalizationBloc>(
          create: (context) => LocalizationBloc(),
        ),
        DisposableProvider<UserInformationBloc>(
          create: (context) => UserInformationBloc(),
        ),
        ChangeNotifierProvider.value(
          value: LoadQuestionsData(),
        ),
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
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return LeaderBoardWidget();
              }));
            },
          ),
          QuizAudioPlayer(),
        ],
      ),
      body: const _MainPageView(),
    );
  }
}

class _MainPageView extends StatefulWidget {
  const _MainPageView();

  @override
  State<StatefulWidget> createState() {
    return _MainPageViewState();
  }
}

class _MainPageViewState extends State<_MainPageView> {
  _MainPageViewState();

  PageController cont = PageController();

  @override
  void dispose() {
    cont.dispose();
    super.dispose();
  }

  void _swap(int number) {
    cont.animateToPage(
      number,
      duration: (Duration(seconds: 1)),
      curve: Curves.easeInOut,
    );
  }

  void _toMainPage() {
    cont.animateToPage(
      0,
      duration: (Duration(seconds: 1)),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    var logicBloc = Provider.of<QuizLogicBloc>(context);
    var questionsBloc = Provider.of<QuestionsBloc>(context);

    logicBloc.logicStream.listen((logicModel) {
      switch (logicModel.quizStatus) {
        case QuizStatus.reset:
        case QuizStatus.completed:
          _toMainPage();
          break;
        case QuizStatus.inProgress:
          _swap(logicModel.categoryNumber);
          break;
        case QuizStatus.error:
          _toMainPage();
          questionsBloc.loadData();
          break;
        case QuizStatus.notStarted:
        default:
          null;
      }
    });

    return StreamBuilder<QuestionsModel>(
      stream: questionsBloc.questionsStream,
      initialData: questionsBloc.questionsState,
      builder: (context, snapshot) {
        var questions = snapshot.data;

        return PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: cont,
          children: <Widget>[
            const MainPage(),
            QuizScreenWidget(
              questions: questions!.questionsGeneral,
              imageUrl:
                  'https://pryamoj-efir.ru/wp-content/uploads/2017/08/Andrej-Malahov-vedushhij-Pryamoj-efir.jpg',
            ),
            QuizScreenWidget(
              questions: questions.questionsMovies,
              imageUrl:
                  'https://ic.pics.livejournal.com/dubikvit/65747770/4248710/4248710_original.jpg',
            ),
            QuizScreenWidget(
              questions: questions.questionsSpace,
              imageUrl:
                  'https://cubiq.ru/wp-content/uploads/2020/02/Space-780x437.jpg',
            ),
            QuizScreenWidget(
              questions: questions.questionsWeb,
              imageUrl:
                  'https://cdngol.nekkimobile.ru/images/original/materials/sections/69670/69670.png',
            ),
          ],
        );
      },
    );
  }
}
