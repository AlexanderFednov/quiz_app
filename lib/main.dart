import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/bloc/bloc_data.dart';
import 'package:quiz_app/data/load_questions_data.dart';
import 'package:quiz_app/models/moor_database.dart';
import 'package:quiz_app/quiz_audioplayer.dart';
// import 'package:quiz_app/screens/userList.dart';
import './quiz.dart';
import 'screens/main_page.dart';
// import 'package:flutter/services.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'generated/l10n.dart';
// import 'models/question_list.dart';
import 'models/hive_user_data.dart';

import 'screens/leaderboard.dart';
import './quiz_audioplayer.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

import './data/load_questions_data.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserResultAdapter());
  Hive.registerAdapter(UserDataAdapter());
  await Hive.openBox<UserData>('UserData1');
  await Hive.openBox<UserData>('UserData1Learn');
  runApp(QuizApp());
}

class QuizApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return QuizAppState();
  }
}

class QuizAppState extends State<QuizApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<MyDatabase>(
          create: (_) => MyDatabase(),
        ),
        Provider<MainBloc>(
          create: (_) => MainBloc(),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: MyApp(),
        locale: Locale('ru', 'RU'),
        theme: ThemeData(
            // platform: TargetPlatform.iOS,
            ),
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

class MyAppState extends State<MyApp> with WidgetsBindingObserver {
  var questionsData = LoadQuestionsData();
  var _futureloadQuestions;

  int _categoryNumber = 0;

  final List<String> _lastResults = [];

  UserData currentUser;

  PageController cont = PageController();

// Reset Quiz App

  void _resetQuiz() async {
    var bloc = Provider.of<MainBloc>(context, listen: false);
    var prefs = await SharedPreferences.getInstance();
    var contactBox = Hive.box<UserData>('UserData1');
    if (bloc.questionIndex > 0) {
      setState(() {
        if (currentUser != null) {
          _addHiveUserResult(contactBox, bloc);
          _addMoorUserResult(bloc);
        }

        var timeNow = DateFormat('yyyy-MM-dd (kk:mm)').format(DateTime.now());
        _lastResults.add(
          '${currentUser != null ? '${currentUser.userName} - ' : ''} ${_lastResults.length + 1}) ${bloc.totalScore} / $bloc.questionIndex - $timeNow',
        );
        prefs.setStringList('lastResults', _lastResults);
        bloc.inEvent.add(MainBlocEvent.setQuestionsLenght);
        prefs.setInt('questionsLenght', bloc.questionIndex);
        bloc.inEvent.add(MainBlocEvent.setSavedScore);
        prefs.setInt('saveScore', bloc.totalScore);
        bloc.inEvent.add(MainBlocEvent.questionIndexNullify);
        bloc.inEvent.add(MainBlocEvent.totalScoreNullify);
        bloc.inEvent.add(MainBlocEvent.progressNullify);
      });
    }
    await cont.animateToPage(
      0,
      duration: (Duration(seconds: 1)),
      curve: Curves.easeInOut,
    );
  }

  void _addHiveUserResult(Box<UserData> contactBox, MainBloc bloc) {
    contactBox.values.forEach((element) {
      if (element.isCurrentUser) {
        element.userResult = bloc.totalScore;
        element.userResults.insert(
          0,
          UserResult(
            score: bloc.totalScore,
            questionsLenght: bloc.questionIndex,
            resultDate: DateTime.now(),
            categoryNumber: _categoryNumber,
          ),
        );
        element.save();
      }
    });
  }

  void _addMoorUserResult(MainBloc bloc) {
    Provider.of<MyDatabase>(context, listen: false).insertMoorResult(
      MoorResult(
        id: null,
        name: currentUser.userName,
        result: bloc.totalScore,
        questionsLenght: bloc.questionIndex,
        rightResultsPercent: (100 / bloc.questionIndex * bloc.totalScore),
        categoryNumber: _categoryNumber,
        resultDate: DateTime.now(),
      ),
    );
  }

//When answer question

  void _answerQuestion(bool result) {
    var bloc = Provider.of<MainBloc>(context, listen: false);

    if (result) {
      bloc.inEvent.add(MainBlocEvent.questionIndexIncreement);
      bloc.inEvent.add(MainBlocEvent.totalScoreIncreement);
      bloc.inEvent.add(MainBlocEvent.progressAddTrue);
    } else {
      bloc.inEvent.add(MainBlocEvent.questionIndexIncreement);
      bloc.inEvent.add(MainBlocEvent.progressAddFalse);
    }
  }

//Select User

  // void _selectUser() {
  //   showDialog(
  //       context: context,
  //       builder: (_) => Center(
  //             child: Container(
  //               width: double.infinity,
  //               height: 300,
  //               child: Dialog(
  //                 child: Container(
  //                   decoration: BoxDecoration(
  //                       gradient: LinearGradient(
  //                     begin: Alignment.topCenter,
  //                     colors: [Colors.white, Colors.blue[100], Colors.red[100]],
  //                   )),
  //                   child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         Container(
  //                             margin: EdgeInsets.only(bottom: 20),
  //                             child: Text('Выбор пользователя',
  //                                 style: TextStyle(fontSize: 30))),
  //                         Container(
  //                           child: Text('Текущий пользователь:',
  //                               style: TextStyle(fontSize: 20)),
  //                         ),
  //                         currentUser != null
  //                             ? Column(
  //                                 children: [
  //                                   Container(
  //                                     //margin: EdgeInsets.only(top: 10),
  //                                     child: Text('${currentUser.userName}',
  //                                         style: TextStyle(
  //                                             fontSize: 35,
  //                                             fontWeight: FontWeight.bold)),
  //                                   ),
  //                                   Container(
  //                                     margin:
  //                                         EdgeInsets.symmetric(vertical: 20),
  //                                     child: Row(
  //                                       mainAxisAlignment:
  //                                           MainAxisAlignment.center,
  //                                       children: [
  //                                         TextButton(
  //                                           child: Text('Ок',
  //                                               style: TextStyle(fontSize: 25)),
  //                                           onPressed: () =>
  //                                               Navigator.of(context).pop(),
  //                                         ),
  //                                         TextButton(
  //                                             onPressed: () {
  //                                               Navigator.of(context).pop();
  //                                               Navigator.of(context).push(
  //                                                 MaterialPageRoute(
  //                                                     builder: (context) =>
  //                                                         UserList(
  //                                                           setCurrentUser:
  //                                                               _setCurrentUser,
  //                                                         )),
  //                                               );
  //                                             },
  //                                             child: Text('Изменить',
  //                                                 style:
  //                                                     TextStyle(fontSize: 25)))
  //                                       ],
  //                                     ),
  //                                   )
  //                                 ],
  //                               )
  //                             : Column(
  //                                 children: [
  //                                   Container(
  //                                     //margin: EdgeInsets.all(20),
  //                                     child: Text('Не выбран',
  //                                         style: TextStyle(
  //                                             fontSize: 30,
  //                                             fontWeight: FontWeight.bold)),
  //                                   ),
  //                                   Container(
  //                                     margin: EdgeInsets.only(top: 30),
  //                                     child: Row(
  //                                       mainAxisAlignment:
  //                                           MainAxisAlignment.center,
  //                                       children: [
  //                                         TextButton(
  //                                           child: Text('Ок',
  //                                               style: TextStyle(
  //                                                   fontSize: 25,
  //                                                   color: Colors.grey)),
  //                                           onPressed: () => null,
  //                                         ),
  //                                         TextButton(
  //                                             onPressed: () => {
  //                                                   Navigator.of(context).push(
  //                                                     MaterialPageRoute(
  //                                                         builder: (context) =>
  //                                                             UserList(
  //                                                               setCurrentUser:
  //                                                                   _setCurrentUser,
  //                                                             )),
  //                                                   )
  //                                                 },
  //                                             child: Text(
  //                                               'Выбрать',
  //                                               style: TextStyle(fontSize: 25),
  //                                             ))
  //                                       ],
  //                                     ),
  //                                   )
  //                                 ],
  //                               )
  //                       ]),
  //                 ),
  //               ),
  //             ),
  //           ));
  // }

//Page navigation

  // void swap0() {
  //   cont.animateToPage(0,
  //       duration: (Duration(seconds: 1)), curve: Curves.easeInOut);
  // }

  void swap(int number) {
    cont.animateToPage(
      number,
      duration: (Duration(seconds: 1)),
      curve: Curves.easeInOut,
    );
    _categoryNumber = number;
  }

  void onMainPage() {
    var bloc = Provider.of<MainBloc>(context, listen: false);
    cont.animateToPage(
      0,
      duration: (Duration(seconds: 1)),
      curve: Curves.easeInOut,
    );

    bloc.inEvent.add(MainBlocEvent.totalScoreNullify);
    bloc.inEvent.add(MainBlocEvent.questionIndexNullify);
    bloc.inEvent.add(MainBlocEvent.progressNullify);
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

  // Get current User

  void _getCurrentUser() {
    var contactsBox = Hive.box<UserData>('UserData1');
    if (contactsBox.isNotEmpty) {
      contactsBox.values.forEach((element) {
        if (element.isCurrentUser) {
          currentUser = element;
        }
      });
    } else {
      currentUser = null;
    }
  }

  void _setCurrentUser() {
    var contactsBox = Hive.box<UserData>('UserData1');
    setState(() {
      contactsBox.values.forEach((element) {
        if (element.isCurrentUser) currentUser = element;
      });
    });
  }

  void _clearCurrentUser() {
    setState(() {
      currentUser = null;
    });
  }

  @override
  void initState() {
    super.initState();
    // _loadList();
    // _loadData();
    _getCurrentUser();

    _futureloadQuestions = questionsData.loadQuestions();

    // S.load(Locale('ru', 'RU'));
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   return _selectUser();
    // });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
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
    return FutureBuilder(
      future: _futureloadQuestions,
      builder: (context, snapshot) {
        return PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: cont,
          children: <Widget>[
            _appMainPage(),
            Quiz(
              answerQuestions: _answerQuestion,
              questions: questionsData.questionAll,
              resetQuiz: _resetQuiz,
              onMainPage: onMainPage,
              loadData: questionsData.loadData,
              imageUrl:
                  'https://pryamoj-efir.ru/wp-content/uploads/2017/08/Andrej-Malahov-vedushhij-Pryamoj-efir.jpg',
            ),
            Quiz(
              answerQuestions: _answerQuestion,
              questions: questionsData.questionFilms,
              resetQuiz: _resetQuiz,
              onMainPage: onMainPage,
              loadData: questionsData.loadData,
              imageUrl:
                  'https://ic.pics.livejournal.com/dubikvit/65747770/4248710/4248710_original.jpg',
            ),
            Quiz(
              answerQuestions: _answerQuestion,
              questions: questionsData.questionSpace,
              resetQuiz: _resetQuiz,
              onMainPage: onMainPage,
              loadData: questionsData.loadData,
              imageUrl:
                  'https://cubiq.ru/wp-content/uploads/2020/02/Space-780x437.jpg',
            ),
            Quiz(
              answerQuestions: _answerQuestion,
              questions: questionsData.questionWeb,
              resetQuiz: _resetQuiz,
              onMainPage: onMainPage,
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
      currentUser: currentUser,
      setCurrentUser: _setCurrentUser,
      clearCurrentUser: _clearCurrentUser,
    );
  }
}
