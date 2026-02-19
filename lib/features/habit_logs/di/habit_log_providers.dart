import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/app_providers.dart';
import '../../../core/utils/date_helper.dart';
import '../../../database/app_database.dart';
import '../../profiles/di/profile_providers.dart';
import '../data/repositories/habit_log_repository_impl.dart';
import '../domain/repositories/habit_log_repository.dart';

final habitLogRepositoryProvider = Provider<HabitLogRepository>((ref) {
  return HabitLogRepositoryImpl(ref.watch(databaseProvider));
});

/// Логи привычек за «сегодня» с учётом dayStartHour.
final todayLogsProvider = StreamProvider<List<HabitLog>>((ref) {
  final profileAsync = ref.watch(profileProvider);
  final repo = ref.watch(habitLogRepositoryProvider);

  return profileAsync.when(
    data: (profile) {
      final (start, end) = DateHelper.todayRange(
        dayStartHour: profile.dayStartHour,
      );
      return repo.watchForDateRange(start, end);
    },
    loading: () => const Stream.empty(),
    error: (_, _) => const Stream.empty(),
  );
});
