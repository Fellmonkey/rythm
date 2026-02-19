import 'package:drift/drift.dart';

/// Таблица profiles (Локальный конфиг)
class Profiles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  IntColumn get dayStartHour => integer().withDefault(const Constant(0))();
  TextColumn get timezoneMode =>
      text().withDefault(const Constant('auto'))(); // 'auto' | 'fixed'
  TextColumn get fixedTimezone => text().nullable()();
  BoolColumn get backupEnabled => boolean().withDefault(const Constant(true))();
  IntColumn get backupFrequencyDays =>
      integer().withDefault(const Constant(1))();
  IntColumn get maxBackupCount => integer().withDefault(const Constant(5))();
  DateTimeColumn get lastBackupAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

/// Таблица spheres (Сферы жизни)
class Spheres extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get color => text().withDefault(const Constant('#9B7EBD'))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

/// Таблица tags (Теги для кросс-сферности)
class Tags extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 30)();
  TextColumn get color => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
}

/// Таблица habits (Привычки)
class Habits extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get description => text().nullable()();
  IntColumn get sphereId => integer().nullable().references(Spheres, #id)();
  TextColumn get type => text().withDefault(
    const Constant('binary'),
  )(); // 'binary'|'counter'|'duration'
  IntColumn get targetValue => integer().withDefault(const Constant(1))();
  IntColumn get minValue =>
      integer().withDefault(const Constant(1))(); // Guilt-Free минимум
  TextColumn get unit => text().nullable()(); // 'мл', 'мин', 'раз'
  IntColumn get priority => integer().withDefault(const Constant(0))(); // 0-2
  IntColumn get energyRequired =>
      integer().withDefault(const Constant(2))(); // 1-3
  IntColumn get goalPerWeek => integer().withDefault(const Constant(7))();
  BoolColumn get archived => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

/// Таблица habit_tags (Связь Many-to-Many)
class HabitTags extends Table {
  IntColumn get habitId => integer().references(Habits, #id)();
  IntColumn get tagId => integer().references(Tags, #id)();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {habitId, tagId};
}

/// Таблица skip_days (Осознанные пропуски)
class SkipDays extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get reason => text()(); // 'rest', 'sick', 'travel', 'other'
  TextColumn get note => text().nullable()();
  DateTimeColumn get date => dateTime()(); // UTC дата пропуска
  DateTimeColumn get createdAt => dateTime()();
}

/// Таблица habit_logs (История выполнений)
class HabitLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get habitId => integer().references(Habits, #id)();
  IntColumn get status => integer()(); // 0=missed, 1=partial, 2=complete
  IntColumn get actualValue => integer().withDefault(const Constant(0))();
  IntColumn get skipReasonId =>
      integer().nullable().references(SkipDays, #id)();
  IntColumn get energyLevel => integer().nullable()(); // 1-3
  IntColumn get durationSeconds => integer().nullable()();
  DateTimeColumn get timestamp => dateTime()(); // UTC
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

/// Таблица energy_logs (Энергетический трекер)
class EnergyLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get energyLevel => integer()(); // 1-3
  TextColumn get note => text().nullable()();
  DateTimeColumn get timestamp => dateTime()(); // UTC
  DateTimeColumn get createdAt => dateTime()();
}

/// Таблица visual_rewards_config
@DataClassName('VisualRewardConfig')
class VisualRewardsConfigs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get seasonTheme => text().withDefault(const Constant('spring'))();
  IntColumn get seed => integer()();
  IntColumn get aggregateLevel => integer().withDefault(const Constant(0))();
  DateTimeColumn get seasonStartAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

/// Таблица backups (История бэкапов)
@DataClassName('BackupRecord')
class BackupRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get filePath => text()();
  TextColumn get fileHash => text().nullable()();
  IntColumn get fileSizeBytes => integer()();
  DateTimeColumn get createdAt => dateTime()();
}

/// Таблица sleep_logs (Опционально)
class SleepLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get bedtime => dateTime()();
  DateTimeColumn get wakeTime => dateTime()();
  IntColumn get durationMinutes => integer()();
  IntColumn get qualityScore => integer().nullable()(); // 1-5
  TextColumn get source => text().withDefault(const Constant('manual'))();
  DateTimeColumn get createdAt => dateTime()();
}

/// Таблица habit_templates
class HabitTemplates extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get category => text().nullable()();
  TextColumn get description => text().nullable()();
  BoolColumn get isPreset => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
}

/// Таблица habit_template_items
class HabitTemplateItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get templateId => integer().references(HabitTemplates, #id)();
  TextColumn get habitName => text().withLength(min: 1, max: 100)();
  TextColumn get habitType => text().withDefault(const Constant('binary'))();
  IntColumn get targetValue => integer().withDefault(const Constant(1))();
  IntColumn get minValue => integer().withDefault(const Constant(1))();
  TextColumn get unit => text().nullable()();
  IntColumn get sphereId => integer().nullable()();
  IntColumn get priority => integer().withDefault(const Constant(0))();
  IntColumn get energyRequired => integer().withDefault(const Constant(2))();
  DateTimeColumn get createdAt => dateTime()();
}
