import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:quiz_app/bloc/current_user_class.dart';
import 'package:quiz_app/bloc/localization_bloc.dart';
import 'package:quiz_app/quizScreen/new_logic_ultimate.dart';
import 'package:quiz_app/data/load_questions_data.dart';
import 'package:quiz_app/models/moor_database.dart';
import 'package:quiz_app/quiz_audioplayer.dart';
import 'package:quiz_app/screens/registration/registration_bloc.dart';

import 'quizScreen/quiz.dart';
import 'screens/main_page.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'generated/l10n.dart';
import 'models/hive_user_data.dart';

import 'screens/leaderboard.dart';
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
  await Hive.openBox<UserData>('UserData1Learn');
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
        DisposableProvider<NewLogicUltimate>(
          create: (context) => NewLogicUltimate(
            moorDatabase: Provider.of<MyDatabase>(context, listen: false),
          ),
        ),
        DisposableProvider<RegistrationBloc>(
          create: (context) => RegistrationBloc(),
        ),
        ChangeNotifierProvider.value(value: CurrentUserClass()),
        ChangeNotifierProvider.value(value: LoadQuestionsData()),
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
        home: MyApp(),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  var questionsData = LoadQuestionsData();
  var _futureloadQuestions;

  PageController cont = PageController();

  void swap(int number) {
    var logic = Provider.of<NewLogicUltimate>(context, listen: false);

    cont.animateToPage(
      number,
      duration: (Duration(seconds: 1)),
      curve: Curves.easeInOut,
    );
    logic.setCategorynumber(number);
  }

  void onMainPage() {
    cont.animateToPage(
      0,
      duration: (Duration(seconds: 1)),
      curve: Curves.easeInOut,
    );
  }

//localization select

  void localeRu() {
    setState(() {
      S.load(Locale('ru', 'RU'));
    });
  }

  void localeEn() {
    setState(() {
      S.load(Locale('en', 'EN'));
    });
  }

  MyAppState() {
    _futureloadQuestions = questionsData.loadQuestions();
  }

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
                return LeaderBoard();
              }));
            },
          ),
          QuizAudioPlayer(),
        ],
      ),
      body: _appPageView(),
    );
  }

  Widget _appPageView() {
    var logic = Provider.of<NewLogicUltimate>(context);
    return FutureBuilder(
      future: _futureloadQuestions,
      builder: (context, snapshot) {
        return PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: cont,
          children: <Widget>[
            _appMainPage(),
            Quiz(
              questions: questionsData.questionAll,
              resetQuiz: () {
                logic.resetQuiz();
                onMainPage();
              },
              onMainPage: () {
                onMainPage();
                logic.nullifyLogic();
              },
              loadData: questionsData.loadData,
              imageUrl:
                  'https://pryamoj-efir.ru/wp-content/uploads/2017/08/Andrej-Malahov-vedushhij-Pryamoj-efir.jpg',
            ),
            Quiz(
              questions: questionsData.questionFilms,
              resetQuiz: () {
                logic.resetQuiz();
                onMainPage();
              },
              onMainPage: () {
                onMainPage();
                logic.nullifyLogic();
              },
              loadData: questionsData.loadData,
              imageUrl:
                  'https://ic.pics.livejournal.com/dubikvit/65747770/4248710/4248710_original.jpg',
            ),
            Quiz(
              questions: questionsData.questionSpace,
              resetQuiz: () {
                logic.resetQuiz();
                onMainPage();
              },
              onMainPage: () {
                onMainPage();
                logic.nullifyLogic();
              },
              loadData: questionsData.loadData,
              imageUrl:
                  'https://cubiq.ru/wp-content/uploads/2020/02/Space-780x437.jpg',
            ),
            Quiz(
              questions: questionsData.questionWeb,
              resetQuiz: () {
                logic.resetQuiz();
                onMainPage();
              },
              onMainPage: () {
                onMainPage();
                logic.nullifyLogic();
              },
              loadData: questionsData.loadData,
              imageUrl:
                  'https://cdngol.nekkimobile.ru/images/original/materials/sections/69670/69670.png',
            ),
          ],
        );
      },
    );
  }

  Widget _appMainPage() {
    return MainPage(
      swap1: () => swap(1),
      swap2: () => swap(2),
      swap3: () => swap(3),
      swap4: () => swap(4),
      localeRu: localeRu,
      localeEn: localeEn,
    );
  }
}
