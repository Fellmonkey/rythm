import 'dart:math';

import 'package:drift/drift.dart';

import '../database/app_database.dart';
import '../database/enums.dart';
import '../utils/date_helpers.dart';

/// A scenario that can be loaded via the debug menu.
class DebugScenario {
  const DebugScenario({
    required this.name,
    required this.description,
    required this.habitCount,
    required this.months,
    this.icon = '📦',
  });

  final String name;
  final String description;
  final int habitCount;

  /// How many past months of data to generate (1 / 3 / 6 / 12).
  final int months;
  final String icon;
}

/// All available scenarios for the debug menu.
const debugScenarios = [
  // ── Small ──
  DebugScenario(name: '5 привычек · 1 мес', description: 'Минимальный набор', habitCount: 5, months: 1, icon: '🌱'),
  DebugScenario(name: '5 привычек · 3 мес', description: 'Квартал с малым числом', habitCount: 5, months: 3, icon: '🌿'),
  DebugScenario(name: '5 привычек · 6 мес', description: 'Полгода', habitCount: 5, months: 6, icon: '🌳'),
  DebugScenario(name: '5 привычек · 12 мес', description: 'Полный год', habitCount: 5, months: 12, icon: '🌲'),
  // ── Medium ──
  DebugScenario(name: '30 привычек · 1 мес', description: 'Много привычек, мало истории', habitCount: 30, months: 1, icon: '📋'),
  DebugScenario(name: '30 привычек · 3 мес', description: 'Активный пользователь', habitCount: 30, months: 3, icon: '📊'),
  DebugScenario(name: '30 привычек · 6 мес', description: 'Полгода активности', habitCount: 30, months: 6, icon: '📈'),
  DebugScenario(name: '30 привычек · 12 мес', description: 'Тяжёлый юзер, год', habitCount: 30, months: 12, icon: '🏋️'),
  // ── Large ──
  DebugScenario(name: '90 привычек · 1 мес', description: 'Стресс-тест UI', habitCount: 90, months: 1, icon: '🔥'),
  DebugScenario(name: '90 привычек · 3 мес', description: 'Массивный набор', habitCount: 90, months: 3, icon: '💥'),
  DebugScenario(name: '90 привычек · 12 мес', description: 'Максимальная нагрузка', habitCount: 90, months: 12, icon: '🚀'),
];

// ── Habit name pool ────────────────────────────────────────

const _habitNames = [
  'Утренняя пробежка', 'Чтение книг', 'Медитация', 'Тренировка', 'Журнал благодарности',
  'Водный баланс', 'Растяжка', 'Практика языка', 'Уборка 15 мин', 'Без сахара',
  'Холодный душ', 'Прогулка', 'Йога', 'Дыхательная гимнастика', 'Учеба 30 мин',
  'Здоровый завтрак', 'Рисование', 'Музыка', 'Писательство', 'Фокус 2ч без телефона',
  'Вечерний ритуал', 'Витамины', 'Планирование дня', 'Осанка', 'Бег 5 км',
  'Отжимания', 'Подтягивания', 'Скакалка', 'Лестница', 'Зубная нить',
  'Код 1 час', 'Рецепт дня', 'Фото дня', 'Новые знакомства', 'Инвестиции',
  'Бюджет', 'Ранний подъём', 'Экран < 2ч вечером', 'Массаж лица', 'Уход за кожей',
  'Без кофеина', 'Без алкоголя', 'Без курения', 'Практика речи', 'Шахматы',
  'Отжимания 100', 'Планка 3 мин', 'Без фастфуда', 'Сон до 23', 'Благотворительность',
  'Обнять близкого', 'Позвонить родителям', 'Пресс', 'Турник', 'Плавание',
  'Велосипед', 'Танцы', 'Скалолазание', 'Сёрфинг', 'Навык дня',
  'Дневник снов', 'Аффирмации', 'Визуализация', 'Комплимент', 'Новая еда',
  'Уроки гитары', 'Подкаст', 'TED Talk', 'Документалка', 'Растения полив',
  'Стирка', 'Посуда сразу', 'Заправить кровать', 'Порядок стол', 'Расхламление',
  'Ноль отходов', 'Сортировка мусора', 'Экономия воды', 'Eco-bag', 'Вегетарианство',
  'Порция овощей', 'Без перекусов', 'Калории в норме', 'Белок 100 г', 'Клетчатка',
  'Магний', 'Омега-3', 'Тишина 15 мин', 'Самоанализ', 'Благодарность',
];

