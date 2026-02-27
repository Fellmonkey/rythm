import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../data/garden_objects_dao.dart';

// ── DAO provider ─────────────────────────────────────────────

final gardenObjectsDaoProvider = Provider<GardenObjectsDao>((ref) {
  return ref.watch(databaseProvider).gardenObjectsDao;
});

// ── Garden objects stream ────────────────────────────────────

/// Stream of all garden objects (for Time Path).
final allGardenObjectsProvider = StreamProvider<List<GardenObject>>((ref) {
  return ref.watch(gardenObjectsDaoProvider).watchAllObjects();
});

/// Garden objects grouped by (year, month).
final gardenByMonthProvider =
    Provider<Map<(int, int), List<GardenObject>>>((ref) {
  final objectsAsync = ref.watch(allGardenObjectsProvider);
  final objects = objectsAsync.value;
  if (objects == null) return {};

  final grouped = <(int, int), List<GardenObject>>{};
  for (final obj in objects) {
    grouped.putIfAbsent((obj.year, obj.month), () => []).add(obj);
  }
  return grouped;
});
