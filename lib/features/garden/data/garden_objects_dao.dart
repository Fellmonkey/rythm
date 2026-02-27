import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/tables.dart';

part 'garden_objects_dao.g.dart';

@DriftAccessor(tables: [GardenObjects])
class GardenObjectsDao extends DatabaseAccessor<AppDatabase>
    with _$GardenObjectsDaoMixin {
  GardenObjectsDao(super.db);

  /// Get all garden objects ordered by year desc, month desc.
  Future<List<GardenObject>> getAllObjects() {
    return (select(gardenObjects)
          ..orderBy([
            (o) => OrderingTerm.desc(o.year),
            (o) => OrderingTerm.desc(o.month),
          ]))
        .get();
  }

  /// Watch all garden objects.
  Stream<List<GardenObject>> watchAllObjects() {
    return (select(gardenObjects)
          ..orderBy([
            (o) => OrderingTerm.desc(o.year),
            (o) => OrderingTerm.desc(o.month),
          ]))
        .watch();
  }

  /// Get objects for a specific month.
  Future<List<GardenObject>> getObjectsForMonth(int year, int month) {
    return (select(gardenObjects)
          ..where(
              (o) => o.year.equals(year) & o.month.equals(month)))
        .get();
  }

  /// Get object for a specific habit and month.
  Future<GardenObject?> getObjectForHabitMonth(
    int habitId,
    int year,
    int month,
  ) {
    return (select(gardenObjects)
          ..where(
            (o) =>
                o.habitId.equals(habitId) &
                o.year.equals(year) &
                o.month.equals(month),
          ))
        .getSingleOrNull();
  }

  /// Insert a garden object.
  Future<int> insertObject(GardenObjectsCompanion entry) {
    return into(gardenObjects).insert(entry);
  }

  /// Update the PNG path after crystallization.
  Future<int> updatePngPath(int id, String path) {
    return (update(gardenObjects)..where((o) => o.id.equals(id)))
        .write(GardenObjectsCompanion(pngPath: Value(path)));
  }

  /// Delete all objects for a habit (when habit is permanently deleted).
  Future<int> deleteObjectsForHabit(int habitId) {
    return (delete(gardenObjects)..where((o) => o.habitId.equals(habitId)))
        .go();
  }
}
