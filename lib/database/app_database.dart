import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Profiles,
    Spheres,
    Tags,
    Habits,
    HabitTags,
    SkipDays,
    HabitLogs,
    EnergyLogs,
    VisualRewardsConfigs,
    BackupRecords,
    SleepLogs,
    HabitTemplates,
    HabitTemplateItems,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase()
    : super(
        driftDatabase(
          name: 'solo',
          native: const DriftNativeOptions(
            databaseDirectory: getApplicationDocumentsDirectory,
          ),
          web: DriftWebOptions(
            sqlite3Wasm: Uri.parse('sqlite3.wasm'),
            driftWorker: Uri.parse('drift_worker.js'),
          ),
        ),
      );

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await _createIndexes();
      await _createDefaultProfile();
    },
  );

  Future<void> _createIndexes() async {
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_habits_sphere_id '
      'ON habits(sphere_id)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_habits_archived '
      'ON habits(archived)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_habit_logs_habit_timestamp '
      'ON habit_logs(habit_id, timestamp)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_habit_logs_timestamp '
      'ON habit_logs(timestamp)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_habit_logs_status '
      'ON habit_logs(status)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_energy_logs_timestamp '
      'ON energy_logs(timestamp)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_skip_days_date '
      'ON skip_days(date)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_backup_records_created_at '
      'ON backup_records(created_at)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_sleep_logs_bedtime '
      'ON sleep_logs(bedtime)',
    );
  }

  Future<void> _createDefaultProfile() async {
    final now = DateTime.now().toUtc();
    await into(profiles).insert(
      ProfilesCompanion.insert(name: 'Default', createdAt: now, updatedAt: now),
    );
  }

  /// PRAGMA integrity_check при запуске
  Future<bool> checkIntegrity() async {
    final result = await customSelect('PRAGMA integrity_check').get();
    if (result.isEmpty) return false;
    return result.first.data['integrity_check'] == 'ok';
  }

  /// VACUUM для оптимизации размера БД
  Future<void> vacuum() async {
    await customStatement('VACUUM');
  }
}
