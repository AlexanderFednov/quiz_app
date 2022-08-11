import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:integration_test/integration_test.dart';
import 'package:quiz_app/main.dart';
import 'package:quiz_app/audio_player/audio_player_widget.dart';

import 'package:quiz_app/main.dart' as app;

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    print('Test begun');
  });

  tearDown(() {
    print('Test done');
  });

  group('test_group', () {
    testWidgets(
      'audioplayer_button',
      (WidgetTester tester) async {
        await app.main();
        await tester.pumpAndSettle();

        final audioPlayerButton = find.byKey(ValueKey('audioplayer_button'));

        await tester.tap(audioPlayerButton);
        await tester.pump(Duration(seconds: 5));

        await tester.tap(audioPlayerButton);
        await tester.pump(Duration(seconds: 5));
      },
    );

    testWidgets(
      'localization_change',
      (WidgetTester tester) async {
        await app.main();
        await tester.pumpAndSettle();

        final localizationButtonEn = find.byType(AnimatedButton).at(1);
        final localizationButtonRu = find.byType(AnimatedButton).at(0);

        await tester.tap(localizationButtonEn);
        await tester.pump(Duration(seconds: 5));

        await tester.tap(localizationButtonRu);
        await tester.pump(Duration(seconds: 5));
      },
    );

    testWidgets(
      'registration_test',
      (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();

        final NavigatorState navigator = tester.state(find.byType(Navigator));
        final textField = find.byType(TextField);

        await tester.ensureVisible(find.text('Выберите пользователя'));
        await tester.tap(find.text('Выберите пользователя'));
        await tester.pumpAndSettle();

        await tester.ensureVisible(find.byType(FloatingActionButton));
        await tester.tap(find.byType(FloatingActionButton));
        await tester.pumpAndSettle();

        await tester.ensureVisible(find.byType(TextField));
        await tester.enterText(textField, 'Григорий');
        await tester.pumpAndSettle();

        await tester.tap(find.byType(ElevatedButton).at(0));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Григорий'));
        await tester.pumpAndSettle();

        navigator.pop();
      },
    );

    testWidgets(
      'quiz_run',
      (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();

        await tester.pump(Duration(seconds: 3));

        await tester.tap(find.text('Общие вопросы'));
        await tester.pump(Duration(seconds: 3));

        await tester.tap(find.byType(ElevatedButton).at(2));
        await tester.pumpAndSettle();

        await tester.tap(find.byType(ElevatedButton).at(1));
        await tester.pumpAndSettle();

        await tester.tap(find.byType(ElevatedButton).at(1));
        await tester.pumpAndSettle();

        await tester.tap(find.byType(ElevatedButton).at(1));
        await tester.pumpAndSettle();

        await tester.tap(find.byType(ElevatedButton).at(1));
        await tester.pumpAndSettle();

        await tester.pump(Duration(seconds: 5));

        await tester.tap(find.byType(TextButton));
        await tester.pumpAndSettle();
      },
    );

    testWidgets(
      'leaderboard',
      (WidgetTester tester) async {
        await app.main();
        await tester.pumpAndSettle();

        final leaderboardButton = find.byKey(ValueKey('leaderboard_button'));
        final NavigatorState navigator = tester.state(find.byType(Navigator));

        await tester.tap(leaderboardButton);
        await tester.pump(Duration(seconds: 3));

        expect(find.text('Обнулить'), findsOneWidget);
        expect(find.text('Лидеры'), findsOneWidget);

        await tester.pump(Duration(seconds: 7));

        await tester.tap(find.text('Обнулить'));
        await tester.pump(Duration(seconds: 3));

        await tester.pump(Duration(seconds: 1));

        await tester.tap(find.text('Да'));
        await tester.pump(Duration(seconds: 3));

        await tester.pump(Duration(seconds: 5));

        navigator.pop();
        await tester.pumpAndSettle();
      },
    );
  });
}
