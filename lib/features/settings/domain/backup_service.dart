import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../garden/data/garden_objects_dao.dart';
import '../../habits/data/habit_logs_dao.dart';
import '../../habits/data/habits_dao.dart';

// Backup format version for forward compatibility.
const _backupVersion = 1;

class BackupService {
  BackupService({
    required this.habitsDao,
    required this.habitLogsDao,
    required this.gardenObjectsDao,
  });

  final HabitsDao habitsDao;
  final HabitLogsDao habitLogsDao;
  final GardenObjectsDao gardenObjectsDao;

  /// Export the entire database to a JSON string.
  Future<String> exportToJson() async {
    final habits = await habitsDao.getAllHabits();
    final logs = await habitLogsDao.getAllLogs();
    final objects = await gardenObjectsDao.getAllObjects();

    final data = {
      'version': _backupVersion,
      'exportedAt': DateTime.now().toIso8601String(),
      'habits': habits.map(_habitToMap).toList(),
      'habitLogs': logs.map(_logToMap).toList(),
      'gardenObjects': objects.map(_gardenObjectToMap).toList(),
    };

    return jsonEncode(data);
  }

  /// Import a full backup from JSON, replacing all existing data.
  /// Returns the number of habits imported.
  Future<int> importFromJson(String jsonString) async {
    final data = jsonDecode(jsonString) as Map<String, dynamic>;
    final version = data['version'] as int? ?? 1;
    if (version > _backupVersion) {
      throw FormatException(
        'Unsupported backup version: $version (max supported: $_backupVersion)',
      );
    }

    final habitsList = data['habits'] as List<dynamic>? ?? [];
    final logsList = data['habitLogs'] as List<dynamic>? ?? [];
    final objectsList = data['gardenObjects'] as List<dynamic>? ?? [];

    // Clear existing data (order matters for FK constraints).
    await gardenObjectsDao.deleteAllObjects();
    await habitLogsDao.deleteAllLogs();
    await habitsDao.deleteAllHabits();

    // Import habits.
    for (final h in habitsList) {
      final map = h as Map<String, dynamic>;
      await habitsDao.insertHabit(HabitsCompanion(
        name: Value(map['name'] as String),
        category: Value(map['category'] as String? ?? 'general'),
        seedArchetype: Value(map['seedArchetype'] as String? ?? 'oak'),
        frequencyType: Value(map['frequencyType'] as String? ?? 'daily'),
        frequencyValue: Value(map['frequencyValue'] as String? ?? '{}'),
        timeOfDay: Value(map['timeOfDay'] as String? ?? 'anytime'),
        isFocus: Value(map['isFocus'] as bool? ?? false),
        isArchived: Value(map['isArchived'] as bool? ?? false),
        createdAt: Value(map['createdAt'] as int),
      ));
    }

    // Import logs.
    for (final l in logsList) {
      final map = l as Map<String, dynamic>;
      await habitLogsDao.upsertLog(HabitLogsCompanion(
        habitId: Value(map['habitId'] as int),
        date: Value(map['date'] as int),
        status: Value(map['status'] as String? ?? 'pending'),
        loggedHour: Value(map['loggedHour'] as int?),
      ));
    }

    // Import garden objects.
    for (final o in objectsList) {
      final map = o as Map<String, dynamic>;
      await gardenObjectsDao.insertObject(GardenObjectsCompanion(
        habitId: Value(map['habitId'] as int),
        year: Value(map['year'] as int),
        month: Value(map['month'] as int),
        completionPct: Value((map['completionPct'] as num).toDouble()),
        absoluteCompletions: Value(map['absoluteCompletions'] as int? ?? 0),
        maxStreak: Value(map['maxStreak'] as int? ?? 0),
        morningRatio: Value((map['morningRatio'] as num?)?.toDouble() ?? 0.0),
        afternoonRatio:
            Value((map['afternoonRatio'] as num?)?.toDouble() ?? 0.0),
        eveningRatio: Value((map['eveningRatio'] as num?)?.toDouble() ?? 0.0),
        objectType: Value(map['objectType'] as String? ?? 'moss'),
        generationSeed: Value(map['generationSeed'] as int),
        pngPath: Value(map['pngPath'] as String?),
        isShortPerfect: Value(map['isShortPerfect'] as bool? ?? false),
      ));
    }

    return habitsList.length;
  }

  // ── Serialization helpers ────────────────────────────────────

  static Map<String, dynamic> _habitToMap(Habit h) => {
        'id': h.id,
        'name': h.name,
        'category': h.category,
        'seedArchetype': h.seedArchetype,
        'frequencyType': h.frequencyType,
        'frequencyValue': h.frequencyValue,
        'timeOfDay': h.timeOfDay,
        'isFocus': h.isFocus,
        'isArchived': h.isArchived,
        'createdAt': h.createdAt,
      };

  static Map<String, dynamic> _logToMap(HabitLog l) => {
        'id': l.id,
        'habitId': l.habitId,
        'date': l.date,
        'status': l.status,
        'loggedHour': l.loggedHour,
      };

  static Map<String, dynamic> _gardenObjectToMap(GardenObject o) => {
        'id': o.id,
        'habitId': o.habitId,
        'year': o.year,
        'month': o.month,
        'completionPct': o.completionPct,
        'absoluteCompletions': o.absoluteCompletions,
        'maxStreak': o.maxStreak,
        'morningRatio': o.morningRatio,
        'afternoonRatio': o.afternoonRatio,
        'eveningRatio': o.eveningRatio,
        'objectType': o.objectType,
        'generationSeed': o.generationSeed,
        'pngPath': o.pngPath,
        'isShortPerfect': o.isShortPerfect,
      };
}
