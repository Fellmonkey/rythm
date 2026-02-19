import 'package:drift/drift.dart';

import '../../../../database/app_database.dart';
import '../../domain/repositories/habit_template_repository.dart';

/// Реализация репозитория шаблонов привычек.
class HabitTemplateRepositoryImpl implements HabitTemplateRepository {
  HabitTemplateRepositoryImpl(this._db);
  final AppDatabase _db;

  @override
  Future<List<HabitTemplate>> getAll() {
    return _db.select(_db.habitTemplates).get();
  }

  @override
  Future<List<HabitTemplateItem>> getItems(int templateId) {
    return (_db.select(
      _db.habitTemplateItems,
    )..where((t) => t.templateId.equals(templateId))).get();
  }

  @override
  Future<int> apply(int templateId) async {
    final items = await getItems(templateId);
    final now = DateTime.now().toUtc();
    int created = 0;

    for (final item in items) {
      await _db
          .into(_db.habits)
          .insert(
            HabitsCompanion.insert(
              name: item.habitName,
              type: Value(item.habitType),
              targetValue: Value(item.targetValue),
              minValue: Value(item.minValue),
              unit: Value(item.unit),
              sphereId: Value(item.sphereId),
              priority: Value(item.priority),
              energyRequired: Value(item.energyRequired),
              createdAt: now,
              updatedAt: now,
            ),
          );
      created++;
    }
    return created;
  }

  @override
  Future<int> createFromHabits(String name, List<int> habitIds) async {
    final now = DateTime.now().toUtc();

    final templateId = await _db
        .into(_db.habitTemplates)
        .insert(
          HabitTemplatesCompanion.insert(
            name: name,
            isPreset: const Value(false),
            createdAt: now,
          ),
        );

    for (final hid in habitIds) {
      final habit = await (_db.select(
        _db.habits,
      )..where((t) => t.id.equals(hid))).getSingle();

      await _db
          .into(_db.habitTemplateItems)
          .insert(
            HabitTemplateItemsCompanion.insert(
              templateId: templateId,
              habitName: habit.name,
              habitType: Value(habit.type),
              targetValue: Value(habit.targetValue),
              minValue: Value(habit.minValue),
              unit: Value(habit.unit),
              sphereId: Value(habit.sphereId),
              priority: Value(habit.priority),
              energyRequired: Value(habit.energyRequired),
              createdAt: now,
            ),
          );
    }

    return templateId;
  }

  @override
  Future<void> delete(int templateId) async {
    await (_db.delete(
      _db.habitTemplateItems,
    )..where((t) => t.templateId.equals(templateId))).go();
    await (_db.delete(
      _db.habitTemplates,
    )..where((t) => t.id.equals(templateId))).go();
  }

  /// Создать встроенные шаблоны-пресеты если их нет.
  Future<void> seedPresets() async {
    final existing = await (_db.select(
      _db.habitTemplates,
    )..where((t) => t.isPreset.equals(true))).get();
    if (existing.isNotEmpty) return;

    final now = DateTime.now().toUtc();

    // --- Утренний ритуал ---
    final morningId = await _db
        .into(_db.habitTemplates)
        .insert(
          HabitTemplatesCompanion.insert(
            name: 'Утренний ритуал',
            category: const Value('morning'),
            description: const Value(
              'Начните день правильно: вода, зарядка, медитация',
            ),
            isPreset: const Value(true),
            createdAt: now,
          ),
        );
    for (final item in _morningItems(morningId, now)) {
      await _db.into(_db.habitTemplateItems).insert(item);
    }

    // --- Вечерний wind-down ---
    final eveningId = await _db
        .into(_db.habitTemplates)
        .insert(
          HabitTemplatesCompanion.insert(
            name: 'Вечерний wind-down',
            category: const Value('evening'),
            description: const Value(
              'Расслабьтесь перед сном: чтение, дневник, нет экранов',
            ),
            isPreset: const Value(true),
            createdAt: now,
          ),
        );
    for (final item in _eveningItems(eveningId, now)) {
      await _db.into(_db.habitTemplateItems).insert(item);
    }

    // --- Здоровье ---
    final healthId = await _db
        .into(_db.habitTemplates)
        .insert(
          HabitTemplatesCompanion.insert(
            name: 'Здоровье',
            category: const Value('health'),
            description: const Value('Базовые привычки для здоровья и энергии'),
            isPreset: const Value(true),
            createdAt: now,
          ),
        );
    for (final item in _healthItems(healthId, now)) {
      await _db.into(_db.habitTemplateItems).insert(item);
    }

    // --- Продуктивность ---
    final prodId = await _db
        .into(_db.habitTemplates)
        .insert(
          HabitTemplatesCompanion.insert(
            name: 'Продуктивность',
            category: const Value('productivity'),
            description: const Value('Фокус, планирование, глубокая работа'),
            isPreset: const Value(true),
            createdAt: now,
          ),
        );
    for (final item in _productivityItems(prodId, now)) {
      await _db.into(_db.habitTemplateItems).insert(item);
    }
  }

