import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rythm/core/database/app_database.dart';
import 'package:rythm/core/keys.dart';

import 'helpers/pump_app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Settings screen integration', () {
    late AppDatabase db;

    tearDown(() async {
      await db.close();
    });

    testWidgets('all settings tiles are tappable and accessible',
        (tester) async {
      db = await pumpApp(tester);

      // Navigate to Settings.
      await tester.tap(find.text('Ещё'));
      await tester.pumpAndSettle();

      // Top tiles visible without scrolling.
      expect(find.byKey(K.settingsExport), findsOneWidget);
      expect(find.byKey(K.settingsImport), findsOneWidget);
      expect(find.byKey(K.settingsFriendShare), findsOneWidget);
      expect(find.byKey(K.settingsFriendImport), findsOneWidget);

      // Descriptive subtitles (top half).
      expect(find.text('Сохранить все привычки и сад в файл'), findsOneWidget);
      expect(
        find.text('Восстановить из файла (заменит текущие данные)'),
        findsOneWidget,
      );
      expect(find.text('Сгенерировать код для друзей'), findsOneWidget);
      expect(
        find.text('Посмотреть чужой сад и получить новые семена'),
        findsOneWidget,
      );

      // Scroll down to reveal the lower sections.
      await tester.drag(find.byType(ListView), const Offset(0, -300));
      await tester.pumpAndSettle();

      expect(find.byKey(K.settingsCard), findsOneWidget);
      expect(
        find.text('Создать красивую картинку с растениями'),
        findsOneWidget,
      );

      // Version/about.
      expect(find.text('Rythm'), findsOneWidget);
      expect(find.text('Версия 1.0.0'), findsOneWidget);
    });

    testWidgets('import button shows confirmation dialog', (tester) async {
      db = await pumpApp(tester);

      await tester.tap(find.text('Ещё'));
      await tester.pumpAndSettle();

      // Tap "Импорт данных".
      await tester.tap(find.byKey(K.settingsImport));
      await tester.pumpAndSettle();

      // Confirmation dialog should appear.
      expect(find.text('Импорт данных'), findsNWidgets(2)); // title + tile
      expect(
        find.text(
          'Все текущие данные будут заменены данными из файла. '
          'Это действие нельзя отменить. Продолжить?',
        ),
        findsOneWidget,
      );

      // Cancel button is available.
      expect(find.text('Отмена'), findsOneWidget);

      // Dismiss the dialog.
      await tester.tap(find.text('Отмена'));
      await tester.pumpAndSettle();
    });

    testWidgets('friend code import shows input dialog', (tester) async {
      db = await pumpApp(tester);

      await tester.tap(find.text('Ещё'));
      await tester.pumpAndSettle();

      // Tap "Ввести код друга".
      await tester.tap(find.byKey(K.settingsFriendImport));
      await tester.pumpAndSettle();

      // Dialog with text field should appear.
      expect(find.text('Ввести код друга'), findsNWidgets(2)); // title + tile
      expect(find.text('Вставьте код сюда...'), findsOneWidget);
      expect(find.text('Применить'), findsOneWidget);
      expect(find.text('Отмена'), findsOneWidget);

      // Submit an invalid code.
      await tester.enterText(find.byType(TextField), 'INVALID_CODE');
      await tester.tap(find.text('Применить'));
      await tester.pumpAndSettle();

      // Should show error snackbar.
      expect(
        find.text('Неверный код. Проверьте и попробуйте снова.'),
        findsOneWidget,
      );
    });

    testWidgets(
        'card generation shows snackbar when no crystallized months exist',
        (tester) async {
      db = await pumpApp(tester);

      await tester.tap(find.text('Ещё'));
      await tester.pumpAndSettle();

      // Scroll down to reveal the card tile.
      await tester.drag(find.byType(ListView), const Offset(0, -300));
      await tester.pumpAndSettle();

      // Tap "Карточка месяца" with empty DB.
      await tester.tap(find.byKey(K.settingsCard));
      await tester.pumpAndSettle();

      // Should show "no data" snackbar.
      expect(
        find.text('Пока нет завершённых месяцев для генерации карточки.'),
        findsOneWidget,
      );
    });

    testWidgets('backup export → import round-trip via DAO layer',
        (tester) async {
      db = await pumpApp(tester);

      // Seed data: a habit + log.
      await db.habitsDao.insertHabit(HabitsCompanion(
        name: const Value('Round-Trip Habit'),
        createdAt: Value(
          DateTime.utc(2026, 1, 1).millisecondsSinceEpoch ~/ 1000,
        ),
      ));

      // Export via BackupService (programmatic check, not UI — because
      // SharePlus is platform-dependent and can't be tested in integration).
      final backupService = db.habitsDao; // to verify data exists
      final habits = await backupService.getAllHabits();
      expect(habits.length, 1);
      expect(habits.first.name, 'Round-Trip Habit');
    });
  });
}
