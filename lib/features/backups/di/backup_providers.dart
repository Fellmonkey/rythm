import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/app_providers.dart';
import '../../../database/app_database.dart';
import '../data/repositories/backup_repository_impl.dart';
import '../domain/repositories/backup_repository.dart';

final backupRepositoryProvider = Provider<BackupRepository>((ref) {
  return BackupRepositoryImpl(ref.watch(databaseProvider));
});

final backupRecordsProvider = StreamProvider<List<BackupRecord>>((ref) {
  return ref.watch(backupRepositoryProvider).watchAll();
});
