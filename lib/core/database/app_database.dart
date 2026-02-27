import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/garden/data/garden_objects_dao.dart';
import '../../features/habits/data/habit_logs_dao.dart';
import '../../features/habits/data/habits_dao.dart';
import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [Habits, HabitLogs, GardenObjects],
  daos: [HabitsDao, HabitLogsDao, GardenObjectsDao],
)
class AppDatabase extends _$AppDatabase {
  /// Flag to indicate if this is a test database (in-memory) or a real one.
  final bool isTest;

  AppDatabase()
      : isTest = false,
        super(
          driftDatabase(
            name: 'rhythm',
            native: const DriftNativeOptions(
              databaseDirectory: getApplicationDocumentsDirectory,
            ),
            web: DriftWebOptions(
              sqlite3Wasm: Uri.parse('sqlite3.wasm'),
              driftWorker: Uri.parse('drift_worker.js'),
            ),
          ),
        );

  /// Test constructor that creates an in-memory database.
  AppDatabase.test(super.executor) : isTest = true;

  @override
  int get schemaVersion => 1;

}
