import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/models/moor_database.dart';
// import 'package:quiz_app/screens/userList.dart';
import './quiz.dart';
import 'screens/main_page.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'generated/l10n.dart';
import 'models/questionList.dart';
import 'models/hive_userData.dart';
import 'widgets/progressBar.dart';
import 'screens/leaderBoard.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:audioplayer/audioplayer.dart';
import 'package:path_provider/path_provider.dart';

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
  List<QuestionInside> questionAll;
  List<QuestionInside> questionFilms;
  List<QuestionInside> questionSpace;
  List<QuestionInside> questionWeb = [];

  int _questionIndex = 0;
  int _totalScore = 0;
  int _saveScore = 0;
  int _questionsLenght = 0;
  int _categoryNumber = 0;

  bool isAudionPlaying = true;

  List<Widget> _progress = [];
  List<String> _lastResults = [];

  UserData currentUser;

  AudioPlayer audioPlugin = AudioPlayer();

  String mp3Uri = '';

  Duration position;

// Reset Quiz App

  void _resetQuiz() async {
    cont.animateToPage(0,
        duration: (Duration(seconds: 1)), curve: Curves.easeInOut);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var contactBox = Hive.box<UserData>('UserData1');
    if (_questionIndex > 0)
      setState(() {
        if (currentUser != null) {
          contactBox.values.forEach((element) {
            if (element.isCurrentUser == true) {
              element.userResult = _totalScore;
              element.userResults.insert(
                  0,
                  UserResult(
                      score: _totalScore,
                      questionsLenght: _questionIndex,
                      resultDate: DateTime.now(),
                      categoryNumber: _categoryNumber));
              element.save();
            }
          });
          Provider.of<MyDatabase>(context, listen: false).insertMoorResult(
              MoorResult(
                  id: null,
                  name: currentUser.userName,
                  result: _totalScore,
                  questionsLenght: _questionIndex,
                  rightResultsPercent: (100 / _questionIndex * _totalScore),
                  categoryNumber: _categoryNumber,
                  resultDate: DateTime.now()));
        }
        // MyDatabase().insertMoorResult();
        var timeNow = DateFormat('yyyy-MM-dd (kk:mm)').format(DateTime.now());
        _lastResults.add(
            '${_lastResults.length + 1}) $_totalScore / $_questionIndex - $timeNow');
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

//When answer question

  void _answerQuestion(bool result) {
    if (result == true) {
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

  //Loading savescore value on start

  _loadSaveScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _saveScore = (prefs.getInt('saveScore') ?? 0);
      _questionsLenght = (prefs.getInt('questionsLenght') ?? 0);
      _lastResults = (prefs.getStringList('lastResults') ?? []);
    });
  }

  // void _resetLeaderboard() {
  //   setState(() {
  //     _lastResults = [];
  //   });
  // }

//Load banks of questions

  loadList() async {
    String jsonQuestionAll =
        await rootBundle.loadString('assets/questions/questionsAll.json');
    Map decoded = jsonDecode(jsonQuestionAll);

    var questionListAll = QuestionList.fromJson(decoded).question;

    String jsonQuestionFilms =
        await rootBundle.loadString('assets/questions/questionsFilms.json');
    Map decoded2 = jsonDecode(jsonQuestionFilms);

    var questionListFilms = QuestionList.fromJson(decoded2).question;

    String jsonQuestionSpace =
        await rootBundle.loadString('assets/questions/questionsSpace.json');
    Map decoded3 = jsonDecode(jsonQuestionSpace);

    var questionListSpace = QuestionList.fromJson(decoded3).question;

    setState(() {
      questionAll = questionListAll;
      questionFilms = questionListFilms;
      questionSpace = questionListSpace;
    });
  }

  _loadData() async {
    final responce = await http.get(Uri.http("10.0.2.2:8000", ""));

    if (responce.statusCode == 200) {
      Map decoded = jsonDecode(responce.body);
      var questionListWeb = QuestionList.fromJson(decoded).question;
      print(decoded);
      setState(() {
        questionWeb = questionListWeb;
      });
      //responceText = decoded;
    } else {
      print('Error');
      String jsonQuestionNull =
          await rootBundle.loadString('assets/questions/questionsNull.json');
      Map decoded = jsonDecode(jsonQuestionNull);

      var questionListNull = QuestionList.fromJson(decoded).question;

      setState(() {
        questionWeb = questionListNull;
      });
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

  PageController cont = PageController();

  // void swap0() {
  //   cont.animateToPage(0,
  //       duration: (Duration(seconds: 1)), curve: Curves.easeInOut);
  // }

  void swap1() {
    cont.animateToPage(1,
        duration: (Duration(seconds: 1)), curve: Curves.easeInOut);
    _categoryNumber = 1;
  }

  void swap2() {
    cont.animateToPage(2,
        duration: (Duration(seconds: 1)), curve: Curves.easeInOut);
    _categoryNumber = 2;
  }

  void swap3() {
    cont.animateToPage(3,
        duration: (Duration(seconds: 1)), curve: Curves.easeInOut);
    _categoryNumber = 3;
  }

  void swap4() {
    cont.animateToPage(4,
        duration: (Duration(seconds: 1)), curve: Curves.easeInOut);
    _categoryNumber = 4;
  }

  void onMainPage() {
    cont.animateToPage(0,
        duration: (Duration(seconds: 1)), curve: Curves.easeInOut);
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
    Box<UserData> contactsBox = Hive.box<UserData>('UserData1');
    if (contactsBox.isNotEmpty) {
      contactsBox.values.forEach((element) {
        if (element.isCurrentUser == true) {
          currentUser = element;
        }
      });
    } else
      currentUser = null;
  }

  void _setCurrentUser() {
    Box<UserData> contactsBox = Hive.box<UserData>('UserData1');
    setState(() {
      contactsBox.values.forEach((element) {
        if (element.isCurrentUser == true) currentUser = element;
      });
    });
  }

//Load music

  void _loadMusic() async {
    final ByteData data =
        await rootBundle.load('assets/music/Shadowing - Corbyn Kites.mp3');
    Directory tempDir = await getTemporaryDirectory();
    File tempFile = File('${tempDir.path}/Shadowing - Corbyn Kites.mp3');
    await tempFile.writeAsBytes(data.buffer.asUint8List(), flush: true);
    mp3Uri = tempFile.uri.toString();
    audioPlugin.stop();
    if (isAudionPlaying == true) {
      audioPlugin.play(mp3Uri);
    }
    audioPlugin.onPlayerStateChanged.listen((event) {
      if (event == AudioPlayerState.COMPLETED) {
        audioPlugin.play(mp3Uri);
      }
    });
  }

  void _soundButton() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (isAudionPlaying == true) {
      audioPlugin.pause();
      setState(() {
        isAudionPlaying = false;
      });
      prefs.setBool('isAudioPlaying', false);
    } else {
      audioPlugin.play(mp3Uri);
      setState(() {
        isAudionPlaying = true;
      });
      prefs.setBool('isAudioPlaying', true);
    }
  }

  void _loadIsPlaying() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isAudionPlaying = (prefs.getBool('isAudioPlaying') ?? true);
  }

  @override
  void initState() {
    super.initState();
    loadList();
    _loadSaveScore();
    _loadData();
    _getCurrentUser();
    _loadIsPlaying();
    _loadMusic();

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
    audioPlugin.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).titleAppbar,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
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
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return LeaderBoard();
                }));
              }),
          IconButton(
              icon: isAudionPlaying == true
                  ? Icon(
                      Icons.music_note,
                      color: Colors.black,
                    )
                  : Icon(
                      Icons.music_off,
                      color: Colors.black,
                    ),
              onPressed: _soundButton)
        ],
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: cont,
        children: <Widget>[
          MainPage(
            swap1: swap1,
            swap2: swap2,
            swap3: swap3,
            swap4: swap4,
            localeRu: localeRu,
            localeEn: localeEn,
            savedResult: _saveScore,
            questionsLenght: _questionsLenght,
            currentUser: currentUser,
            setCurrentUser: _setCurrentUser,
          ),
          Quiz(
              answerQuestions: _answerQuestion,
              questionIndex: _questionIndex,
              questions: questionAll,
              resetQuiz: _resetQuiz,
              totalScore: _totalScore,
              onMainPage: onMainPage,
              imageUrl:
                  'https://pryamoj-efir.ru/wp-content/uploads/2017/08/Andrej-Malahov-vedushhij-Pryamoj-efir.jpg',
              progress: _progress),
          Quiz(
              answerQuestions: _answerQuestion,
              questionIndex: _questionIndex,
              questions: questionFilms,
              resetQuiz: _resetQuiz,
              totalScore: _totalScore,
              onMainPage: onMainPage,
              imageUrl:
                  'https://ic.pics.livejournal.com/dubikvit/65747770/4248710/4248710_original.jpg',
              progress: _progress),
          Quiz(
              answerQuestions: _answerQuestion,
              questionIndex: _questionIndex,
              questions: questionSpace,
              resetQuiz: _resetQuiz,
              totalScore: _totalScore,
              onMainPage: onMainPage,
              imageUrl:
                  'https://cubiq.ru/wp-content/uploads/2020/02/Space-780x437.jpg',
              progress: _progress),
          Quiz(
              answerQuestions: _answerQuestion,
              questionIndex: _questionIndex,
              questions: questionWeb,
              resetQuiz: _resetQuiz,
              totalScore: _totalScore,
              onMainPage: onMainPage,
              imageUrl:
                  'https://cdngol.nekkimobile.ru/images/original/materials/sections/69670/69670.png',
              progress: _progress)
        ],
      ),
    );
  }
}
