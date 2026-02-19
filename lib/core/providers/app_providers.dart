import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../database/app_database.dart';

/// Провайдер базы данных — единый источник данных.
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

/// Провайдер проверки целостности БД при запуске.
final dbIntegrityProvider = FutureProvider<bool>((ref) {
  final db = ref.watch(databaseProvider);
  return db.checkIntegrity();
});
