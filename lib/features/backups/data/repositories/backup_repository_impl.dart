import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../../database/app_database.dart';
import '../../domain/repositories/backup_repository.dart';

class BackupRepositoryImpl implements BackupRepository {
  final AppDatabase _db;

  BackupRepositoryImpl(this._db);

  @override
  Future<String> exportToJson() async {
    // VACUUM перед экспортом (оптимизация размера)
    await _db.vacuum();

    final profiles = await _db.select(_db.profiles).get();
    final spheres = await _db.select(_db.spheres).get();
    final tags = await _db.select(_db.tags).get();
    final habits = await _db.select(_db.habits).get();
    final habitTags = await _db.select(_db.habitTags).get();
    final habitLogs = await _db.select(_db.habitLogs).get();
    final energyLogs = await _db.select(_db.energyLogs).get();
    final skipDays = await _db.select(_db.skipDays).get();

    final data = {
      'version': 1,
      'exportedAt': DateTime.now().toUtc().toIso8601String(),
      'profiles': profiles.map(_profileToMap).toList(),
      'spheres': spheres.map(_sphereToMap).toList(),
      'tags': tags.map(_tagToMap).toList(),
      'habits': habits.map(_habitToMap).toList(),
      'habitTags': habitTags.map(_habitTagToMap).toList(),
      'habitLogs': habitLogs.map(_habitLogToMap).toList(),
      'energyLogs': energyLogs.map(_energyLogToMap).toList(),
      'skipDays': skipDays.map(_skipDayToMap).toList(),
    };

    return const JsonEncoder.withIndent('  ').convert(data);
  }

  @override
  Future<void> importFromJson(String jsonString) async {
    final data = jsonDecode(jsonString) as Map<String, dynamic>;
    final _ = data['version'] as int? ?? 1;

    await _db.transaction(() async {
      // Очистить все таблицы
      await _db.delete(_db.habitLogs).go();
      await _db.delete(_db.habitTags).go();
      await _db.delete(_db.energyLogs).go();
      await _db.delete(_db.skipDays).go();
      await _db.delete(_db.habits).go();
      await _db.delete(_db.tags).go();
      await _db.delete(_db.spheres).go();
      await _db.delete(_db.profiles).go();

      // Импортировать данные
      for (final p in (data['profiles'] as List? ?? [])) {
        await _db
            .into(_db.profiles)
            .insert(
              ProfilesCompanion.insert(
                name: p['name'] as String,
                dayStartHour: Value(p['dayStartHour'] as int? ?? 0),
                timezoneMode: Value(p['timezoneMode'] as String? ?? 'auto'),
                fixedTimezone: Value(p['fixedTimezone'] as String?),
                backupEnabled: Value(p['backupEnabled'] as bool? ?? true),
                backupFrequencyDays: Value(
                  p['backupFrequencyDays'] as int? ?? 1,
                ),
                maxBackupCount: Value(p['maxBackupCount'] as int? ?? 5),
                createdAt: DateTime.parse(p['createdAt'] as String),
                updatedAt: DateTime.parse(p['updatedAt'] as String),
              ),
            );
      }

      for (final s in (data['spheres'] as List? ?? [])) {
        await _db
            .into(_db.spheres)
            .insert(
              SpheresCompanion.insert(
                name: s['name'] as String,
                color: Value(s['color'] as String? ?? '#9B7EBD'),
                sortOrder: Value(s['sortOrder'] as int? ?? 0),
                createdAt: DateTime.parse(s['createdAt'] as String),
                updatedAt: DateTime.parse(s['updatedAt'] as String),
              ),
            );
      }

      for (final t in (data['tags'] as List? ?? [])) {
        await _db
            .into(_db.tags)
            .insert(
              TagsCompanion.insert(
                name: t['name'] as String,
                color: Value(t['color'] as String?),
                createdAt: DateTime.parse(t['createdAt'] as String),
              ),
            );
      }

      for (final h in (data['habits'] as List? ?? [])) {
        await _db
            .into(_db.habits)
            .insert(
              HabitsCompanion.insert(
                name: h['name'] as String,
                description: Value(h['description'] as String?),
                sphereId: Value(h['sphereId'] as int?),
                type: Value(h['type'] as String? ?? 'binary'),
                targetValue: Value(h['targetValue'] as int? ?? 1),
                minValue: Value(h['minValue'] as int? ?? 1),
                unit: Value(h['unit'] as String?),
                priority: Value(h['priority'] as int? ?? 0),
                energyRequired: Value(h['energyRequired'] as int? ?? 2),
                goalPerWeek: Value(h['goalPerWeek'] as int? ?? 7),
                archived: Value(h['archived'] as bool? ?? false),
                createdAt: DateTime.parse(h['createdAt'] as String),
                updatedAt: DateTime.parse(h['updatedAt'] as String),
              ),
            );
      }

      for (final ht in (data['habitTags'] as List? ?? [])) {
        await _db
            .into(_db.habitTags)
            .insert(
              HabitTagsCompanion.insert(
                habitId: ht['habitId'] as int,
                tagId: ht['tagId'] as int,
                createdAt: DateTime.parse(ht['createdAt'] as String),
              ),
            );
      }

      for (final l in (data['habitLogs'] as List? ?? [])) {
        await _db
            .into(_db.habitLogs)
            .insert(
              HabitLogsCompanion.insert(
                habitId: l['habitId'] as int,
                status: l['status'] as int,
                actualValue: Value(l['actualValue'] as int? ?? 0),
                skipReasonId: Value(l['skipReasonId'] as int?),
                energyLevel: Value(l['energyLevel'] as int?),
                durationSeconds: Value(l['durationSeconds'] as int?),
                timestamp: DateTime.parse(l['timestamp'] as String),
                createdAt: DateTime.parse(l['createdAt'] as String),
                updatedAt: DateTime.parse(l['updatedAt'] as String),
              ),
            );
      }

      for (final e in (data['energyLogs'] as List? ?? [])) {
        await _db
            .into(_db.energyLogs)
            .insert(
              EnergyLogsCompanion.insert(
                energyLevel: e['energyLevel'] as int,
                note: Value(e['note'] as String?),
                timestamp: DateTime.parse(e['timestamp'] as String),
                createdAt: DateTime.parse(e['createdAt'] as String),
              ),
            );
      }

      for (final sd in (data['skipDays'] as List? ?? [])) {
        await _db
            .into(_db.skipDays)
            .insert(
              SkipDaysCompanion.insert(
                reason: sd['reason'] as String,
                note: Value(sd['note'] as String?),
                date: DateTime.parse(sd['date'] as String),
                createdAt: DateTime.parse(sd['createdAt'] as String),
              ),
            );
      }
    });

    // Обновить last_backup_at
    final profile = await (_db.select(_db.profiles)..limit(1)).getSingle();
    await (_db.update(_db.profiles)..where((p) => p.id.equals(profile.id)))
        .write(ProfilesCompanion(lastBackupAt: Value(DateTime.now().toUtc())));
  }

