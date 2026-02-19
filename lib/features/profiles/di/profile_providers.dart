import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/app_providers.dart';
import '../../../database/app_database.dart';
import '../data/repositories/profile_repository_impl.dart';
import '../domain/repositories/profile_repository.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepositoryImpl(ref.watch(databaseProvider));
});

final profileProvider = StreamProvider<Profile>((ref) {
  return ref.watch(profileRepositoryProvider).watchProfile();
});
