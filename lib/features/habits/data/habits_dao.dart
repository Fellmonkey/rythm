import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/tables.dart';

part 'habits_dao.g.dart';

@DriftAccessor(tables: [Habits])
class HabitsDao extends DatabaseAccessor<AppDatabase> with _$HabitsDaoMixin {
  HabitsDao(super.db);

  /// Watch all active (non-archived) habits ordered by creation time.
  Stream<List<Habit>> watchActiveHabits() {
    return (select(habits)
          ..where((h) => h.isArchived.equals(false))
          ..orderBy([(h) => OrderingTerm.asc(h.createdAt)]))
        .watch();
  }

  /// Get all active habits (one-shot).
  Future<List<Habit>> getActiveHabits() {
    return (select(habits)
          ..where((h) => h.isArchived.equals(false))
          ..orderBy([(h) => OrderingTerm.asc(h.createdAt)]))
        .get();
  }

  /// Get a single habit by id.
  Future<Habit> getHabit(int id) {
    return (select(habits)..where((h) => h.id.equals(id))).getSingle();
  }

  /// Watch a single habit by id.
  Stream<Habit> watchHabit(int id) {
    return (select(habits)..where((h) => h.id.equals(id))).watchSingle();
  }

  /// Insert a new habit and return its id.
  Future<int> insertHabit(HabitsCompanion entry) {
    return into(habits).insert(entry);
  }

  /// Update a habit.
  Future<bool> updateHabit(HabitsCompanion entry) {
    return update(habits).replace(entry);
  }

  /// Archive a habit (soft delete).
  Future<int> archiveHabit(int id) {
    return (update(habits)..where((h) => h.id.equals(id)))
        .write(const HabitsCompanion(isArchived: Value(true)));
  }

  /// Delete a habit permanently.
  Future<int> deleteHabit(int id) {
    return (delete(habits)..where((h) => h.id.equals(id))).go();
  }

  /// Toggle the focus flag on a habit.
  Future<void> toggleFocus(int id, {required bool isFocus}) {
    return (update(habits)..where((h) => h.id.equals(id)))
        .write(HabitsCompanion(isFocus: Value(isFocus)));
  }

  /// Count how many habits are currently marked as focus.
  Future<int> countFocusHabits() async {
    final query = selectOnly(habits)
      ..addColumns([habits.id.count()])
      ..where(habits.isFocus.equals(true) & habits.isArchived.equals(false));
    final row = await query.getSingle();
    return row.read(habits.id.count()) ?? 0;
  }
}