  @override
  Stream<List<BackupRecord>> watchAll() {
    return (_db.select(
      _db.backupRecords,
    )..orderBy([(b) => OrderingTerm.desc(b.createdAt)])).watch();
  }

  // Маппинг в Map для JSON
  Map<String, dynamic> _profileToMap(Profile p) => {
    'name': p.name,
    'dayStartHour': p.dayStartHour,
    'timezoneMode': p.timezoneMode,
    'fixedTimezone': p.fixedTimezone,
    'backupEnabled': p.backupEnabled,
    'backupFrequencyDays': p.backupFrequencyDays,
    'maxBackupCount': p.maxBackupCount,
    'createdAt': p.createdAt.toIso8601String(),
    'updatedAt': p.updatedAt.toIso8601String(),
  };

  Map<String, dynamic> _sphereToMap(Sphere s) => {
    'name': s.name,
    'color': s.color,
    'sortOrder': s.sortOrder,
    'createdAt': s.createdAt.toIso8601String(),
    'updatedAt': s.updatedAt.toIso8601String(),
  };

  Map<String, dynamic> _tagToMap(Tag t) => {
    'name': t.name,
    'color': t.color,
    'createdAt': t.createdAt.toIso8601String(),
  };

  Map<String, dynamic> _habitToMap(Habit h) => {
    'name': h.name,
    'description': h.description,
    'sphereId': h.sphereId,
    'type': h.type,
    'targetValue': h.targetValue,
    'minValue': h.minValue,
    'unit': h.unit,
    'priority': h.priority,
    'energyRequired': h.energyRequired,
    'goalPerWeek': h.goalPerWeek,
    'archived': h.archived,
    'createdAt': h.createdAt.toIso8601String(),
    'updatedAt': h.updatedAt.toIso8601String(),
  };

  Map<String, dynamic> _habitTagToMap(HabitTag ht) => {
    'habitId': ht.habitId,
    'tagId': ht.tagId,
    'createdAt': ht.createdAt.toIso8601String(),
  };

  Map<String, dynamic> _habitLogToMap(HabitLog l) => {
    'habitId': l.habitId,
    'status': l.status,
    'actualValue': l.actualValue,
    'skipReasonId': l.skipReasonId,
    'energyLevel': l.energyLevel,
    'durationSeconds': l.durationSeconds,
    'timestamp': l.timestamp.toIso8601String(),
    'createdAt': l.createdAt.toIso8601String(),
    'updatedAt': l.updatedAt.toIso8601String(),
  };

  Map<String, dynamic> _energyLogToMap(EnergyLog e) => {
    'energyLevel': e.energyLevel,
    'note': e.note,
    'timestamp': e.timestamp.toIso8601String(),
    'createdAt': e.createdAt.toIso8601String(),
  };

  Map<String, dynamic> _skipDayToMap(SkipDay sd) => {
    'reason': sd.reason,
    'note': sd.note,
    'date': sd.date.toIso8601String(),
    'createdAt': sd.createdAt.toIso8601String(),
  };
}
