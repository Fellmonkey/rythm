import 'package:drift/drift.dart';

import '../../../../database/app_database.dart';
import '../../domain/repositories/habit_log_repository.dart';

class HabitLogRepositoryImpl implements HabitLogRepository {
  final AppDatabase _db;

  HabitLogRepositoryImpl(this._db);

  @override
  Stream<List<HabitLog>> watchForDateRange(DateTime start, DateTime end) {
    return (_db.select(_db.habitLogs)
          ..where((l) => l.timestamp.isBetweenValues(start, end))
          ..orderBy([(l) => OrderingTerm.desc(l.timestamp)]))
        .watch();
  }

  @override
  Future<int> log(HabitLogsCompanion companion) {
    final now = DateTime.now().toUtc();
    return _db
        .into(_db.habitLogs)
        .insert(
          companion.copyWith(createdAt: Value(now), updatedAt: Value(now)),
        );
  }

  @override
  Future<void> updateLog(int id, HabitLogsCompanion companion) async {
    await (_db.update(_db.habitLogs)..where((l) => l.id.equals(id))).write(
      companion.copyWith(updatedAt: Value(DateTime.now().toUtc())),
    );
  }

  @override
  Future<HabitLog?> getForHabitInRange(
    int habitId,
    DateTime start,
    DateTime end,
  ) {
    return (_db.select(_db.habitLogs)
          ..where(
            (l) =>
                l.habitId.equals(habitId) &
                l.timestamp.isBetweenValues(start, end),
          )
          ..limit(1))
        .getSingleOrNull();
  }

  @override
  Future<List<HabitLog>> getLogsForHabit(
    int habitId,
    DateTime start,
    DateTime end,
  ) {
    return (_db.select(_db.habitLogs)
          ..where(
            (l) =>
                l.habitId.equals(habitId) &
                l.timestamp.isBetweenValues(start, end),
          )
          ..orderBy([(l) => OrderingTerm.asc(l.timestamp)]))
        .get();
  }
}
