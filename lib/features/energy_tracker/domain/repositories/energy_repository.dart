import '../../../../database/app_database.dart';

/// Интерфейс репозитория энергии.
abstract interface class EnergyRepository {
  /// Наблюдать уровень энергии за период.
  Stream<EnergyLog?> watchForDateRange(DateTime start, DateTime end);

  /// Записать уровень энергии.
  Future<int> log(int energyLevel, {String? note});

  /// Обновить уровень энергии.
  Future<void> update(int id, int energyLevel);
}
