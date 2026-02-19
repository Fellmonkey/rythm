import '../../../../database/app_database.dart';

/// Интерфейс репозитория сфер жизни.
abstract interface class SphereRepository {
  Stream<List<Sphere>> watchAll();
  Future<int> create(String name, String color);
  Future<void> update(int id, {String? name, String? color, int? sortOrder});
  Future<void> delete(int id);
}
