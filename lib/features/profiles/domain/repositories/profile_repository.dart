import '../../../../database/app_database.dart';

/// Интерфейс репозитория профиля.
abstract interface class ProfileRepository {
  /// Текущий профиль (первый и единственный).
  Stream<Profile> watchProfile();

  /// Получить профиль синхронно.
  Future<Profile> getProfile();

  /// Обновить профиль.
  Future<void> updateProfile(ProfilesCompanion companion);
}
