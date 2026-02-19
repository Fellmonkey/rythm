import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/app_providers.dart';
import '../data/repositories/export_repository_impl.dart';
import '../domain/repositories/export_repository.dart';

final exportRepositoryProvider = Provider<ExportRepository>((ref) {
  return ExportRepositoryImpl(ref.watch(databaseProvider));
});
