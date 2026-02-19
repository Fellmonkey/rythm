import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/app_providers.dart';
import '../../../database/app_database.dart';
import '../data/repositories/tag_repository_impl.dart';
import '../domain/repositories/tag_repository.dart';

final tagRepositoryProvider = Provider<TagRepository>((ref) {
  return TagRepositoryImpl(ref.watch(databaseProvider));
});

final tagsProvider = StreamProvider<List<Tag>>((ref) {
  return ref.watch(tagRepositoryProvider).watchAll();
});

/// Провайдер тегов для конкретной привычки.
final habitTagsProvider = StreamProvider.family<List<Tag>, int>((ref, habitId) {
  return ref.watch(tagRepositoryProvider).watchTagsForHabit(habitId);
});