  // --- Preset data ---

  List<HabitTemplateItemsCompanion> _morningItems(int tid, DateTime now) => [
    HabitTemplateItemsCompanion.insert(
      templateId: tid,
      habitName: 'Стакан воды',
      createdAt: now,
      energyRequired: const Value(1),
    ),
    HabitTemplateItemsCompanion.insert(
      templateId: tid,
      habitName: 'Зарядка',
      habitType: const Value('duration'),
      targetValue: const Value(10),
      minValue: const Value(5),
      unit: const Value('мин'),
      createdAt: now,
      energyRequired: const Value(2),
    ),
    HabitTemplateItemsCompanion.insert(
      templateId: tid,
      habitName: 'Медитация',
      habitType: const Value('duration'),
      targetValue: const Value(10),
      minValue: const Value(3),
      unit: const Value('мин'),
      createdAt: now,
      energyRequired: const Value(1),
    ),
    HabitTemplateItemsCompanion.insert(
      templateId: tid,
      habitName: 'Не брать телефон 30 мин',
      createdAt: now,
      energyRequired: const Value(1),
    ),
  ];

  List<HabitTemplateItemsCompanion> _eveningItems(int tid, DateTime now) => [
    HabitTemplateItemsCompanion.insert(
      templateId: tid,
      habitName: 'Чтение',
      habitType: const Value('duration'),
      targetValue: const Value(20),
      minValue: const Value(5),
      unit: const Value('мин'),
      createdAt: now,
      energyRequired: const Value(1),
    ),
    HabitTemplateItemsCompanion.insert(
      templateId: tid,
      habitName: 'Дневник / рефлексия',
      createdAt: now,
      energyRequired: const Value(1),
    ),
    HabitTemplateItemsCompanion.insert(
      templateId: tid,
      habitName: 'Нет экранов за 1 час до сна',
      createdAt: now,
      energyRequired: const Value(1),
    ),
  ];

  List<HabitTemplateItemsCompanion> _healthItems(int tid, DateTime now) => [
    HabitTemplateItemsCompanion.insert(
      templateId: tid,
      habitName: 'Выпить воду',
      habitType: const Value('counter'),
      targetValue: const Value(8),
      minValue: const Value(4),
      unit: const Value('стаканов'),
      createdAt: now,
      energyRequired: const Value(1),
    ),
    HabitTemplateItemsCompanion.insert(
      templateId: tid,
      habitName: 'Прогулка',
      habitType: const Value('duration'),
      targetValue: const Value(30),
      minValue: const Value(10),
      unit: const Value('мин'),
      createdAt: now,
      energyRequired: const Value(2),
    ),
    HabitTemplateItemsCompanion.insert(
      templateId: tid,
      habitName: 'Принять витамины',
      createdAt: now,
      energyRequired: const Value(1),
    ),
    HabitTemplateItemsCompanion.insert(
      templateId: tid,
      habitName: 'Тренировка',
      habitType: const Value('duration'),
      targetValue: const Value(45),
      minValue: const Value(15),
      unit: const Value('мин'),
      createdAt: now,
      energyRequired: const Value(3),
      priority: const Value(1),
    ),
  ];

  List<HabitTemplateItemsCompanion> _productivityItems(int tid, DateTime now) =>
      [
        HabitTemplateItemsCompanion.insert(
          templateId: tid,
          habitName: 'Планирование дня',
          createdAt: now,
          energyRequired: const Value(1),
        ),
        HabitTemplateItemsCompanion.insert(
          templateId: tid,
          habitName: 'Глубокая работа',
          habitType: const Value('duration'),
          targetValue: const Value(90),
          minValue: const Value(25),
          unit: const Value('мин'),
          createdAt: now,
          energyRequired: const Value(3),
          priority: const Value(2),
        ),
        HabitTemplateItemsCompanion.insert(
          templateId: tid,
          habitName: 'Изучение нового',
          habitType: const Value('duration'),
          targetValue: const Value(30),
          minValue: const Value(10),
          unit: const Value('мин'),
          createdAt: now,
          energyRequired: const Value(2),
        ),
      ];
}
