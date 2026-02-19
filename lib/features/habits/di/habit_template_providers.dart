import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/app_providers.dart';
import '../../../database/app_database.dart';
import '../data/repositories/habit_template_repository_impl.dart';

/// Провайдер репозитория шаблонов.
final habitTemplateRepositoryProvider = Provider<HabitTemplateRepositoryImpl>((
  ref,
) {
  return HabitTemplateRepositoryImpl(ref.watch(databaseProvider));
});

/// Все шаблоны (обновляется при инвалидации).
final templatesProvider = FutureProvider<List<HabitTemplate>>((ref) {
  return ref.watch(habitTemplateRepositoryProvider).getAll();
});

/// Элементы конкретного шаблона.
final templateItemsProvider =
    FutureProvider.family<List<HabitTemplateItem>, int>((ref, templateId) {
      return ref.watch(habitTemplateRepositoryProvider).getItems(templateId);
    });
