import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/app_providers.dart';
import '../../../database/app_database.dart';
import '../data/repositories/sphere_repository_impl.dart';
import '../domain/repositories/sphere_repository.dart';

final sphereRepositoryProvider = Provider<SphereRepository>((ref) {
  return SphereRepositoryImpl(ref.watch(databaseProvider));
});

final spheresProvider = StreamProvider<List<Sphere>>((ref) {
  return ref.watch(sphereRepositoryProvider).watchAll();
});
