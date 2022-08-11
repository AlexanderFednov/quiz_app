// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:quiz_app/registration/registration_widget.dart';
// import 'package:quiz_app/screens/leaderboard.dart';
// import 'package:quiz_app/user_list/user_list_widget.dart';

// import 'package:quiz_app/main.dart';

// void main() {
//   testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//     // Build our app and trigger a frame.
//     await tester.pumpWidget(MyApp());

//     // Verify that our counter starts at 0.
//     expect(find.text('0'), findsOneWidget);
//     expect(find.text('1'), findsNothing);

//     // Tap the '+' icon and trigger a frame.
//     await tester.tap(find.byIcon(Icons.add));
//     await tester.pump();

//     // Verify that our counter has incremented.
//     expect(find.text('0'), findsNothing);
//     expect(find.text('1'), findsOneWidget);
//   });
// }

// void main() {
//   testWidgets('QuizAppTest', (WidgetTester tester) async {
//     await tester.pumpWidget(RegistrationScreenWidget());
//     await tester.enterText(find.byType(TextField), 'Рубилов');
//     await tester.tap(find.widgetWithText(ElevatedButton, 'Добавить'));
//   });
// }

// import 'package:flutter_test/flutter_test.dart';
// import 'package:quiz_app/main.dart';

// void main() {
//   testWidgets('learning_test', (WidgetTester tester) async {
//     await tester.pumpWidget(QuizApp());

//     expect(find.text('Fednov Studios 2021'), findsOneWidget);
//   });
// }

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quiz_app/current_user/current_user_bloc.dart';
import 'package:quiz_app/localization/localization_bloc.dart';
import 'package:quiz_app/questions/questions_bloc.dart';
import 'package:quiz_app/registration/models/hive_user_data.dart';
import 'package:quiz_app/registration/registration_bloc.dart';
import 'package:quiz_app/registration/registration_model.dart';
import 'package:quiz_app/user_list/user_list_bloc.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserResultAdapter());
  Hive.registerAdapter(UserDataAdapter());
  Hive.registerAdapter(CategoryAdapter());
  // await Hive.openBox<UserData>('UserData1');
  await Hive.openBox<UserData>('test_box');

  test('locaLization_test', () {
    var localizationBloc = LocalizationBloc();

    expect(
      localizationBloc.localizationState.currentLocale,
      Locale('ru', 'RU'),
    );

    localizationBloc.setLocaleEn();

    expect(
      localizationBloc.localizationState.currentLocale,
      Locale('en', 'EN'),
    );

    localizationBloc.setLocaleRu();

    expect(
      localizationBloc.localizationState.currentLocale,
      Locale('ru', 'RU'),
    );
  });

  test('registration_test', () async {
    var testBox = Hive.box<UserData>('test_box');

    var registrationBloc = RegistrationBloc(
      userListBloc: UserListBloc(
        currentUserBloc: CurrentUserBloc(
          hiveBox: testBox,
        ),
        hiveBox: testBox,
      ),
      hiveBox: testBox,
    );

    expect(registrationBloc.userName, '');

    registrationBloc.onUserNameChanged('text');
    expect(registrationBloc.userName, 'text');

    expect(registrationBloc.registrationState.isRegistrationValid, true);

    registrationBloc.onRegistrationSubmit();

    registrationBloc.onUserNameChanged('text');

    expect(registrationBloc.registrationState.isRegistrationValid, false);
    registrationBloc.onRegistrationSubmit();

    print(testBox.values.toList()[0].userName);
    await testBox.clear();

    print(
        'testBox.values.toList()[0].userName: ${testBox.values.toList().isNotEmpty ? testBox.values.toList()[0].userName : 'Empty'}');
  });
}
