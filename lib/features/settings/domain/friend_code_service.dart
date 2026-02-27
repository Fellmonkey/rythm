import 'dart:convert';

import '../../garden/data/garden_objects_dao.dart';
import '../../habits/data/habits_dao.dart';

/// Service for encoding/decoding Friend Codes ("Seed Codes").
///
/// Format: garden objects + habit names serialized to JSON, then base64-encoded.
/// Recipient can view the sender's garden in read-only mode.
class FriendCodeService {
  FriendCodeService({
    required this.habitsDao,
    required this.gardenObjectsDao,
  });

  final HabitsDao habitsDao;
  final GardenObjectsDao gardenObjectsDao;

  static const _codePrefix = 'RYTHM:';

  /// Generate a Friend Code string containing all garden data.
  Future<String> generateCode() async {
    final habits = await habitsDao.getAllHabits();
    final objects = await gardenObjectsDao.getAllObjects();

    final habitMap = <int, Map<String, dynamic>>{};
    for (final h in habits) {
      habitMap[h.id] = {
        'name': h.name,
        'archetype': h.seedArchetype,
      };
    }

    final gardenData = objects.map((o) {
      final habit = habitMap[o.habitId];
      return {
        'habitName': habit?['name'] ?? 'Unknown',
        'archetype': habit?['archetype'] ?? 'oak',
        'year': o.year,
        'month': o.month,
        'pct': o.completionPct,
        'abs': o.absoluteCompletions,
        'streak': o.maxStreak,
        'mR': o.morningRatio,
        'aR': o.afternoonRatio,
        'eR': o.eveningRatio,
        'type': o.objectType,
        'seed': o.generationSeed,
        'sp': o.isShortPerfect,
      };
    }).toList();

    final payload = {
      'v': 1,
      'data': gardenData,
    };

    final jsonStr = jsonEncode(payload);
    final bytes = utf8.encode(jsonStr);
    return '$_codePrefix${base64Encode(bytes)}';
  }

  /// Decode a Friend Code into a list of guest garden entries.
  /// Returns null if the code is invalid.
  static GuestGarden? decodeCode(String code) {
    try {
      final stripped = code.trim();
      final payload = stripped.startsWith(_codePrefix)
          ? stripped.substring(_codePrefix.length)
          : stripped;

      final bytes = base64Decode(payload);
      final jsonStr = utf8.decode(bytes);
      final data = jsonDecode(jsonStr) as Map<String, dynamic>;

      final version = data['v'] as int? ?? 1;
      if (version > 1) return null;

      final entries = (data['data'] as List<dynamic>).map((e) {
        final m = e as Map<String, dynamic>;
        return GuestGardenEntry(
          habitName: m['habitName'] as String? ?? 'Unknown',
          archetype: m['archetype'] as String? ?? 'oak',
          year: m['year'] as int,
          month: m['month'] as int,
          completionPct: (m['pct'] as num).toDouble(),
          absoluteCompletions: m['abs'] as int? ?? 0,
          maxStreak: m['streak'] as int? ?? 0,
          morningRatio: (m['mR'] as num?)?.toDouble() ?? 0.0,
          afternoonRatio: (m['aR'] as num?)?.toDouble() ?? 0.0,
          eveningRatio: (m['eR'] as num?)?.toDouble() ?? 0.0,
          objectType: m['type'] as String? ?? 'moss',
          generationSeed: m['seed'] as int? ?? 0,
          isShortPerfect: m['sp'] as bool? ?? false,
        );
      }).toList();

      return GuestGarden(entries: entries);
    } catch (_) {
      return null;
    }
  }

  /// Check if a garden code qualifies for cross-pollination
  /// (average completion >= 80%).
  static bool qualifiesForCrossPollination(GuestGarden garden) {
    if (garden.entries.isEmpty) return false;
    final avgPct = garden.entries
            .map((e) => e.completionPct)
            .reduce((a, b) => a + b) /
        garden.entries.length;
    return avgPct >= 0.8;
  }
}

/// A decoded friend's garden (read-only view).
class GuestGarden {
  const GuestGarden({required this.entries});
  final List<GuestGardenEntry> entries;

  Map<(int, int), List<GuestGardenEntry>> get byMonth {
    final grouped = <(int, int), List<GuestGardenEntry>>{};
    for (final e in entries) {
      grouped.putIfAbsent((e.year, e.month), () => []).add(e);
    }
    return grouped;
  }
}

/// A single entry in a guest garden.
class GuestGardenEntry {
  const GuestGardenEntry({
    required this.habitName,
    required this.archetype,
    required this.year,
    required this.month,
    required this.completionPct,
    required this.absoluteCompletions,
    required this.maxStreak,
    required this.morningRatio,
    required this.afternoonRatio,
    required this.eveningRatio,
    required this.objectType,
    required this.generationSeed,
    required this.isShortPerfect,
  });

  final String habitName;
  final String archetype;
  final int year;
  final int month;
  final double completionPct;
  final int absoluteCompletions;
  final int maxStreak;
  final double morningRatio;
  final double afternoonRatio;
  final double eveningRatio;
  final String objectType;
  final int generationSeed;
  final bool isShortPerfect;
}
