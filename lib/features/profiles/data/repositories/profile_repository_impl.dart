import 'package:drift/drift.dart';

import '../../../../database/app_database.dart';
import '../../domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final AppDatabase _db;

  ProfileRepositoryImpl(this._db);

  @override
  Stream<Profile> watchProfile() {
    return (_db.select(_db.profiles)..limit(1)).watchSingle();
  }

  @override
  Future<Profile> getProfile() {
    return (_db.select(_db.profiles)..limit(1)).getSingle();
  }

  @override
  Future<void> updateProfile(ProfilesCompanion companion) async {
    final profile = await getProfile();
    await (_db.update(_db.profiles)..where((p) => p.id.equals(profile.id)))
        .write(companion.copyWith(updatedAt: Value(DateTime.now().toUtc())));
  }
}
