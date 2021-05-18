import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/data/load_questions_data.dart';
import 'package:quiz_app/models/moor_database.dart';
import 'package:quiz_app/quiz_audioplayer.dart';
// import 'package:quiz_app/screens/userList.dart';
import './quiz.dart';
import 'screens/main_page.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'generated/l10n.dart';
import 'models/question_list.dart';
import 'models/hive_user_data.dart';
import 'widgets/progressbar.dart';
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
    return Provider(
      create: (_) => MyDatabase(),
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
  List<QuestionInside> questionAll;
  List<QuestionInside> questionFilms;
  List<QuestionInside> questionSpace;
  List<QuestionInside> questionWeb = [];

  var questionsData = LoadQuestionsData();
  var _futureloadQuestions;

  int _questionIndex = 0;
  int _totalScore = 0;
  int _saveScore = 0;
  int _questionsLenght = 0;
  int _categoryNumber = 0;

  List<Widget> _progress = [];
  final List<String> _lastResults = [];

  UserData currentUser;

  PageController cont = PageController();

// Reset Quiz App

  void _resetQuiz() async {
    var prefs = await SharedPreferences.getInstance();
    var contactBox = Hive.box<UserData>('UserData1');
    if (_questionIndex > 0) {
      setState(() {
        if (currentUser != null) {
          _addHiveUserResult(contactBox);
          _addMoorUserResult();
        }

        var timeNow = DateFormat('yyyy-MM-dd (kk:mm)').format(DateTime.now());
        _lastResults.add(
          '${currentUser.userName} - ${_lastResults.length + 1}) $_totalScore / $_questionIndex - $timeNow',
        );
        prefs.setStringList('lastResults', _lastResults);
        _questionsLenght = _questionIndex;
        prefs.setInt('questionsLenght', _questionIndex);
        _saveScore = _totalScore;
        prefs.setInt('saveScore', _saveScore);
        _questionIndex = 0;
        _totalScore = 0;
        _progress = [];
      });
    }
    await cont.animateToPage(
      0,
      duration: (Duration(seconds: 1)),
      curve: Curves.easeInOut,
    );
  }

  void _addHiveUserResult(Box<UserData> contactBox) {
    contactBox.values.forEach((element) {
      if (element.isCurrentUser) {
        element.userResult = _totalScore;
        element.userResults.insert(
          0,
          UserResult(
            score: _totalScore,
            questionsLenght: _questionIndex,
            resultDate: DateTime.now(),
            categoryNumber: _categoryNumber,
          ),
        );
        element.save();
      }
    });
  }

  void _addMoorUserResult() {
    Provider.of<MyDatabase>(context, listen: false).insertMoorResult(
      MoorResult(
        id: null,
        name: currentUser.userName,
        result: _totalScore,
        questionsLenght: _questionIndex,
        rightResultsPercent: (100 / _questionIndex * _totalScore),
        categoryNumber: _categoryNumber,
        resultDate: DateTime.now(),
      ),
    );
  }

//When answer question

  void _answerQuestion(bool result) {
    if (result) {
      setState(() {
        _questionIndex = _questionIndex + 1;
        _totalScore++;
        _progress.add(IconTrue());
      });
    } else {
      setState(() {
        _questionIndex = _questionIndex + 1;
        _progress.add(IconFalse());
      });
    }
  }

// Load banks of questions

  void loadList() async {
    var jsonQuestionAll =
        await rootBundle.loadString('assets/questions/questionsAll.json');
    Map decoded = jsonDecode(jsonQuestionAll);

    var questionListAll = QuestionList.fromJson(decoded).question;

    var jsonQuestionFilms =
        await rootBundle.loadString('assets/questions/questionsFilms.json');
    Map decoded2 = jsonDecode(jsonQuestionFilms);

    var questionListFilms = QuestionList.fromJson(decoded2).question;

    var jsonQuestionSpace =
        await rootBundle.loadString('assets/questions/questionsSpace.json');
    Map decoded3 = jsonDecode(jsonQuestionSpace);

    var questionListSpace = QuestionList.fromJson(decoded3).question;

    setState(() {
      questionAll = questionListAll;
      questionFilms = questionListFilms;
      questionSpace = questionListSpace;
    });
  }

  void loadData() async {
    final responce = await http
        .get(Uri.http('10.0.2.2:8000', ''))
        .timeout(Duration(seconds: 3), onTimeout: () => null);

    if (responce != null) {
      Map decoded = jsonDecode(responce.body);
      var questionListWeb = QuestionList.fromJson(decoded).question;
      print(decoded);
      setState(() {
        questionWeb = questionListWeb;
      });
      //responceText = decoded;
    } else {
      print('HTTP error: server is not available');
      // String jsonQuestionNull =
      //     await rootBundle.loadString('assets/questions/questionsNull.json');
      // Map decoded = jsonDecode(jsonQuestionNull);

      // var questionListNull = QuestionList.fromJson(decoded).question;

      // setState(() {
      //   questionWeb = questionListNull;
      // });
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
    cont.animateToPage(
      0,
      duration: (Duration(seconds: 1)),
      curve: Curves.easeInOut,
    );
    setState(() {
      _totalScore = 0;
      _questionIndex = 0;
      _progress = [];
    });
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
              questionIndex: _questionIndex,
              questions: questionsData.questionAll,
              resetQuiz: _resetQuiz,
              totalScore: _totalScore,
              onMainPage: onMainPage,
              loadData: questionsData.loadData,
              imageUrl:
                  'https://pryamoj-efir.ru/wp-content/uploads/2017/08/Andrej-Malahov-vedushhij-Pryamoj-efir.jpg',
              progress: _progress,
            ),
            Quiz(
              answerQuestions: _answerQuestion,
              questionIndex: _questionIndex,
              questions: questionsData.questionFilms,
              resetQuiz: _resetQuiz,
              totalScore: _totalScore,
              onMainPage: onMainPage,
              loadData: questionsData.loadData,
              imageUrl:
                  'https://ic.pics.livejournal.com/dubikvit/65747770/4248710/4248710_original.jpg',
              progress: _progress,
            ),
            Quiz(
              answerQuestions: _answerQuestion,
              questionIndex: _questionIndex,
              questions: questionsData.questionSpace,
              resetQuiz: _resetQuiz,
              totalScore: _totalScore,
              onMainPage: onMainPage,
              loadData: questionsData.loadData,
              imageUrl:
                  'https://cubiq.ru/wp-content/uploads/2020/02/Space-780x437.jpg',
              progress: _progress,
            ),
            Quiz(
              answerQuestions: _answerQuestion,
              questionIndex: _questionIndex,
              questions: questionsData.questionWeb,
              resetQuiz: _resetQuiz,
              totalScore: _totalScore,
              onMainPage: onMainPage,
              loadData: questionsData.loadData,
              imageUrl:
                  'https://cdngol.nekkimobile.ru/images/original/materials/sections/69670/69670.png',
              progress: _progress,
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
      savedResult: _saveScore,
      questionsLenght: _questionsLenght,
      currentUser: currentUser,
      setCurrentUser: _setCurrentUser,
      clearCurrentUser: _clearCurrentUser,
    );
  }
}
