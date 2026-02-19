import 'package:drift/drift.dart';

import '../../../../database/app_database.dart';
import '../../domain/repositories/tag_repository.dart';

class TagRepositoryImpl implements TagRepository {
  final AppDatabase _db;

  TagRepositoryImpl(this._db);

  @override
  Stream<List<Tag>> watchAll() {
    return (_db.select(
      _db.tags,
    )..orderBy([(t) => OrderingTerm.asc(t.name)])).watch();
  }

  @override
  Future<int> create(String name, {String? color}) async {
    final now = DateTime.now().toUtc();
    return _db
        .into(_db.tags)
        .insert(
          TagsCompanion.insert(name: name, color: Value(color), createdAt: now),
        );
  }

  @override
  Future<void> update(int id, {String? name, String? color}) async {
    final companion = TagsCompanion(
      name: name != null ? Value(name) : const Value.absent(),
      color: color != null ? Value(color) : const Value.absent(),
    );
    await (_db.update(
      _db.tags,
    )..where((t) => t.id.equals(id))).write(companion);
  }

  @override
  Future<void> delete(int id) async {
    // Удаляем связи с привычками
    await (_db.delete(_db.habitTags)..where((ht) => ht.tagId.equals(id))).go();
    await (_db.delete(_db.tags)..where((t) => t.id.equals(id))).go();
  }

  @override
  Future<List<Tag>> getTagsForHabit(int habitId) async {
    final query = _db.select(_db.tags).join([
      innerJoin(_db.habitTags, _db.habitTags.tagId.equalsExp(_db.tags.id)),
    ])..where(_db.habitTags.habitId.equals(habitId));

    final rows = await query.get();
    return rows.map((r) => r.readTable(_db.tags)).toList();
  }

  @override
  Stream<List<Tag>> watchTagsForHabit(int habitId) {
    final query = _db.select(_db.tags).join([
      innerJoin(_db.habitTags, _db.habitTags.tagId.equalsExp(_db.tags.id)),
    ])..where(_db.habitTags.habitId.equals(habitId));

    return query.watch().map(
      (rows) => rows.map((r) => r.readTable(_db.tags)).toList(),
    );
  }

  @override
  Future<void> setHabitTags(int habitId, List<int> tagIds) async {
    await _db.transaction(() async {
      // Удалить старые связи
      await (_db.delete(
        _db.habitTags,
      )..where((ht) => ht.habitId.equals(habitId))).go();
      // Добавить новые
      final now = DateTime.now().toUtc();
      for (final tagId in tagIds) {
        await _db
            .into(_db.habitTags)
            .insert(
              HabitTagsCompanion.insert(
                habitId: habitId,
                tagId: tagId,
                createdAt: now,
              ),
            );
      }
    });
  }
}