const _timeSlots = [
  TimeOfDay.morning,
  TimeOfDay.afternoon,
  TimeOfDay.evening,
  TimeOfDay.anytime,
];

// ── Frequency templates ────────────────────────────────────

class _FreqTemplate {
  const _FreqTemplate(this.type, this.value);
  final FrequencyType type;
  final String value;
}

const _freqTemplates = [
  _FreqTemplate(FrequencyType.daily, '{}'),
  _FreqTemplate(FrequencyType.daily, '{}'),
  _FreqTemplate(FrequencyType.weekdays, '{"days":[1,2,3,4,5]}'),
  _FreqTemplate(FrequencyType.weekdays, '{"days":[1,3,5]}'),
  _FreqTemplate(FrequencyType.xPerWeek, '{"x":3}'),
  _FreqTemplate(FrequencyType.xPerWeek, '{"x":5}'),
  _FreqTemplate(FrequencyType.everyXDays, '{"x":2}'),
  _FreqTemplate(FrequencyType.everyXDays, '{"x":3}'),
  _FreqTemplate(FrequencyType.negative, '{}'),
];

/// Seeds the database with realistic data for a [DebugScenario].
///
/// **Wipes all existing data** before inserting.
class DebugDataSeeder {
  DebugDataSeeder(this.db);

  final AppDatabase db;

  /// Clear the database and populate it with the given scenario.
  /// Returns the number of habits created.
  Future<int> seed(DebugScenario scenario) async {
    // 1. Wipe everything
    await db.gardenObjectsDao.deleteAllObjects();
    await db.habitLogsDao.deleteAllLogs();
    await db.habitsDao.deleteAllHabits();

    final rng = Random(scenario.habitCount * 1000 + scenario.months);
    final now = DateTime.now().toMidnight;

    // 2. Determine the time window
    final endMonth = DateTime.utc(now.year, now.month, 1); // current month start
    final startMonth = DateTime.utc(now.year, now.month - scenario.months, 1);

    // 3. Create habits
    final habitIds = <int>[];
    final habitMeta = <_HabitMeta>[];

    for (var i = 0; i < scenario.habitCount; i++) {
      final name = _habitNames[i % _habitNames.length];
      final suffix = i >= _habitNames.length ? ' (${i ~/ _habitNames.length + 1})' : '';
      final arch = SeedArchetype.values[i % SeedArchetype.values.length];
      final freq = _freqTemplates[i % _freqTemplates.length];
      final tod = _timeSlots[i % _timeSlots.length];

      // Stagger creation dates: first 60% start at the beginning,
      // 30% start 1–3 months in, 10% start mid-month.
      DateTime createdDate;
      if (i < scenario.habitCount * 0.6) {
        createdDate = startMonth;
      } else if (i < scenario.habitCount * 0.9) {
        final offsetMonths = rng.nextInt(scenario.months.clamp(1, 3));
        createdDate = DateTime.utc(
          startMonth.year,
          startMonth.month + offsetMonths,
          1,
        );
      } else {
        final offsetMonths = rng.nextInt(scenario.months.clamp(1, 2));
        createdDate = DateTime.utc(
          startMonth.year,
          startMonth.month + offsetMonths,
          rng.nextInt(20) + 5, // day 5–24
        );
      }
      // Clamp: can't be in the future
      if (createdDate.isAfter(now)) createdDate = now;

      final id = await db.habitsDao.insertHabit(HabitsCompanion.insert(
        name: '$name$suffix',
        createdAt: createdDate.unixSeconds,
        seedArchetype: Value(arch.name),
        frequencyType: Value(freq.type.name),
        frequencyValue: Value(freq.value),
        timeOfDay: Value(tod.name),
      ));

      habitIds.add(id);
      habitMeta.add(_HabitMeta(
        id: id,
        archetype: arch,
        freq: freq,
        tod: tod,
        createdAt: createdDate,
        // Base "skill" that slowly improves — random starting quality
        quality: 0.2 + rng.nextDouble() * 0.3, // 0.2–0.5 base
      ));
    }

    // 4. Generate logs + garden objects month by month
    var m = startMonth;
    while (m.isBefore(endMonth)) {
      for (final meta in habitMeta) {
        // Skip months before creation
        if (m.isBefore(DateTime.utc(
          meta.createdAt.year,
          meta.createdAt.month,
          1,
        ))) {
          continue;
        }

        await _generateMonth(
          meta: meta,
          year: m.year,
          month: m.month,
          now: now,
          rng: rng,
        );
      }
      m = DateTime.utc(m.year, m.month + 1, 1);
    }

    // 5. Generate today's logs as pending (so Greenhouse shows them)
    await _generateTodayLogs(habitMeta, now);

    return scenario.habitCount;
  }

