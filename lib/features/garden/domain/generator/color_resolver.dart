import 'dart:ui';

import '../../../../core/theme/app_colors.dart';

/// Resolves leaf colors based on time-of-day check-in ratios.
///
/// Per spec section 2.2:
/// - Morning ratio dominant → Sage Green (lower leaves)
/// - Afternoon ratio → Warm Amber (middle)
/// - Evening ratio → Soft Lavender (crown/top)
///
/// The gradient goes bottom→top: morning → evening → afternoon (crown).
class ColorResolver {
  const ColorResolver._();

  static const _morningColor = AppColors.sageGreen;
  static const _afternoonColor = AppColors.warmAmber;
  static const _eveningColor = AppColors.softLavender;

  /// Trunk color — brown gradient.
  static const trunkColorLight = Color(0xFF8B6F47);
  static const trunkColorDark = Color(0xFF5C4A2E);

  /// Moss/pebble colors.
  static const mossGreen = Color(0xFF7BA05B);
  static const mossGreenLight = Color(0xFFA8C986);
  static const pebbleGrey = Color(0xFFB0A89A);
  static const pebbleLight = Color(0xFFD4CEC3);

  /// Get the leaf color at a given vertical position [t] (0 = bottom, 1 = top).
  /// Blends morning/evening/afternoon based on the ratios.
  static Color leafColorAt(
    double t, {
    required double morningRatio,
    required double afternoonRatio,
    required double eveningRatio,
  }) {
    // Bottom (0.0) → morning color, weighted by ratio
    // Middle (0.5) → evening color, weighted by ratio
    // Top (1.0) → afternoon color, weighted by ratio
    final morningWeight = morningRatio;
    final eveningWeight = eveningRatio;
    final afternoonWeight = afternoonRatio;

    if (t < 0.5) {
      // Bottom half: blend morning → evening
      final localT = t * 2.0;
      final c1 = _blendWithWeight(_morningColor, morningWeight);
      final c2 = _blendWithWeight(_eveningColor, eveningWeight);
      return Color.lerp(c1, c2, localT)!;
    } else {
      // Top half: blend evening → afternoon (crown)
      final localT = (t - 0.5) * 2.0;
      final c1 = _blendWithWeight(_eveningColor, eveningWeight);
      final c2 = _blendWithWeight(_afternoonColor, afternoonWeight);
      return Color.lerp(c1, c2, localT)!;
    }
  }

  /// Blend a base color with desaturation based on its weight.
  /// Higher weight = more saturated (original) color.
  /// Lower weight = more neutral/grey-green.
  static Color _blendWithWeight(Color base, double weight) {
    const neutral = Color(0xFF8DAF8C); // Muted sage neutral
    return Color.lerp(neutral, base, weight.clamp(0.2, 1.0))!;
  }

  /// Get 3-stop gradient colors for a leaf fill.
  static List<Color> leafGradient({
    required double morningRatio,
    required double afternoonRatio,
    required double eveningRatio,
  }) {
    return [
      leafColorAt(0.0,
          morningRatio: morningRatio,
          afternoonRatio: afternoonRatio,
          eveningRatio: eveningRatio),
      leafColorAt(0.5,
          morningRatio: morningRatio,
          afternoonRatio: afternoonRatio,
          eveningRatio: eveningRatio),
      leafColorAt(1.0,
          morningRatio: morningRatio,
          afternoonRatio: afternoonRatio,
          eveningRatio: eveningRatio),
    ];
  }
}
