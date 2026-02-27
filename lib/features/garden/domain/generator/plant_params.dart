import 'dart:ui';

import '../../../../core/database/enums.dart';

/// Input parameters for procedural plant generation.
/// Derived from HabitMetrics after month-end crystallization.
class GenerationParams {
  const GenerationParams({
    required this.archetype,
    required this.completionPct,
    required this.absoluteCompletions,
    required this.maxStreak,
    required this.morningRatio,
    required this.afternoonRatio,
    required this.eveningRatio,
    required this.seed,
    required this.isShortPerfect,
    this.objectType = GardenObjectType.moss,
  });

  /// Visual archetype of the plant (Oak, Sakura, etc.).
  final SeedArchetype archetype;

  /// Completion percentage 0.0–100.0.
  final double completionPct;

  /// Total number of "done" marks in the month (affects scale).
  final int absoluteCompletions;

  /// Longest consecutive streak in the month (affects lushness).
  final int maxStreak;

  /// Ratios of morning/afternoon/evening marks (for leaf gradient).
  final double morningRatio;
  final double afternoonRatio;
  final double eveningRatio;

  /// Random seed for reproducible generation.
  final int seed;

  /// True if habit started mid-month and achieved 100% (aura glow).
  final bool isShortPerfect;

  /// Computed object type (moss, bush, tree, sleepingBulb).
  final GardenObjectType objectType;

  /// Scale factor based on absolute completions (0.4–1.0).
  double get scaleFactor => (absoluteCompletions / 30.0).clamp(0.4, 1.0);

  /// Lushness factor based on max streak (0.3–1.0).
  double get lushness => (maxStreak / 20.0).clamp(0.3, 1.0);

  /// Canvas size for rasterization.
  static const double canvasSize = 800;

  /// Get the normalized center point.
  Offset get center => const Offset(canvasSize / 2, canvasSize * 0.85);
}
