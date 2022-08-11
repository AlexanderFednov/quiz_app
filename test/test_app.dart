import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quiz_app/audio_player/audio_player_widget.dart';
import 'package:quiz_app/leaderboard/leaderboard_widget.dart';
import 'package:quiz_app/main.dart';
import 'package:quiz_app/main_page/main_page_widget.dart';
import 'package:quiz_app/quiz_screen/quiz_widget.dart';
import 'package:quiz_app/registration/models/hive_user_data.dart';

void main() {
  testWidgets('test_app', (WidgetTester tester) async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserResultAdapter());
    Hive.registerAdapter(UserDataAdapter());
    Hive.registerAdapter(CategoryAdapter());
    await tester.runAsync(() => Hive.openBox<UserData>('test_box_2'));

    final hiveBox = await Hive.box<UserData>('test_box_2');

    await tester.pumpWidget(QuizApp(hiveBox: hiveBox));

    await tester.pumpAndSettle();

    await tester.tap(find.byKey(ValueKey('leaderboard_button')));

    await tester.pump(Duration(seconds: 3));

    expect(find.byType(QuizAudioPlayerWidget), findsWidgets);

    expect(find.text('Русский'), findsWidgets);

    expect(find.byType(QuizAudioPlayerWidget), findsWidgets);
  });
}