  Future<void> _generateMonth({
    required _HabitMeta meta,
    required int year,
    required int month,
    required DateTime now,
    required Random rng,
  }) async {
    final monthStart = DateTime.utc(year, month, 1);
    final monthEnd = DateTime.utc(year, month + 1, 0);
    final effectiveStart = meta.createdAt.isAfter(monthStart)
        ? meta.createdAt
        : monthStart;
    // Don't generate logs for the current month — that's "live" data
    final currentMonthStart = DateTime.utc(now.year, now.month, 1);
    if (!monthStart.isBefore(currentMonthStart)) return;

    final totalDays = daysBetweenInclusive(effectiveStart, monthEnd);
    if (totalDays <= 0) return;

    // Quality drifts upward over months (simulates user getting better)
    final monthIndex = (year - meta.createdAt.year) * 12 +
        (month - meta.createdAt.month);
    final quality = (meta.quality + monthIndex * 0.06 + rng.nextDouble() * 0.1)
        .clamp(0.05, 0.98);

    // Occasionally, have a "slump" month
    final isSlump = rng.nextDouble() < 0.12;
    final effectiveQuality = isSlump ? quality * 0.4 : quality;

    var doneCount = 0;
    var skipCount = 0;
    var maxStreak = 0;
    var currentStreak = 0;
    var morningCount = 0;
    var afternoonCount = 0;
    var eveningCount = 0;

    for (var d = 0; d < totalDays; d++) {
      final date = effectiveStart.add(Duration(days: d));
      if (date.isAfter(now)) break;

      // Determine if this day should have a log based on frequency
      if (!_shouldLogDay(meta, date)) continue;

      // Decide outcome
      final roll = rng.nextDouble();
      String status;
      int? loggedHour;

      if (roll < effectiveQuality) {
        status = LogStatus.done.name;
        doneCount++;
        currentStreak++;
        if (currentStreak > maxStreak) maxStreak = currentStreak;

        // Assign hour based on time-of-day preference
        loggedHour = _hourForTimeOfDay(meta.tod, rng);
        final h = loggedHour;
        if (h >= 5 && h < 12) {
          morningCount++;
        } else if (h >= 12 && h < 18) {
          afternoonCount++;
        } else {
          eveningCount++;
        }
      } else if (roll < effectiveQuality + 0.1) {
        status = LogStatus.skip.name;
        skipCount++;
        // skip doesn't break streak
      } else {
        status = LogStatus.fail.name;
        currentStreak = 0;
      }

      await db.habitLogsDao.upsertLog(HabitLogsCompanion.insert(
        habitId: meta.id,
        date: date.unixSeconds,
        status: Value(status),
        loggedHour: Value(loggedHour),
      ));
    }

    // Insert garden object for completed months
    final totalTimed = morningCount + afternoonCount + eveningCount;
    final mRatio = totalTimed > 0 ? morningCount / totalTimed : 0.33;
    final aRatio = totalTimed > 0 ? afternoonCount / totalTimed : 0.33;
    final eRatio = totalTimed > 0 ? eveningCount / totalTimed : 0.34;

    final rawBase = totalDays - skipCount;
    final pct = rawBase > 0
        ? (doneCount / rawBase * 100).clamp(0.0, 100.0)
        : 0.0;

    final objectType = _objectType(pct, doneCount);
    final activeDays = daysBetweenInclusive(effectiveStart, monthEnd);
    final isShortPerfect = activeDays < 7 && pct >= 100.0;

    await db.gardenObjectsDao.insertObject(GardenObjectsCompanion(
      habitId: Value(meta.id),
      year: Value(year),
      month: Value(month),
      completionPct: Value(pct),
      absoluteCompletions: Value(doneCount),
      maxStreak: Value(maxStreak),
      morningRatio: Value(mRatio),
      afternoonRatio: Value(aRatio),
      eveningRatio: Value(eRatio),
      objectType: Value(objectType.name),
      generationSeed: Value(rng.nextInt(1 << 31)),
      isShortPerfect: Value(isShortPerfect),
    ));
  }

