import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/app_providers.dart';
import '../../../core/utils/date_helper.dart';
import '../../../database/app_database.dart';
import '../../profiles/di/profile_providers.dart';
import '../data/repositories/energy_repository_impl.dart';
import '../domain/repositories/energy_repository.dart';

final energyRepositoryProvider = Provider<EnergyRepository>((ref) {
  return EnergyRepositoryImpl(ref.watch(databaseProvider));
});

/// Уровень энергии «сегодня».
final todayEnergyProvider = StreamProvider<EnergyLog?>((ref) {
  final profileAsync = ref.watch(profileProvider);
  final repo = ref.watch(energyRepositoryProvider);

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
