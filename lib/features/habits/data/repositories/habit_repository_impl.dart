import 'package:drift/drift.dart';

import '../../../../database/app_database.dart';
import '../../domain/repositories/habit_repository.dart';

class HabitRepositoryImpl implements HabitRepository {
  final AppDatabase _db;

  HabitRepositoryImpl(this._db);

  @override
  Stream<List<Habit>> watchActive() {
    return (_db.select(_db.habits)
          ..where((h) => h.archived.equals(false))
          ..orderBy([
            (h) => OrderingTerm.desc(h.priority),
            (h) => OrderingTerm.asc(h.createdAt),
          ]))
        .watch();
  }

  @override
  Stream<List<Habit>> watchBySphere(int sphereId) {
    return (_db.select(_db.habits)
          ..where((h) => h.archived.equals(false) & h.sphereId.equals(sphereId))
          ..orderBy([(h) => OrderingTerm.desc(h.priority)]))
        .watch();
  }

  @override
  Future<Habit> getById(int id) {
    return (_db.select(_db.habits)..where((h) => h.id.equals(id))).getSingle();
  }

  @override
  Future<int> create(HabitsCompanion companion) {
    final now = DateTime.now().toUtc();
    return _db
        .into(_db.habits)
        .insert(
          companion.copyWith(createdAt: Value(now), updatedAt: Value(now)),
        );
  }

  @override
  Future<void> update(int id, HabitsCompanion companion) async {
    await (_db.update(_db.habits)..where((h) => h.id.equals(id))).write(
      companion.copyWith(updatedAt: Value(DateTime.now().toUtc())),
    );
  }

  @override
  Future<void> archive(int id) async {
    await (_db.update(_db.habits)..where((h) => h.id.equals(id))).write(
      HabitsCompanion(
        archived: const Value(true),
        updatedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  @override
  Future<void> delete(int id) async {
    // Удалить связанные логи
    await (_db.delete(_db.habitLogs)..where((l) => l.habitId.equals(id))).go();
    await (_db.delete(_db.habitTags)..where((t) => t.habitId.equals(id))).go();
    await (_db.delete(_db.habits)..where((h) => h.id.equals(id))).go();
  }
}
