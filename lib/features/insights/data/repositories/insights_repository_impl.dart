import 'package:drift/drift.dart';

import '../../../../core/utils/date_helper.dart';
import '../../../../database/app_database.dart';
import '../../domain/repositories/insights_repository.dart';

class InsightsRepositoryImpl implements InsightsRepository {
  final AppDatabase _db;

  InsightsRepositoryImpl(this._db);

  @override
  Future<FlexibleStreak> calculateStreak(
    int habitId,
    int goalPerWeek, {
    int dayStartHour = 0,
  }) async {
    // Получаем все логи привычки, сортированные по времени
    final logs =
        await (_db.select(_db.habitLogs)
              ..where((l) => l.habitId.equals(habitId))
              ..orderBy([(l) => OrderingTerm.desc(l.timestamp)]))
            .get();

    if (logs.isEmpty) {
      return FlexibleStreak(
        weekStreak: 0,
        currentWeekDone: 0,
        goalPerWeek: goalPerWeek,
      );
    }

    // Текущая неделя
    final weekStart = DateHelper.weekStart(dayStartHour: dayStartHour);
    final weekEnd = DateHelper.weekEnd(dayStartHour: dayStartHour);

    // Считаем выполнения текущей недели
    int currentWeekDone = 0;
    for (final log in logs) {
      if (log.timestamp.isAfter(weekStart) &&
          log.timestamp.isBefore(weekEnd) &&
          log.status > 0) {
        currentWeekDone++;
      }
    }

    // Считаем стрик недель назад
    int weekStreak = currentWeekDone >= goalPerWeek ? 1 : 0;
    var checkWeekStart = weekStart.subtract(const Duration(days: 7));

    for (int w = 0; w < 52; w++) {
      final checkWeekEnd = checkWeekStart.add(const Duration(days: 7));
      int weekDone = 0;
      for (final log in logs) {
        if (log.timestamp.isAfter(checkWeekStart) &&
            log.timestamp.isBefore(checkWeekEnd) &&
            log.status > 0) {
          weekDone++;
        }
      }

      if (weekDone >= goalPerWeek) {
        weekStreak++;
        checkWeekStart = checkWeekStart.subtract(const Duration(days: 7));
      } else {
        break;
      }
    }

    return FlexibleStreak(
      weekStreak: weekStreak,
      currentWeekDone: currentWeekDone,
      goalPerWeek: goalPerWeek,
    );
  }

  @override
  Future<PeriodStats> getHabitStats(
    int habitId, {
    int days = 30,
    int dayStartHour = 0,
  }) async {
    final cutoff = DateTime.now().toUtc().subtract(Duration(days: days));

    final logs =
        await (_db.select(_db.habitLogs)
              ..where(
                (l) =>
                    l.habitId.equals(habitId) &
                    l.timestamp.isBiggerOrEqualValue(cutoff),
              )
              ..orderBy([(l) => OrderingTerm.asc(l.timestamp)]))
            .get();

    final energyLogs = await (_db.select(
      _db.energyLogs,
    )..where((e) => e.timestamp.isBiggerOrEqualValue(cutoff))).get();

    int completed = 0;
    int partial = 0;
    int skipped = 0;
    int missed = 0;
    final dayOfWeek = <int, int>{};

    for (final log in logs) {
      final weekday = log.timestamp.toLocal().weekday;
      if (log.skipReasonId != null) {
        skipped++;
      } else if (log.status == 2) {
        completed++;
        dayOfWeek[weekday] = (dayOfWeek[weekday] ?? 0) + 1;
      } else if (log.status == 1) {
        partial++;
        dayOfWeek[weekday] = (dayOfWeek[weekday] ?? 0) + 1;
      } else {
        missed++;
      }
    }

    double avgEnergy = 0;
    if (energyLogs.isNotEmpty) {
      avgEnergy =
          energyLogs.map((e) => e.energyLevel).reduce((a, b) => a + b) /
          energyLogs.length;
    }

    return PeriodStats(
      totalDays: days,
      completedDays: completed,
      partialDays: partial,
      skippedDays: skipped,
      missedDays: missed,
      averageEnergy: avgEnergy,
      dayOfWeekDistribution: dayOfWeek,
    );
  }

  @override
  Future<Map<int, double>> energyByWeekday({int days = 30}) async {
    final cutoff = DateTime.now().toUtc().subtract(Duration(days: days));
    final logs = await (_db.select(
      _db.energyLogs,
    )..where((e) => e.timestamp.isBiggerOrEqualValue(cutoff))).get();

    final sums = <int, int>{};
    final counts = <int, int>{};

    for (final log in logs) {
      final weekday = log.timestamp.toLocal().weekday;
      sums[weekday] = (sums[weekday] ?? 0) + log.energyLevel;
      counts[weekday] = (counts[weekday] ?? 0) + 1;
    }

    return {for (final wd in sums.keys) wd: sums[wd]! / counts[wd]!};
  }

  @override
  Future<Map<DateTime, int>> heatmapData({
    int days = 90,
    int dayStartHour = 0,
  }) async {
    final cutoff = DateTime.now().toUtc().subtract(Duration(days: days));

    final logs =
        await (_db.select(_db.habitLogs)..where(
              (l) =>
                  l.timestamp.isBiggerOrEqualValue(cutoff) &
                  l.status.isBiggerThanValue(0),
            ))
            .get();

    final map = <DateTime, int>{};
    for (final log in logs) {
      final local = log.timestamp.toLocal();
      final dateKey = DateTime(local.year, local.month, local.day);
      map[dateKey] = (map[dateKey] ?? 0) + 1;
    }

    return map;
  }
}
