import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:animated_button/animated_button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:intl/intl.dart';
//import 'package:json_annotation/json_annotation.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';
//import 'package:intl/intl.dart';
import '../generated/l10n.dart';
import '../models/hive_userData.dart';
import '../screens/userList.dart';
import '../screens/user_Information.dart';
// import '../screens/learning.dart';
// import 'package:google_fonts/google_fonts.dart';

class MainPage extends StatelessWidget {
  final Function swap1;
  final Function swap2;
  final Function swap3;
  final Function swap4;
  final Function localeRu;
  final Function localeEn;
  final int savedResult;
  final int questionsLenght;
  final UserData currentUser;
  final Function setCurrentUser;
  final Function clearCurrentUser;

  MainPage({
    @required this.swap1,
    @required this.swap2,
    @required this.swap3,
    @required this.swap4,
    @required this.localeRu,
    @required this.localeEn,
    @required this.savedResult,
    @required this.questionsLenght,
    @required this.currentUser,
    @required this.setCurrentUser,
    @required this.clearCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    const colorizeColors = [
      Colors.pink,
      Colors.purple,
      Colors.blue,
      Colors.yellow,
      Colors.red,
    ];
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: CachedNetworkImageProvider(
                  'https://ped-kopilka.ru/images/photos/medium/article8962.jpg'),
              fit: BoxFit.cover)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: [
              Container(
                // color: Colors.white,
                child: SizedBox(
                  height: 45,
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      color: Colors.pink,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      // fontFamily: 'OrelegaOne',
                      // decoration: TextDecoration.underline,
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          S.of(context).title,
                          textStyle: TextStyle(
                            color: Colors.pink,
                            // fontFamily: 'OrelegaOne',
                          ),
                          speed: Duration(milliseconds: 200),
                        ),
                        ColorizeAnimatedText(S.of(context).title,
                            textStyle: TextStyle(
                              color: Colors.pink,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                            speed: Duration(milliseconds: 200),
                            colors: colorizeColors),
                        ColorizeAnimatedText(S.of(context).title,
                            textStyle: TextStyle(
                              color: Colors.pink,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                            speed: Duration(milliseconds: 200),
                            colors: colorizeColors),
                        // ScaleAnimatedText(S.of(context).title,
                        //     duration: Duration(milliseconds: 1000),
                        //     textStyle: TextStyle(
                        //       color: Colors.pink,
                        //       fontSize: 40,
                        //       fontWeight: FontWeight.bold,
                        //     ))
                      ],
                      isRepeatingAnimation: true,
                      repeatForever: true,
                      onTap: () {
                        print('Tap Event');
                      },
                    ),
                  ),
                ),
              ),
              // Container(
              //   color: Colors.white,
              //   child: Column(
              //     children: [
              //       Text(
              //         S.of(context).title,
              //         style: TextStyle(
              //           color: Colors.pink,
              //           fontSize: 40,
              //           fontWeight: FontWeight.bold,
              //           decoration: TextDecoration.underline,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Text(
                S.of(context).lastResult(savedResult, questionsLenght),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              if (currentUser != null)
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(S.of(context).helloMessage(currentUser.userName),
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Lobster',
                      )),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => UserList(
                                  setCurrentUser: setCurrentUser,
                                  clearCurrentUser: clearCurrentUser,
                                ))),
                    child: Text(
                        currentUser != null
                            ? S.of(context).changeUser
                            : S.of(context).selectUser,
                        style: TextStyle(fontSize: 15)),
                  ),
                  if (currentUser != null)
                    TextButton(
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  UserInformation(user: currentUser))),
                      child: Text(S.of(context).information,
                          style: TextStyle(fontSize: 15)),
                    )
                ],
              )
            ],
          ),
          Center(
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.pink, width: 10)),
                child: Column(
                  children: <Widget>[
                    Text(
                      S.of(context).categotyChoice,
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 190,
                      width: 300,
                      child: ListView(
                        children: [
                          CategoryButton(
                            category: S.of(context).questionsAll,
                            swap: swap1,
                            categoryColor: Colors.yellow,
                          ),
                          CategoryButton(
                            category: S.of(context).questionsFilms,
                            swap: swap2,
                            categoryColor: Colors.redAccent,
                          ),
                          CategoryButton(
                            category: S.of(context).questionsSpace,
                            swap: swap3,
                            categoryColor: Colors.blue[800],
                          ),
                          CategoryButton(
                            category: S.of(context).questionsWeb,
                            swap: swap4,
                            categoryColor: Colors.indigoAccent,
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedButton(
                onPressed: localeRu,
                width: 110,
                height: 30,
                color: Colors.cyan,
                child: Text('Русский',
                    style: TextStyle(color: Colors.black, fontSize: 20)),
              ),
              SizedBox(
                width: 10,
              ),
              AnimatedButton(
                onPressed: localeEn,
                width: 110,
                height: 30,
                color: Colors.pink[100],
                child: Text(
                  'English',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              )
            ],
          ),
          Column(
            children: [
              Text(
                'Fednov Studios 2021',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 15,
                    color: Colors.black),
              ),
              // TextButton(
              //   onPressed: () => Navigator.of(context)
              //       .push(MaterialPageRoute(builder: (context) => Learning())),
              //   child: Text('Учебка'),
              // )
            ],
          )
        ],
      ),
    );
  }

  // @override
  // void initState() {
  //   super.initState();
  // }
}

class CategoryButton extends StatelessWidget {
  final String category;
  final Function swap;
  final Color categoryColor;

  CategoryButton({this.category, this.swap, this.categoryColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(color: categoryColor),
      child: TextButton(
        onPressed: swap,
        child: Text(
          category,
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    );
  }
}
