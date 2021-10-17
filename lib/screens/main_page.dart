import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:animated_button/animated_button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/current_user/current_user_bloc.dart';
import 'package:quiz_app/localization/localization_bloc.dart';
import 'package:quiz_app/models/hive_user_data.dart';
import 'package:quiz_app/quiz_screen/quiz_logic_bloc.dart';
// import 'package:quiz_app/screens/learning.dart';
import 'package:quiz_app/user_list/user_list_widget.dart';
import 'package:quiz_app/user_information/user_information_bloc.dart';
import 'package:quiz_app/user_information/user_information_widget.dart';
import 'package:quiz_app/widgets/last_result/last_result_widget.dart';
// import 'package:intl/intl.dart';
//import 'package:json_annotation/json_annotation.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';
//import 'package:intl/intl.dart';
import '../generated/l10n.dart';

import '../widgets/last_result/last_result_widget.dart';
// import '../screens/learning.dart';
// import 'package:google_fonts/google_fonts.dart';

class MainPage extends StatelessWidget {
  const MainPage();

  static final colorizeColors = [
    Colors.pink,
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(
            'https://ped-kopilka.ru/images/photos/medium/article8962.jpg',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const _MainPageTopWidget(),
          const _SelectCategoryWidget(),
          const _LocaleNavigationWidget(),
          Column(
            children: [
              const _StudioFednovSignatureWidget(),
              // TextButton(
              //   onPressed: () => Navigator.of(context)
              //       .push(MaterialPageRoute(builder: (context) => Learning())),
              //   child: Text('Учебка'),
              // )
            ],
          ),
        ],
      ),
    );
  }
}

class _MainPageTopWidget extends StatelessWidget {
  const _MainPageTopWidget();

  @override
  Widget build(BuildContext context) {
    var currentUserBloc = Provider.of<CurrentUserBloc>(context);

    return StreamBuilder<UserData?>(
      stream: currentUserBloc.currentuserStream,
      builder: (context, snapshot) {
        var currentUser = snapshot.data;

        return Column(
          children: [
            const _AnimatedTitleWidget(),
            LastResultWidget(),
            if (currentUser != null)
              Provider.value(
                value: currentUser,
                child: const _GreetingMessageWidget(),
              ),
            const _UserNavigationWidget(),
          ],
        );
      },
    );
  }
}

class _AnimatedTitleWidget extends StatelessWidget {
  const _AnimatedTitleWidget();

  static const colorizeColors = [
    Colors.pink,
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
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
              ColorizeAnimatedText(
                S.of(context).title,
                textStyle: TextStyle(
                  color: Colors.pink,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
                speed: Duration(milliseconds: 200),
                colors: colorizeColors,
              ),
              ColorizeAnimatedText(
                S.of(context).title,
                textStyle: TextStyle(
                  color: Colors.pink,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.end,
                speed: Duration(milliseconds: 200),
                colors: colorizeColors,
              ),
            ],
            isRepeatingAnimation: true,
            repeatForever: true,
          ),
        ),
      ),
    );
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
    // ),,)
  }
}

class _StudioFednovSignatureWidget extends StatelessWidget {
  const _StudioFednovSignatureWidget();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Fednov Studios 2021',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        fontSize: 15,
        color: Colors.black,
      ),
    );
  }
}

class _UserNavigationWidget extends StatelessWidget {
  const _UserNavigationWidget();

  @override
  Widget build(BuildContext context) {
    var currentUserBloc = Provider.of<CurrentUserBloc>(context);
    var userInformationBloc = Provider.of<UserInformationBloc>(context);

    return StreamBuilder<UserData?>(
      stream: currentUserBloc.currentuserStream,
      builder: (context, snapshot) {
        var currentUser = snapshot.data;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => UserListWidget(),
                ),
              ),
              child: Text(
                currentUser != null
                    ? S.of(context).changeUser
                    : S.of(context).selectUser,
                style: TextStyle(fontSize: 15),
              ),
            ),
            if (currentUser != null)
              TextButton(
                onPressed: () {
                  userInformationBloc.selectUser(user: currentUser);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const UserInformationWidget(),
                    ),
                  );
                },
                child: Text(
                  S.of(context).information,
                  style: TextStyle(fontSize: 15),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _GreetingMessageWidget extends StatelessWidget {
  const _GreetingMessageWidget();

  @override
  Widget build(BuildContext context) {
    var currentUser = Provider.of<UserData>(context);

    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        S.of(context).helloMessage(currentUser.userName!),
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w700,
          fontFamily: 'Lobster',
        ),
      ),
    );
  }
}

class _CategoryButtonWidget extends StatelessWidget {
  final String? category;
  final Function? swap;
  final Color? categoryColor;

  _CategoryButtonWidget({this.category, this.swap, this.categoryColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(color: categoryColor),
      child: TextButton(
        onPressed: () => swap!(),
        child: Text(
          category!,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class _SelectCategoryWidget extends StatelessWidget {
  const _SelectCategoryWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.pink, width: 10),
      ),
      child: Column(
        children: <Widget>[
          Text(
            S.of(context).categotyChoice,
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
          ),
          Container(
            height: 190,
            width: 300,
            child: const _CategoriesListWidget(),
          ),
        ],
      ),
    );
  }
}

class _CategoriesListWidget extends StatelessWidget {
  const _CategoriesListWidget();

  @override
  Widget build(BuildContext context) {
    var logicBloc = Provider.of<QuizLogicBloc>(context);

    return ListView(
      children: [
        _CategoryButtonWidget(
          category: S.of(context).questionsAll,
          swap: () => logicBloc.setCategoryNumber(1),
          categoryColor: Colors.yellow,
        ),
        _CategoryButtonWidget(
          category: S.of(context).questionsFilms,
          swap: () => logicBloc.setCategoryNumber(2),
          categoryColor: Colors.redAccent,
        ),
        _CategoryButtonWidget(
          category: S.of(context).questionsSpace,
          swap: () => logicBloc.setCategoryNumber(3),
          categoryColor: Colors.blue[800],
        ),
        _CategoryButtonWidget(
          category: S.of(context).questionsWeb,
          swap: () => logicBloc.setCategoryNumber(4),
          categoryColor: Colors.indigoAccent,
        ),
      ],
    );
  }
}

class _LocaleNavigationWidget extends StatelessWidget {
  const _LocaleNavigationWidget();

  @override
  Widget build(BuildContext context) {
    var localizationBloc = Provider.of<LocalizationBloc>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedButton(
          onPressed: () => localizationBloc.localeRu(),
          width: 110,
          height: 30,
          color: Colors.cyan,
          child: Text(
            'Русский',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        AnimatedButton(
          onPressed: () => localizationBloc.localeEn(),
          width: 110,
          height: 30,
          color: Colors.pink[100]!,
          child: Text(
            'English',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
      ],
    );
  }
}