  /// Generate pending logs for today so the Greenhouse screen shows habits.
  Future<void> _generateTodayLogs(
    List<_HabitMeta> metas,
    DateTime now,
  ) async {
    for (final meta in metas) {
      if (meta.createdAt.isAfter(now)) continue;
      await db.habitLogsDao.upsertLog(HabitLogsCompanion.insert(
        habitId: meta.id,
        date: now.unixSeconds,
        status: const Value('pending'),
      ));
    }
  }

  bool _shouldLogDay(_HabitMeta meta, DateTime date) {
    switch (meta.freq.type) {
      case FrequencyType.daily:
      case FrequencyType.negative:
        return true;
      case FrequencyType.weekdays:
        // Parse weekdays from value
        final days = _parseWeekdays(meta.freq.value);
        return days.contains(date.weekday);
      case FrequencyType.xPerWeek:
        // Simplified: log on ~x random days per week
        return true;
      case FrequencyType.everyXDays:
        final x = _parseX(meta.freq.value);
        final diff = date.difference(meta.createdAt.toMidnight).inDays;
        return diff % x == 0;
    }
  }

  static GardenObjectType _objectType(double pct, int absoluteCount) {
    if (pct < 40) {
      return absoluteCount == 0
          ? GardenObjectType.sleepingBulb
          : GardenObjectType.moss;
    }
    if (pct < 80) return GardenObjectType.bush;
    if (absoluteCount >= 5) return GardenObjectType.tree;
    return GardenObjectType.bush;
  }

  static int _hourForTimeOfDay(TimeOfDay tod, Random rng) => switch (tod) {
        TimeOfDay.morning => 6 + rng.nextInt(5),    // 6–10
        TimeOfDay.afternoon => 12 + rng.nextInt(5),  // 12–16
        TimeOfDay.evening => 18 + rng.nextInt(4),    // 18–21
        TimeOfDay.anytime => 7 + rng.nextInt(14),    // 7–20
      };

  static List<int> _parseWeekdays(String json) {
    try {
      final match = RegExp(r'\[([0-9,\s]+)\]').firstMatch(json);
      if (match != null) {
        return match.group(1)!.split(',').map((s) => int.parse(s.trim())).toList();
      }
    } catch (_) {}
    return [1, 2, 3, 4, 5];
  }

  static int _parseX(String json) {
    try {
      final match = RegExp(r'"x"\s*:\s*(\d+)').firstMatch(json);
      if (match != null) return int.parse(match.group(1)!);
    } catch (_) {}
    return 2;
  }
}

class _HabitMeta {
  _HabitMeta({
    required this.id,
    required this.archetype,
    required this.freq,
    required this.tod,
    required this.createdAt,
    required this.quality,
  });

  final int id;
  final SeedArchetype archetype;
  final _FreqTemplate freq;
  final TimeOfDay tod;
  final DateTime createdAt;

  /// Base "quality" of the user's habit — how likely they are to do it.
  final double quality;
}
