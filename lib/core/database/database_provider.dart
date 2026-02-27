import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_database.dart';

/// Single instance of the app database, shared across the app.
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});
