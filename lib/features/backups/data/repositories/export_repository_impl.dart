import 'package:drift/drift.dart';

import '../../../../database/app_database.dart';
import '../../domain/repositories/export_repository.dart';

class ExportRepositoryImpl implements ExportRepository {
  final AppDatabase _db;

  ExportRepositoryImpl(this._db);

  @override
  Future<String> exportToCsv({int? daysBack}) async {
    final habits = await _db.select(_db.habits).get();
    final logs = await _fetchLogs(daysBack);

    final habitMap = {for (final h in habits) h.id: h};

    final buf = StringBuffer();
    buf.writeln(
      'date,habit_name,status,actual_value,target_value,unit,energy_level',
    );

    for (final log in logs) {
      final habit = habitMap[log.habitId];
      if (habit == null) continue;

      final date = log.timestamp.toLocal().toIso8601String().split('T').first;
      final statusStr = switch (log.status) {
        2 => 'complete',
        1 => 'partial',
        _ => 'missed',
      };

      buf.writeln(
        [
          date,
          _escapeCsv(habit.name),
          statusStr,
          log.actualValue,
          habit.targetValue,
          habit.unit ?? '',
          log.energyLevel ?? '',
        ].join(','),
      );
    }

    return buf.toString();
  }

  @override
  Future<String> exportToMarkdown({int? daysBack}) async {
    final habits = await _db.select(_db.habits).get();
    final logs = await _fetchLogs(daysBack);

    final habitMap = {for (final h in habits) h.id: h};

    // Группируем логи по дате (локальной)
    final grouped = <String, List<(HabitLog, Habit)>>{};
    for (final log in logs) {
      final date = log.timestamp.toLocal().toIso8601String().split('T').first;
      final habit = habitMap[log.habitId];
      if (habit == null) continue;
      grouped.putIfAbsent(date, () => []).add((log, habit));
    }

    // Сортировка по дате (новые сверху)
    final sortedDates = grouped.keys.toList()..sort((a, b) => b.compareTo(a));

    final buf = StringBuffer();
    buf.writeln('# Ритм — Экспорт привычек\n');

    for (final date in sortedDates) {
      buf.writeln('## $date');
      for (final (log, habit) in grouped[date]!) {
        final checkbox = switch (log.status) {
          2 => '[x]',
          1 => '[~]',
          _ => '[ ]',
        };
        final emoji = switch (log.status) {
          2 => '✅',
          1 => '⚪',
          _ => '⬜',
        };

        if (habit.type == 'binary') {
          buf.writeln('- $checkbox ${habit.name} $emoji');
        } else {
          final unit = habit.unit ?? '';
          buf.writeln(
            '- $checkbox ${habit.name} (${log.actualValue}/${habit.targetValue} $unit) $emoji',
          );
        }
      }
      buf.writeln();
    }

    // Также add habits without logs for completeness
    if (sortedDates.isEmpty) {
      buf.writeln('_Нет записей за указанный период._\n');
    }

    return buf.toString();
  }

  Future<List<HabitLog>> _fetchLogs(int? daysBack) async {
    final query = _db.select(_db.habitLogs)
      ..orderBy([(t) => OrderingTerm.desc(t.timestamp)]);

    if (daysBack != null) {
      final cutoff = DateTime.now().toUtc().subtract(Duration(days: daysBack));
      query.where((t) => t.timestamp.isBiggerOrEqualValue(cutoff));
    }

    return query.get();
  }

  String _escapeCsv(String value) {
    if (value.contains(',') || value.contains('"') || value.contains('\n')) {
      return '"${value.replaceAll('"', '""')}"';
    }
    return value;
  }
}
