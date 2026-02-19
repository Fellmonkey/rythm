import 'package:drift/drift.dart';

import '../../../../database/app_database.dart';
import '../../domain/repositories/sphere_repository.dart';

class SphereRepositoryImpl implements SphereRepository {
  final AppDatabase _db;

  SphereRepositoryImpl(this._db);

  @override
  Stream<List<Sphere>> watchAll() {
    return (_db.select(
      _db.spheres,
    )..orderBy([(s) => OrderingTerm.asc(s.sortOrder)])).watch();
  }

  @override
  Future<int> create(String name, String color) {
    final now = DateTime.now().toUtc();
    return _db
        .into(_db.spheres)
        .insert(
          SpheresCompanion.insert(
            name: name,
            color: Value(color),
            createdAt: now,
            updatedAt: now,
          ),
        );
  }

  @override
  Future<void> update(
    int id, {
    String? name,
    String? color,
    int? sortOrder,
  }) async {
    await (_db.update(_db.spheres)..where((s) => s.id.equals(id))).write(
      SpheresCompanion(
        name: name != null ? Value(name) : const Value.absent(),
        color: color != null ? Value(color) : const Value.absent(),
        sortOrder: sortOrder != null ? Value(sortOrder) : const Value.absent(),
        updatedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  @override
  Future<void> delete(int id) async {
    await (_db.delete(_db.spheres)..where((s) => s.id.equals(id))).go();
  }
}
