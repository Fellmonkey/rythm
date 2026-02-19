import 'package:drift/drift.dart';

import '../../../../database/app_database.dart';
import '../../domain/repositories/energy_repository.dart';

class EnergyRepositoryImpl implements EnergyRepository {
  final AppDatabase _db;

  EnergyRepositoryImpl(this._db);

  @override
  Stream<EnergyLog?> watchForDateRange(DateTime start, DateTime end) {
    return (_db.select(_db.energyLogs)
          ..where((e) => e.timestamp.isBetweenValues(start, end))
          ..orderBy([(e) => OrderingTerm.desc(e.timestamp)])
          ..limit(1))
        .watchSingleOrNull();
  }

  @override
  Future<int> log(int energyLevel, {String? note}) {
    final now = DateTime.now().toUtc();
    return _db
        .into(_db.energyLogs)
        .insert(
          EnergyLogsCompanion.insert(
            energyLevel: energyLevel,
            note: Value(note),
            timestamp: now,
            createdAt: now,
          ),
        );
  }

  @override
  Future<void> update(int id, int energyLevel) async {
    await (_db.update(_db.energyLogs)..where((e) => e.id.equals(id))).write(
      EnergyLogsCompanion(energyLevel: Value(energyLevel)),
    );
  }
}
