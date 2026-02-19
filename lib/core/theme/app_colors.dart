import 'dart:ui';

/// Цветовая палитра приложения — без красного, guilt-free
abstract final class AppColors {
  // Основные
  static const background = Color(0xFF000000); // True Black (OLED)
  static const surface = Color(0xFF121212);
  static const surfaceVariant = Color(0xFF1E1E1E);
  static const accent = Color(0xFF9B7EBD); // Мягкий фиолетовый

  // Энергия (градиент одного цвета)
  static const energyHigh = Color(0xFF9B7EBD); // Насыщенный фиолетовый
  static const energyMedium = Color(0xFFBFA8D9); // Бледный фиолетовый
  static const energyLow = Color(0xFF6B6B6B); // Серый

  // Статусы
  static const success = Color(0xFF7CB69D); // Зелёный/фиолетовый
  static const partial = Color(0xFFBFA8D9); // Бледный фиолетовый
  static const warning = Color(0xFFFFB74D); // Янтарный
  static const error = Color(0xFFB0B0B0); // Нейтральный серый
  static const skip = Color(0xFF6B6B6B); // Серый — не провал

  // Текст
  static const textPrimary = Color(0xFFE0E0E0);
  static const textSecondary = Color(0xFF9E9E9E);
  static const textHint = Color(0xFF616161);

  // Health indicator (только Web)
  static const healthGood = Color(0xFF4CAF50);
  static const healthWarning = Color(0xFFFFB74D);
  static const healthBad = Color(0xFFF44336);
}
