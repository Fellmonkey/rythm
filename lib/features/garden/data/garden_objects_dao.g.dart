// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'garden_objects_dao.dart';

// ignore_for_file: type=lint
mixin _$GardenObjectsDaoMixin on DatabaseAccessor<AppDatabase> {
  $HabitsTable get habits => attachedDatabase.habits;
  $GardenObjectsTable get gardenObjects => attachedDatabase.gardenObjects;
  GardenObjectsDaoManager get managers => GardenObjectsDaoManager(this);
}

class GardenObjectsDaoManager {
  final _$GardenObjectsDaoMixin _db;
  GardenObjectsDaoManager(this._db);
  $$HabitsTableTableManager get habits =>
      $$HabitsTableTableManager(_db.attachedDatabase, _db.habits);
  $$GardenObjectsTableTableManager get gardenObjects =>
      $$GardenObjectsTableTableManager(_db.attachedDatabase, _db.gardenObjects);
}
