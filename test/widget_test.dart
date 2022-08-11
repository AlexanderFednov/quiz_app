import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quiz_app/generated/l10n.dart';
import 'package:quiz_app/leaderboard/leaderboard_widget.dart';
import 'package:quiz_app/main.dart';
import 'package:quiz_app/main_page/main_page_widget.dart';
import 'package:quiz_app/registration/models/hive_user_data.dart';
import 'package:quiz_app/registration/registration_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/generated/l10n.dart';
import 'package:quiz_app/registration/registration_bloc.dart';
import 'package:quiz_app/registration/registration_model.dart';
import 'package:easy_dispose_provider/easy_dispose_provider.dart';
import 'package:quiz_app/user_list/user_list_bloc.dart';
import 'package:quiz_app/user_list/user_list_widget.dart';

void main() async {
  testWidgets('widget_test', (WidgetTester tester) async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserResultAdapter());
    Hive.registerAdapter(UserDataAdapter());
    Hive.registerAdapter(CategoryAdapter());
    // await Hive.openBox<UserData>('UserData1');
    // await Hive.openBox<UserData>('test_box_2');
    await tester.runAsync(() => Hive.openBox<UserData>('test_box_2'));

    final hiveBox = await Hive.box<UserData>('test_box_2');

    await tester.pumpWidget(DisposableProvider<RegistrationBloc>(
      create: (context) => RegistrationBloc(
        userListBloc: Provider.of<UserListBloc>(context, listen: false),
        hiveBox: hiveBox,
      ),
      child: MaterialApp(
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        locale: Locale('ru', 'RU'),
        home: LeaderBoardWidget(),
      ),
    ));

    // expect(find.text('+'), findsWidgets);

    // expect(find.byType(ElevatedButton), findsOneWidget);
  });

  // test('description', () {
  //   var a = 5;
  //   var b = 10;

  //   var c = a * b;

  //   expect(c, 50);
  // });
}
