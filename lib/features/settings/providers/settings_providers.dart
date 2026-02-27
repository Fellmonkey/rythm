import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../garden/providers/garden_providers.dart';
import '../../habits/providers/habit_providers.dart';
import '../domain/backup_service.dart';
import '../domain/friend_code_service.dart';

// ── Backup service ─────────────────────────────────────────────

final backupServiceProvider = Provider<BackupService>((ref) {
  return BackupService(
    habitsDao: ref.watch(habitsDaoProvider),
    habitLogsDao: ref.watch(habitLogsDaoProvider),
    gardenObjectsDao: ref.watch(gardenObjectsDaoProvider),
  );
});

// ── Friend code service ────────────────────────────────────────

final friendCodeServiceProvider = Provider<FriendCodeService>((ref) {
  return FriendCodeService(
    habitsDao: ref.watch(habitsDaoProvider),
    gardenObjectsDao: ref.watch(gardenObjectsDaoProvider),
  );
});

// ── Cross-pollination unlocked archetypes ──────────────────────

final unlockedArchetypesProvider = Provider<List<String>>((ref) {
  final prefs = ref.watch(sharedPrefsProvider).value;
  if (prefs == null) return [];
  final raw = prefs.getStringList('unlocked_archetypes') ?? [];
  return raw;
});
