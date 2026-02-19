// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ProfilesTable extends Profiles with TableInfo<$ProfilesTable, Profile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dayStartHourMeta = const VerificationMeta(
    'dayStartHour',
  );
  @override
  late final GeneratedColumn<int> dayStartHour = GeneratedColumn<int>(
    'day_start_hour',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _timezoneModeMeta = const VerificationMeta(
    'timezoneMode',
  );
  @override
  late final GeneratedColumn<String> timezoneMode = GeneratedColumn<String>(
    'timezone_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('auto'),
  );
  static const VerificationMeta _fixedTimezoneMeta = const VerificationMeta(
    'fixedTimezone',
  );
  @override
  late final GeneratedColumn<String> fixedTimezone = GeneratedColumn<String>(
    'fixed_timezone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _backupEnabledMeta = const VerificationMeta(
    'backupEnabled',
  );
  @override
  late final GeneratedColumn<bool> backupEnabled = GeneratedColumn<bool>(
    'backup_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("backup_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _backupFrequencyDaysMeta =
      const VerificationMeta('backupFrequencyDays');
  @override
  late final GeneratedColumn<int> backupFrequencyDays = GeneratedColumn<int>(
    'backup_frequency_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _maxBackupCountMeta = const VerificationMeta(
    'maxBackupCount',
  );
  @override
  late final GeneratedColumn<int> maxBackupCount = GeneratedColumn<int>(
    'max_backup_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(5),
  );
  static const VerificationMeta _lastBackupAtMeta = const VerificationMeta(
    'lastBackupAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastBackupAt = GeneratedColumn<DateTime>(
    'last_backup_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    dayStartHour,
    timezoneMode,
    fixedTimezone,
    backupEnabled,
    backupFrequencyDays,
    maxBackupCount,
    lastBackupAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<Profile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('day_start_hour')) {
      context.handle(
        _dayStartHourMeta,
        dayStartHour.isAcceptableOrUnknown(
          data['day_start_hour']!,
          _dayStartHourMeta,
        ),
      );
    }
    if (data.containsKey('timezone_mode')) {
      context.handle(
        _timezoneModeMeta,
        timezoneMode.isAcceptableOrUnknown(
          data['timezone_mode']!,
          _timezoneModeMeta,
        ),
      );
    }
    if (data.containsKey('fixed_timezone')) {
      context.handle(
        _fixedTimezoneMeta,
        fixedTimezone.isAcceptableOrUnknown(
          data['fixed_timezone']!,
          _fixedTimezoneMeta,
        ),
      );
    }
    if (data.containsKey('backup_enabled')) {
      context.handle(
        _backupEnabledMeta,
        backupEnabled.isAcceptableOrUnknown(
          data['backup_enabled']!,
          _backupEnabledMeta,
        ),
      );
    }
    if (data.containsKey('backup_frequency_days')) {
      context.handle(
        _backupFrequencyDaysMeta,
        backupFrequencyDays.isAcceptableOrUnknown(
          data['backup_frequency_days']!,
          _backupFrequencyDaysMeta,
        ),
      );
    }
    if (data.containsKey('max_backup_count')) {
      context.handle(
        _maxBackupCountMeta,
        maxBackupCount.isAcceptableOrUnknown(
          data['max_backup_count']!,
          _maxBackupCountMeta,
        ),
      );
    }
    if (data.containsKey('last_backup_at')) {
      context.handle(
        _lastBackupAtMeta,
        lastBackupAt.isAcceptableOrUnknown(
          data['last_backup_at']!,
          _lastBackupAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Profile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Profile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      dayStartHour: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}day_start_hour'],
      )!,
      timezoneMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}timezone_mode'],
      )!,
      fixedTimezone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fixed_timezone'],
      ),
      backupEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}backup_enabled'],
      )!,
      backupFrequencyDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}backup_frequency_days'],
      )!,
      maxBackupCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_backup_count'],
      )!,
      lastBackupAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_backup_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ProfilesTable createAlias(String alias) {
    return $ProfilesTable(attachedDatabase, alias);
  }
}

class Profile extends DataClass implements Insertable<Profile> {
  final int id;
  final String name;
  final int dayStartHour;
  final String timezoneMode;
  final String? fixedTimezone;
  final bool backupEnabled;
  final int backupFrequencyDays;
  final int maxBackupCount;
  final DateTime? lastBackupAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Profile({
    required this.id,
    required this.name,
    required this.dayStartHour,
    required this.timezoneMode,
    this.fixedTimezone,
    required this.backupEnabled,
    required this.backupFrequencyDays,
    required this.maxBackupCount,
    this.lastBackupAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['day_start_hour'] = Variable<int>(dayStartHour);
    map['timezone_mode'] = Variable<String>(timezoneMode);
    if (!nullToAbsent || fixedTimezone != null) {
      map['fixed_timezone'] = Variable<String>(fixedTimezone);
    }
    map['backup_enabled'] = Variable<bool>(backupEnabled);
    map['backup_frequency_days'] = Variable<int>(backupFrequencyDays);
    map['max_backup_count'] = Variable<int>(maxBackupCount);
    if (!nullToAbsent || lastBackupAt != null) {
      map['last_backup_at'] = Variable<DateTime>(lastBackupAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ProfilesCompanion toCompanion(bool nullToAbsent) {
    return ProfilesCompanion(
      id: Value(id),
      name: Value(name),
      dayStartHour: Value(dayStartHour),
      timezoneMode: Value(timezoneMode),
      fixedTimezone: fixedTimezone == null && nullToAbsent
          ? const Value.absent()
          : Value(fixedTimezone),
      backupEnabled: Value(backupEnabled),
      backupFrequencyDays: Value(backupFrequencyDays),
      maxBackupCount: Value(maxBackupCount),
      lastBackupAt: lastBackupAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastBackupAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Profile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Profile(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      dayStartHour: serializer.fromJson<int>(json['dayStartHour']),
      timezoneMode: serializer.fromJson<String>(json['timezoneMode']),
      fixedTimezone: serializer.fromJson<String?>(json['fixedTimezone']),
      backupEnabled: serializer.fromJson<bool>(json['backupEnabled']),
      backupFrequencyDays: serializer.fromJson<int>(
        json['backupFrequencyDays'],
      ),
      maxBackupCount: serializer.fromJson<int>(json['maxBackupCount']),
      lastBackupAt: serializer.fromJson<DateTime?>(json['lastBackupAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'dayStartHour': serializer.toJson<int>(dayStartHour),
      'timezoneMode': serializer.toJson<String>(timezoneMode),
      'fixedTimezone': serializer.toJson<String?>(fixedTimezone),
      'backupEnabled': serializer.toJson<bool>(backupEnabled),
      'backupFrequencyDays': serializer.toJson<int>(backupFrequencyDays),
      'maxBackupCount': serializer.toJson<int>(maxBackupCount),
      'lastBackupAt': serializer.toJson<DateTime?>(lastBackupAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Profile copyWith({
    int? id,
    String? name,
    int? dayStartHour,
    String? timezoneMode,
    Value<String?> fixedTimezone = const Value.absent(),
    bool? backupEnabled,
    int? backupFrequencyDays,
    int? maxBackupCount,
    Value<DateTime?> lastBackupAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Profile(
    id: id ?? this.id,
    name: name ?? this.name,
    dayStartHour: dayStartHour ?? this.dayStartHour,
    timezoneMode: timezoneMode ?? this.timezoneMode,
    fixedTimezone: fixedTimezone.present
        ? fixedTimezone.value
        : this.fixedTimezone,
    backupEnabled: backupEnabled ?? this.backupEnabled,
    backupFrequencyDays: backupFrequencyDays ?? this.backupFrequencyDays,
    maxBackupCount: maxBackupCount ?? this.maxBackupCount,
    lastBackupAt: lastBackupAt.present ? lastBackupAt.value : this.lastBackupAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Profile copyWithCompanion(ProfilesCompanion data) {
    return Profile(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      dayStartHour: data.dayStartHour.present
          ? data.dayStartHour.value
          : this.dayStartHour,
      timezoneMode: data.timezoneMode.present
          ? data.timezoneMode.value
          : this.timezoneMode,
      fixedTimezone: data.fixedTimezone.present
          ? data.fixedTimezone.value
          : this.fixedTimezone,
      backupEnabled: data.backupEnabled.present
          ? data.backupEnabled.value
          : this.backupEnabled,
      backupFrequencyDays: data.backupFrequencyDays.present
          ? data.backupFrequencyDays.value
          : this.backupFrequencyDays,
      maxBackupCount: data.maxBackupCount.present
          ? data.maxBackupCount.value
          : this.maxBackupCount,
      lastBackupAt: data.lastBackupAt.present
          ? data.lastBackupAt.value
          : this.lastBackupAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Profile(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('dayStartHour: $dayStartHour, ')
          ..write('timezoneMode: $timezoneMode, ')
          ..write('fixedTimezone: $fixedTimezone, ')
          ..write('backupEnabled: $backupEnabled, ')
          ..write('backupFrequencyDays: $backupFrequencyDays, ')
          ..write('maxBackupCount: $maxBackupCount, ')
          ..write('lastBackupAt: $lastBackupAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    dayStartHour,
    timezoneMode,
    fixedTimezone,
    backupEnabled,
    backupFrequencyDays,
    maxBackupCount,
    lastBackupAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Profile &&
          other.id == this.id &&
          other.name == this.name &&
          other.dayStartHour == this.dayStartHour &&
          other.timezoneMode == this.timezoneMode &&
          other.fixedTimezone == this.fixedTimezone &&
          other.backupEnabled == this.backupEnabled &&
          other.backupFrequencyDays == this.backupFrequencyDays &&
          other.maxBackupCount == this.maxBackupCount &&
          other.lastBackupAt == this.lastBackupAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ProfilesCompanion extends UpdateCompanion<Profile> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> dayStartHour;
  final Value<String> timezoneMode;
  final Value<String?> fixedTimezone;
  final Value<bool> backupEnabled;
  final Value<int> backupFrequencyDays;
  final Value<int> maxBackupCount;
  final Value<DateTime?> lastBackupAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ProfilesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.dayStartHour = const Value.absent(),
    this.timezoneMode = const Value.absent(),
    this.fixedTimezone = const Value.absent(),
    this.backupEnabled = const Value.absent(),
    this.backupFrequencyDays = const Value.absent(),
    this.maxBackupCount = const Value.absent(),
    this.lastBackupAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ProfilesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.dayStartHour = const Value.absent(),
    this.timezoneMode = const Value.absent(),
    this.fixedTimezone = const Value.absent(),
    this.backupEnabled = const Value.absent(),
    this.backupFrequencyDays = const Value.absent(),
    this.maxBackupCount = const Value.absent(),
    this.lastBackupAt = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : name = Value(name),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Profile> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? dayStartHour,
    Expression<String>? timezoneMode,
    Expression<String>? fixedTimezone,
    Expression<bool>? backupEnabled,
    Expression<int>? backupFrequencyDays,
    Expression<int>? maxBackupCount,
    Expression<DateTime>? lastBackupAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (dayStartHour != null) 'day_start_hour': dayStartHour,
      if (timezoneMode != null) 'timezone_mode': timezoneMode,
      if (fixedTimezone != null) 'fixed_timezone': fixedTimezone,
      if (backupEnabled != null) 'backup_enabled': backupEnabled,
      if (backupFrequencyDays != null)
        'backup_frequency_days': backupFrequencyDays,
      if (maxBackupCount != null) 'max_backup_count': maxBackupCount,
      if (lastBackupAt != null) 'last_backup_at': lastBackupAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ProfilesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int>? dayStartHour,
    Value<String>? timezoneMode,
    Value<String?>? fixedTimezone,
    Value<bool>? backupEnabled,
    Value<int>? backupFrequencyDays,
    Value<int>? maxBackupCount,
    Value<DateTime?>? lastBackupAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return ProfilesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      dayStartHour: dayStartHour ?? this.dayStartHour,
      timezoneMode: timezoneMode ?? this.timezoneMode,
      fixedTimezone: fixedTimezone ?? this.fixedTimezone,
      backupEnabled: backupEnabled ?? this.backupEnabled,
      backupFrequencyDays: backupFrequencyDays ?? this.backupFrequencyDays,
      maxBackupCount: maxBackupCount ?? this.maxBackupCount,
      lastBackupAt: lastBackupAt ?? this.lastBackupAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (dayStartHour.present) {
      map['day_start_hour'] = Variable<int>(dayStartHour.value);
    }
    if (timezoneMode.present) {
      map['timezone_mode'] = Variable<String>(timezoneMode.value);
    }
    if (fixedTimezone.present) {
      map['fixed_timezone'] = Variable<String>(fixedTimezone.value);
    }
    if (backupEnabled.present) {
      map['backup_enabled'] = Variable<bool>(backupEnabled.value);
    }
    if (backupFrequencyDays.present) {
      map['backup_frequency_days'] = Variable<int>(backupFrequencyDays.value);
    }
    if (maxBackupCount.present) {
      map['max_backup_count'] = Variable<int>(maxBackupCount.value);
    }
    if (lastBackupAt.present) {
      map['last_backup_at'] = Variable<DateTime>(lastBackupAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfilesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('dayStartHour: $dayStartHour, ')
          ..write('timezoneMode: $timezoneMode, ')
          ..write('fixedTimezone: $fixedTimezone, ')
          ..write('backupEnabled: $backupEnabled, ')
          ..write('backupFrequencyDays: $backupFrequencyDays, ')
          ..write('maxBackupCount: $maxBackupCount, ')
          ..write('lastBackupAt: $lastBackupAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SpheresTable extends Spheres with TableInfo<$SpheresTable, Sphere> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SpheresTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
    'color',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('#9B7EBD'),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    color,
    sortOrder,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'spheres';
  @override
  VerificationContext validateIntegrity(
    Insertable<Sphere> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Sphere map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Sphere(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SpheresTable createAlias(String alias) {
    return $SpheresTable(attachedDatabase, alias);
  }
}

class Sphere extends DataClass implements Insertable<Sphere> {
  final int id;
  final String name;
  final String color;
  final int sortOrder;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Sphere({
    required this.id,
    required this.name,
    required this.color,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['color'] = Variable<String>(color);
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SpheresCompanion toCompanion(bool nullToAbsent) {
    return SpheresCompanion(
      id: Value(id),
      name: Value(name),
      color: Value(color),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Sphere.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Sphere(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      color: serializer.fromJson<String>(json['color']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'color': serializer.toJson<String>(color),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Sphere copyWith({
    int? id,
    String? name,
    String? color,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Sphere(
    id: id ?? this.id,
    name: name ?? this.name,
    color: color ?? this.color,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Sphere copyWithCompanion(SpheresCompanion data) {
    return Sphere(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      color: data.color.present ? data.color.value : this.color,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Sphere(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, color, sortOrder, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Sphere &&
          other.id == this.id &&
          other.name == this.name &&
          other.color == this.color &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SpheresCompanion extends UpdateCompanion<Sphere> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> color;
  final Value<int> sortOrder;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const SpheresCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.color = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  SpheresCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.color = const Value.absent(),
    this.sortOrder = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : name = Value(name),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Sphere> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? color,
    Expression<int>? sortOrder,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (color != null) 'color': color,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  SpheresCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? color,
    Value<int>? sortOrder,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return SpheresCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SpheresCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $TagsTable extends Tags with TableInfo<$TagsTable, Tag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 30,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
    'color',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, color, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<Tag> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tag(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $TagsTable createAlias(String alias) {
    return $TagsTable(attachedDatabase, alias);
  }
}

class Tag extends DataClass implements Insertable<Tag> {
  final int id;
  final String name;
  final String? color;
  final DateTime createdAt;
  const Tag({
    required this.id,
    required this.name,
    this.color,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TagsCompanion toCompanion(bool nullToAbsent) {
    return TagsCompanion(
      id: Value(id),
      name: Value(name),
      color: color == null && nullToAbsent
          ? const Value.absent()
          : Value(color),
      createdAt: Value(createdAt),
    );
  }

  factory Tag.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tag(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      color: serializer.fromJson<String?>(json['color']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'color': serializer.toJson<String?>(color),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Tag copyWith({
    int? id,
    String? name,
    Value<String?> color = const Value.absent(),
    DateTime? createdAt,
  }) => Tag(
    id: id ?? this.id,
    name: name ?? this.name,
    color: color.present ? color.value : this.color,
    createdAt: createdAt ?? this.createdAt,
  );
  Tag copyWithCompanion(TagsCompanion data) {
    return Tag(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      color: data.color.present ? data.color.value : this.color,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tag(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, color, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tag &&
          other.id == this.id &&
          other.name == this.name &&
          other.color == this.color &&
          other.createdAt == this.createdAt);
}

class TagsCompanion extends UpdateCompanion<Tag> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> color;
  final Value<DateTime> createdAt;
  const TagsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.color = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  TagsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.color = const Value.absent(),
    required DateTime createdAt,
  }) : name = Value(name),
       createdAt = Value(createdAt);
  static Insertable<Tag> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? color,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (color != null) 'color': color,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  TagsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? color,
    Value<DateTime>? createdAt,
  }) {
    return TagsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $HabitsTable extends Habits with TableInfo<$HabitsTable, Habit> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sphereIdMeta = const VerificationMeta(
    'sphereId',
  );
  @override
  late final GeneratedColumn<int> sphereId = GeneratedColumn<int>(
    'sphere_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES spheres (id)',
    ),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('binary'),
  );
  static const VerificationMeta _targetValueMeta = const VerificationMeta(
    'targetValue',
  );
  @override
  late final GeneratedColumn<int> targetValue = GeneratedColumn<int>(
    'target_value',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _minValueMeta = const VerificationMeta(
    'minValue',
  );
  @override
  late final GeneratedColumn<int> minValue = GeneratedColumn<int>(
    'min_value',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _energyRequiredMeta = const VerificationMeta(
    'energyRequired',
  );
  @override
  late final GeneratedColumn<int> energyRequired = GeneratedColumn<int>(
    'energy_required',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(2),
  );
  static const VerificationMeta _goalPerWeekMeta = const VerificationMeta(
    'goalPerWeek',
  );
  @override
  late final GeneratedColumn<int> goalPerWeek = GeneratedColumn<int>(
    'goal_per_week',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(7),
  );
  static const VerificationMeta _archivedMeta = const VerificationMeta(
    'archived',
  );
  @override
  late final GeneratedColumn<bool> archived = GeneratedColumn<bool>(
    'archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    sphereId,
    type,
    targetValue,
    minValue,
    unit,
    priority,
    energyRequired,
    goalPerWeek,
    archived,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habits';
  @override
  VerificationContext validateIntegrity(
    Insertable<Habit> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('sphere_id')) {
      context.handle(
        _sphereIdMeta,
        sphereId.isAcceptableOrUnknown(data['sphere_id']!, _sphereIdMeta),
      );
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    }
    if (data.containsKey('target_value')) {
      context.handle(
        _targetValueMeta,
        targetValue.isAcceptableOrUnknown(
          data['target_value']!,
          _targetValueMeta,
        ),
      );
    }
    if (data.containsKey('min_value')) {
      context.handle(
        _minValueMeta,
        minValue.isAcceptableOrUnknown(data['min_value']!, _minValueMeta),
      );
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    }
    if (data.containsKey('energy_required')) {
      context.handle(
        _energyRequiredMeta,
        energyRequired.isAcceptableOrUnknown(
          data['energy_required']!,
          _energyRequiredMeta,
        ),
      );
    }
    if (data.containsKey('goal_per_week')) {
      context.handle(
        _goalPerWeekMeta,
        goalPerWeek.isAcceptableOrUnknown(
          data['goal_per_week']!,
          _goalPerWeekMeta,
        ),
      );
    }
    if (data.containsKey('archived')) {
      context.handle(
        _archivedMeta,
        archived.isAcceptableOrUnknown(data['archived']!, _archivedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Habit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Habit(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      sphereId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sphere_id'],
      ),
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      targetValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_value'],
      )!,
      minValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}min_value'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      ),
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority'],
      )!,
      energyRequired: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}energy_required'],
      )!,
      goalPerWeek: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}goal_per_week'],
      )!,
      archived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}archived'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $HabitsTable createAlias(String alias) {
    return $HabitsTable(attachedDatabase, alias);
  }
}

class Habit extends DataClass implements Insertable<Habit> {
  final int id;
  final String name;
  final String? description;
  final int? sphereId;
  final String type;
  final int targetValue;
  final int minValue;
  final String? unit;
  final int priority;
  final int energyRequired;
  final int goalPerWeek;
  final bool archived;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Habit({
    required this.id,
    required this.name,
    this.description,
    this.sphereId,
    required this.type,
    required this.targetValue,
    required this.minValue,
    this.unit,
    required this.priority,
    required this.energyRequired,
    required this.goalPerWeek,
    required this.archived,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || sphereId != null) {
      map['sphere_id'] = Variable<int>(sphereId);
    }
    map['type'] = Variable<String>(type);
    map['target_value'] = Variable<int>(targetValue);
    map['min_value'] = Variable<int>(minValue);
    if (!nullToAbsent || unit != null) {
      map['unit'] = Variable<String>(unit);
    }
    map['priority'] = Variable<int>(priority);
    map['energy_required'] = Variable<int>(energyRequired);
    map['goal_per_week'] = Variable<int>(goalPerWeek);
    map['archived'] = Variable<bool>(archived);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  HabitsCompanion toCompanion(bool nullToAbsent) {
    return HabitsCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      sphereId: sphereId == null && nullToAbsent
          ? const Value.absent()
          : Value(sphereId),
      type: Value(type),
      targetValue: Value(targetValue),
      minValue: Value(minValue),
      unit: unit == null && nullToAbsent ? const Value.absent() : Value(unit),
      priority: Value(priority),
      energyRequired: Value(energyRequired),
      goalPerWeek: Value(goalPerWeek),
      archived: Value(archived),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Habit.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Habit(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      sphereId: serializer.fromJson<int?>(json['sphereId']),
      type: serializer.fromJson<String>(json['type']),
      targetValue: serializer.fromJson<int>(json['targetValue']),
      minValue: serializer.fromJson<int>(json['minValue']),
      unit: serializer.fromJson<String?>(json['unit']),
      priority: serializer.fromJson<int>(json['priority']),
      energyRequired: serializer.fromJson<int>(json['energyRequired']),
      goalPerWeek: serializer.fromJson<int>(json['goalPerWeek']),
      archived: serializer.fromJson<bool>(json['archived']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'sphereId': serializer.toJson<int?>(sphereId),
      'type': serializer.toJson<String>(type),
      'targetValue': serializer.toJson<int>(targetValue),
      'minValue': serializer.toJson<int>(minValue),
      'unit': serializer.toJson<String?>(unit),
      'priority': serializer.toJson<int>(priority),
      'energyRequired': serializer.toJson<int>(energyRequired),
      'goalPerWeek': serializer.toJson<int>(goalPerWeek),
      'archived': serializer.toJson<bool>(archived),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Habit copyWith({
    int? id,
    String? name,
    Value<String?> description = const Value.absent(),
    Value<int?> sphereId = const Value.absent(),
    String? type,
    int? targetValue,
    int? minValue,
    Value<String?> unit = const Value.absent(),
    int? priority,
    int? energyRequired,
    int? goalPerWeek,
    bool? archived,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Habit(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    sphereId: sphereId.present ? sphereId.value : this.sphereId,
    type: type ?? this.type,
    targetValue: targetValue ?? this.targetValue,
    minValue: minValue ?? this.minValue,
    unit: unit.present ? unit.value : this.unit,
    priority: priority ?? this.priority,
    energyRequired: energyRequired ?? this.energyRequired,
    goalPerWeek: goalPerWeek ?? this.goalPerWeek,
    archived: archived ?? this.archived,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Habit copyWithCompanion(HabitsCompanion data) {
    return Habit(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      sphereId: data.sphereId.present ? data.sphereId.value : this.sphereId,
      type: data.type.present ? data.type.value : this.type,
      targetValue: data.targetValue.present
          ? data.targetValue.value
          : this.targetValue,
      minValue: data.minValue.present ? data.minValue.value : this.minValue,
      unit: data.unit.present ? data.unit.value : this.unit,
      priority: data.priority.present ? data.priority.value : this.priority,
      energyRequired: data.energyRequired.present
          ? data.energyRequired.value
          : this.energyRequired,
      goalPerWeek: data.goalPerWeek.present
          ? data.goalPerWeek.value
          : this.goalPerWeek,
      archived: data.archived.present ? data.archived.value : this.archived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Habit(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('sphereId: $sphereId, ')
          ..write('type: $type, ')
          ..write('targetValue: $targetValue, ')
          ..write('minValue: $minValue, ')
          ..write('unit: $unit, ')
          ..write('priority: $priority, ')
          ..write('energyRequired: $energyRequired, ')
          ..write('goalPerWeek: $goalPerWeek, ')
          ..write('archived: $archived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    description,
    sphereId,
    type,
    targetValue,
    minValue,
    unit,
    priority,
    energyRequired,
    goalPerWeek,
    archived,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Habit &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.sphereId == this.sphereId &&
          other.type == this.type &&
          other.targetValue == this.targetValue &&
          other.minValue == this.minValue &&
          other.unit == this.unit &&
          other.priority == this.priority &&
          other.energyRequired == this.energyRequired &&
          other.goalPerWeek == this.goalPerWeek &&
          other.archived == this.archived &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class HabitsCompanion extends UpdateCompanion<Habit> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<int?> sphereId;
  final Value<String> type;
  final Value<int> targetValue;
  final Value<int> minValue;
  final Value<String?> unit;
  final Value<int> priority;
  final Value<int> energyRequired;
  final Value<int> goalPerWeek;
  final Value<bool> archived;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const HabitsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.sphereId = const Value.absent(),
    this.type = const Value.absent(),
    this.targetValue = const Value.absent(),
    this.minValue = const Value.absent(),
    this.unit = const Value.absent(),
    this.priority = const Value.absent(),
    this.energyRequired = const Value.absent(),
    this.goalPerWeek = const Value.absent(),
    this.archived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  HabitsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.sphereId = const Value.absent(),
    this.type = const Value.absent(),
    this.targetValue = const Value.absent(),
    this.minValue = const Value.absent(),
    this.unit = const Value.absent(),
    this.priority = const Value.absent(),
    this.energyRequired = const Value.absent(),
    this.goalPerWeek = const Value.absent(),
    this.archived = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : name = Value(name),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Habit> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? sphereId,
    Expression<String>? type,
    Expression<int>? targetValue,
    Expression<int>? minValue,
    Expression<String>? unit,
    Expression<int>? priority,
    Expression<int>? energyRequired,
    Expression<int>? goalPerWeek,
    Expression<bool>? archived,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (sphereId != null) 'sphere_id': sphereId,
      if (type != null) 'type': type,
      if (targetValue != null) 'target_value': targetValue,
      if (minValue != null) 'min_value': minValue,
      if (unit != null) 'unit': unit,
      if (priority != null) 'priority': priority,
      if (energyRequired != null) 'energy_required': energyRequired,
      if (goalPerWeek != null) 'goal_per_week': goalPerWeek,
      if (archived != null) 'archived': archived,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  HabitsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<int?>? sphereId,
    Value<String>? type,
    Value<int>? targetValue,
    Value<int>? minValue,
    Value<String?>? unit,
    Value<int>? priority,
    Value<int>? energyRequired,
    Value<int>? goalPerWeek,
    Value<bool>? archived,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return HabitsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      sphereId: sphereId ?? this.sphereId,
      type: type ?? this.type,
      targetValue: targetValue ?? this.targetValue,
      minValue: minValue ?? this.minValue,
      unit: unit ?? this.unit,
      priority: priority ?? this.priority,
      energyRequired: energyRequired ?? this.energyRequired,
      goalPerWeek: goalPerWeek ?? this.goalPerWeek,
      archived: archived ?? this.archived,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (sphereId.present) {
      map['sphere_id'] = Variable<int>(sphereId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (targetValue.present) {
      map['target_value'] = Variable<int>(targetValue.value);
    }
    if (minValue.present) {
      map['min_value'] = Variable<int>(minValue.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (energyRequired.present) {
      map['energy_required'] = Variable<int>(energyRequired.value);
    }
    if (goalPerWeek.present) {
      map['goal_per_week'] = Variable<int>(goalPerWeek.value);
    }
    if (archived.present) {
      map['archived'] = Variable<bool>(archived.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('sphereId: $sphereId, ')
          ..write('type: $type, ')
          ..write('targetValue: $targetValue, ')
          ..write('minValue: $minValue, ')
          ..write('unit: $unit, ')
          ..write('priority: $priority, ')
          ..write('energyRequired: $energyRequired, ')
          ..write('goalPerWeek: $goalPerWeek, ')
          ..write('archived: $archived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $HabitTagsTable extends HabitTags
    with TableInfo<$HabitTagsTable, HabitTag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitTagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _habitIdMeta = const VerificationMeta(
    'habitId',
  );
  @override
  late final GeneratedColumn<int> habitId = GeneratedColumn<int>(
    'habit_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES habits (id)',
    ),
  );
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<int> tagId = GeneratedColumn<int>(
    'tag_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tags (id)',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [habitId, tagId, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habit_tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<HabitTag> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('habit_id')) {
      context.handle(
        _habitIdMeta,
        habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta),
      );
    } else if (isInserting) {
      context.missing(_habitIdMeta);
    }
    if (data.containsKey('tag_id')) {
      context.handle(
        _tagIdMeta,
        tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {habitId, tagId};
  @override
  HabitTag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HabitTag(
      habitId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}habit_id'],
      )!,
      tagId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tag_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $HabitTagsTable createAlias(String alias) {
    return $HabitTagsTable(attachedDatabase, alias);
  }
}

class HabitTag extends DataClass implements Insertable<HabitTag> {
  final int habitId;
  final int tagId;
  final DateTime createdAt;
  const HabitTag({
    required this.habitId,
    required this.tagId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['habit_id'] = Variable<int>(habitId);
    map['tag_id'] = Variable<int>(tagId);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  HabitTagsCompanion toCompanion(bool nullToAbsent) {
    return HabitTagsCompanion(
      habitId: Value(habitId),
      tagId: Value(tagId),
      createdAt: Value(createdAt),
    );
  }

  factory HabitTag.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HabitTag(
      habitId: serializer.fromJson<int>(json['habitId']),
      tagId: serializer.fromJson<int>(json['tagId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'habitId': serializer.toJson<int>(habitId),
      'tagId': serializer.toJson<int>(tagId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  HabitTag copyWith({int? habitId, int? tagId, DateTime? createdAt}) =>
      HabitTag(
        habitId: habitId ?? this.habitId,
        tagId: tagId ?? this.tagId,
        createdAt: createdAt ?? this.createdAt,
      );
  HabitTag copyWithCompanion(HabitTagsCompanion data) {
    return HabitTag(
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      tagId: data.tagId.present ? data.tagId.value : this.tagId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HabitTag(')
          ..write('habitId: $habitId, ')
          ..write('tagId: $tagId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(habitId, tagId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HabitTag &&
          other.habitId == this.habitId &&
          other.tagId == this.tagId &&
          other.createdAt == this.createdAt);
}

class HabitTagsCompanion extends UpdateCompanion<HabitTag> {
  final Value<int> habitId;
  final Value<int> tagId;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const HabitTagsCompanion({
    this.habitId = const Value.absent(),
    this.tagId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HabitTagsCompanion.insert({
    required int habitId,
    required int tagId,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : habitId = Value(habitId),
       tagId = Value(tagId),
       createdAt = Value(createdAt);
  static Insertable<HabitTag> custom({
    Expression<int>? habitId,
    Expression<int>? tagId,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (habitId != null) 'habit_id': habitId,
      if (tagId != null) 'tag_id': tagId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HabitTagsCompanion copyWith({
    Value<int>? habitId,
    Value<int>? tagId,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return HabitTagsCompanion(
      habitId: habitId ?? this.habitId,
      tagId: tagId ?? this.tagId,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (habitId.present) {
      map['habit_id'] = Variable<int>(habitId.value);
    }
    if (tagId.present) {
      map['tag_id'] = Variable<int>(tagId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitTagsCompanion(')
          ..write('habitId: $habitId, ')
          ..write('tagId: $tagId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SkipDaysTable extends SkipDays with TableInfo<$SkipDaysTable, SkipDay> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SkipDaysTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, reason, note, date, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'skip_days';
  @override
  VerificationContext validateIntegrity(
    Insertable<SkipDay> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    } else if (isInserting) {
      context.missing(_reasonMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SkipDay map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SkipDay(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SkipDaysTable createAlias(String alias) {
    return $SkipDaysTable(attachedDatabase, alias);
  }
}

class SkipDay extends DataClass implements Insertable<SkipDay> {
  final int id;
  final String reason;
  final String? note;
  final DateTime date;
  final DateTime createdAt;
  const SkipDay({
    required this.id,
    required this.reason,
    this.note,
    required this.date,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['reason'] = Variable<String>(reason);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['date'] = Variable<DateTime>(date);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SkipDaysCompanion toCompanion(bool nullToAbsent) {
    return SkipDaysCompanion(
      id: Value(id),
      reason: Value(reason),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      date: Value(date),
      createdAt: Value(createdAt),
    );
  }

  factory SkipDay.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SkipDay(
      id: serializer.fromJson<int>(json['id']),
      reason: serializer.fromJson<String>(json['reason']),
      note: serializer.fromJson<String?>(json['note']),
      date: serializer.fromJson<DateTime>(json['date']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'reason': serializer.toJson<String>(reason),
      'note': serializer.toJson<String?>(note),
      'date': serializer.toJson<DateTime>(date),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SkipDay copyWith({
    int? id,
    String? reason,
    Value<String?> note = const Value.absent(),
    DateTime? date,
    DateTime? createdAt,
  }) => SkipDay(
    id: id ?? this.id,
    reason: reason ?? this.reason,
    note: note.present ? note.value : this.note,
    date: date ?? this.date,
    createdAt: createdAt ?? this.createdAt,
  );
  SkipDay copyWithCompanion(SkipDaysCompanion data) {
    return SkipDay(
      id: data.id.present ? data.id.value : this.id,
      reason: data.reason.present ? data.reason.value : this.reason,
      note: data.note.present ? data.note.value : this.note,
      date: data.date.present ? data.date.value : this.date,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SkipDay(')
          ..write('id: $id, ')
          ..write('reason: $reason, ')
          ..write('note: $note, ')
          ..write('date: $date, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, reason, note, date, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SkipDay &&
          other.id == this.id &&
          other.reason == this.reason &&
          other.note == this.note &&
          other.date == this.date &&
          other.createdAt == this.createdAt);
}

class SkipDaysCompanion extends UpdateCompanion<SkipDay> {
  final Value<int> id;
  final Value<String> reason;
  final Value<String?> note;
  final Value<DateTime> date;
  final Value<DateTime> createdAt;
  const SkipDaysCompanion({
    this.id = const Value.absent(),
    this.reason = const Value.absent(),
    this.note = const Value.absent(),
    this.date = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SkipDaysCompanion.insert({
    this.id = const Value.absent(),
    required String reason,
    this.note = const Value.absent(),
    required DateTime date,
    required DateTime createdAt,
  }) : reason = Value(reason),
       date = Value(date),
       createdAt = Value(createdAt);
  static Insertable<SkipDay> custom({
    Expression<int>? id,
    Expression<String>? reason,
    Expression<String>? note,
    Expression<DateTime>? date,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (reason != null) 'reason': reason,
      if (note != null) 'note': note,
      if (date != null) 'date': date,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SkipDaysCompanion copyWith({
    Value<int>? id,
    Value<String>? reason,
    Value<String?>? note,
    Value<DateTime>? date,
    Value<DateTime>? createdAt,
  }) {
    return SkipDaysCompanion(
      id: id ?? this.id,
      reason: reason ?? this.reason,
      note: note ?? this.note,
      date: date ?? this.date,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SkipDaysCompanion(')
          ..write('id: $id, ')
          ..write('reason: $reason, ')
          ..write('note: $note, ')
          ..write('date: $date, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $HabitLogsTable extends HabitLogs
    with TableInfo<$HabitLogsTable, HabitLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _habitIdMeta = const VerificationMeta(
    'habitId',
  );
  @override
  late final GeneratedColumn<int> habitId = GeneratedColumn<int>(
    'habit_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES habits (id)',
    ),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<int> status = GeneratedColumn<int>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actualValueMeta = const VerificationMeta(
    'actualValue',
  );
  @override
  late final GeneratedColumn<int> actualValue = GeneratedColumn<int>(
    'actual_value',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _skipReasonIdMeta = const VerificationMeta(
    'skipReasonId',
  );
  @override
  late final GeneratedColumn<int> skipReasonId = GeneratedColumn<int>(
    'skip_reason_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES skip_days (id)',
    ),
  );
  static const VerificationMeta _energyLevelMeta = const VerificationMeta(
    'energyLevel',
  );
  @override
  late final GeneratedColumn<int> energyLevel = GeneratedColumn<int>(
    'energy_level',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _durationSecondsMeta = const VerificationMeta(
    'durationSeconds',
  );
  @override
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
    'duration_seconds',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    habitId,
    status,
    actualValue,
    skipReasonId,
    energyLevel,
    durationSeconds,
    timestamp,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habit_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<HabitLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('habit_id')) {
      context.handle(
        _habitIdMeta,
        habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta),
      );
    } else if (isInserting) {
      context.missing(_habitIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('actual_value')) {
      context.handle(
        _actualValueMeta,
        actualValue.isAcceptableOrUnknown(
          data['actual_value']!,
          _actualValueMeta,
        ),
      );
    }
    if (data.containsKey('skip_reason_id')) {
      context.handle(
        _skipReasonIdMeta,
        skipReasonId.isAcceptableOrUnknown(
          data['skip_reason_id']!,
          _skipReasonIdMeta,
        ),
      );
    }
    if (data.containsKey('energy_level')) {
      context.handle(
        _energyLevelMeta,
        energyLevel.isAcceptableOrUnknown(
          data['energy_level']!,
          _energyLevelMeta,
        ),
      );
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
        _durationSecondsMeta,
        durationSeconds.isAcceptableOrUnknown(
          data['duration_seconds']!,
          _durationSecondsMeta,
        ),
      );
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HabitLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HabitLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      habitId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}habit_id'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}status'],
      )!,
      actualValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}actual_value'],
      )!,
      skipReasonId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}skip_reason_id'],
      ),
      energyLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}energy_level'],
      ),
      durationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_seconds'],
      ),
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $HabitLogsTable createAlias(String alias) {
    return $HabitLogsTable(attachedDatabase, alias);
  }
}

class HabitLog extends DataClass implements Insertable<HabitLog> {
  final int id;
  final int habitId;
  final int status;
  final int actualValue;
  final int? skipReasonId;
  final int? energyLevel;
  final int? durationSeconds;
  final DateTime timestamp;
  final DateTime createdAt;
  final DateTime updatedAt;
  const HabitLog({
    required this.id,
    required this.habitId,
    required this.status,
    required this.actualValue,
    this.skipReasonId,
    this.energyLevel,
    this.durationSeconds,
    required this.timestamp,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['habit_id'] = Variable<int>(habitId);
    map['status'] = Variable<int>(status);
    map['actual_value'] = Variable<int>(actualValue);
    if (!nullToAbsent || skipReasonId != null) {
      map['skip_reason_id'] = Variable<int>(skipReasonId);
    }
    if (!nullToAbsent || energyLevel != null) {
      map['energy_level'] = Variable<int>(energyLevel);
    }
    if (!nullToAbsent || durationSeconds != null) {
      map['duration_seconds'] = Variable<int>(durationSeconds);
    }
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  HabitLogsCompanion toCompanion(bool nullToAbsent) {
    return HabitLogsCompanion(
      id: Value(id),
      habitId: Value(habitId),
      status: Value(status),
      actualValue: Value(actualValue),
      skipReasonId: skipReasonId == null && nullToAbsent
          ? const Value.absent()
          : Value(skipReasonId),
      energyLevel: energyLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(energyLevel),
      durationSeconds: durationSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(durationSeconds),
      timestamp: Value(timestamp),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory HabitLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HabitLog(
      id: serializer.fromJson<int>(json['id']),
      habitId: serializer.fromJson<int>(json['habitId']),
      status: serializer.fromJson<int>(json['status']),
      actualValue: serializer.fromJson<int>(json['actualValue']),
      skipReasonId: serializer.fromJson<int?>(json['skipReasonId']),
      energyLevel: serializer.fromJson<int?>(json['energyLevel']),
      durationSeconds: serializer.fromJson<int?>(json['durationSeconds']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'habitId': serializer.toJson<int>(habitId),
      'status': serializer.toJson<int>(status),
      'actualValue': serializer.toJson<int>(actualValue),
      'skipReasonId': serializer.toJson<int?>(skipReasonId),
      'energyLevel': serializer.toJson<int?>(energyLevel),
      'durationSeconds': serializer.toJson<int?>(durationSeconds),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  HabitLog copyWith({
    int? id,
    int? habitId,
    int? status,
    int? actualValue,
    Value<int?> skipReasonId = const Value.absent(),
    Value<int?> energyLevel = const Value.absent(),
    Value<int?> durationSeconds = const Value.absent(),
    DateTime? timestamp,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => HabitLog(
    id: id ?? this.id,
    habitId: habitId ?? this.habitId,
    status: status ?? this.status,
    actualValue: actualValue ?? this.actualValue,
    skipReasonId: skipReasonId.present ? skipReasonId.value : this.skipReasonId,
    energyLevel: energyLevel.present ? energyLevel.value : this.energyLevel,
    durationSeconds: durationSeconds.present
        ? durationSeconds.value
        : this.durationSeconds,
    timestamp: timestamp ?? this.timestamp,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  HabitLog copyWithCompanion(HabitLogsCompanion data) {
    return HabitLog(
      id: data.id.present ? data.id.value : this.id,
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      status: data.status.present ? data.status.value : this.status,
      actualValue: data.actualValue.present
          ? data.actualValue.value
          : this.actualValue,
      skipReasonId: data.skipReasonId.present
          ? data.skipReasonId.value
          : this.skipReasonId,
      energyLevel: data.energyLevel.present
          ? data.energyLevel.value
          : this.energyLevel,
      durationSeconds: data.durationSeconds.present
          ? data.durationSeconds.value
          : this.durationSeconds,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HabitLog(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('status: $status, ')
          ..write('actualValue: $actualValue, ')
          ..write('skipReasonId: $skipReasonId, ')
          ..write('energyLevel: $energyLevel, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('timestamp: $timestamp, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    habitId,
    status,
    actualValue,
    skipReasonId,
    energyLevel,
    durationSeconds,
    timestamp,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HabitLog &&
          other.id == this.id &&
          other.habitId == this.habitId &&
          other.status == this.status &&
          other.actualValue == this.actualValue &&
          other.skipReasonId == this.skipReasonId &&
          other.energyLevel == this.energyLevel &&
          other.durationSeconds == this.durationSeconds &&
          other.timestamp == this.timestamp &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class HabitLogsCompanion extends UpdateCompanion<HabitLog> {
  final Value<int> id;
  final Value<int> habitId;
  final Value<int> status;
  final Value<int> actualValue;
  final Value<int?> skipReasonId;
  final Value<int?> energyLevel;
  final Value<int?> durationSeconds;
  final Value<DateTime> timestamp;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const HabitLogsCompanion({
    this.id = const Value.absent(),
    this.habitId = const Value.absent(),
    this.status = const Value.absent(),
    this.actualValue = const Value.absent(),
    this.skipReasonId = const Value.absent(),
    this.energyLevel = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  HabitLogsCompanion.insert({
    this.id = const Value.absent(),
    required int habitId,
    required int status,
    this.actualValue = const Value.absent(),
    this.skipReasonId = const Value.absent(),
    this.energyLevel = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    required DateTime timestamp,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : habitId = Value(habitId),
       status = Value(status),
       timestamp = Value(timestamp),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<HabitLog> custom({
    Expression<int>? id,
    Expression<int>? habitId,
    Expression<int>? status,
    Expression<int>? actualValue,
    Expression<int>? skipReasonId,
    Expression<int>? energyLevel,
    Expression<int>? durationSeconds,
    Expression<DateTime>? timestamp,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (habitId != null) 'habit_id': habitId,
      if (status != null) 'status': status,
      if (actualValue != null) 'actual_value': actualValue,
      if (skipReasonId != null) 'skip_reason_id': skipReasonId,
      if (energyLevel != null) 'energy_level': energyLevel,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
      if (timestamp != null) 'timestamp': timestamp,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  HabitLogsCompanion copyWith({
    Value<int>? id,
    Value<int>? habitId,
    Value<int>? status,
    Value<int>? actualValue,
    Value<int?>? skipReasonId,
    Value<int?>? energyLevel,
    Value<int?>? durationSeconds,
    Value<DateTime>? timestamp,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return HabitLogsCompanion(
      id: id ?? this.id,
      habitId: habitId ?? this.habitId,
      status: status ?? this.status,
      actualValue: actualValue ?? this.actualValue,
      skipReasonId: skipReasonId ?? this.skipReasonId,
      energyLevel: energyLevel ?? this.energyLevel,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      timestamp: timestamp ?? this.timestamp,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (habitId.present) {
      map['habit_id'] = Variable<int>(habitId.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(status.value);
    }
    if (actualValue.present) {
      map['actual_value'] = Variable<int>(actualValue.value);
    }
    if (skipReasonId.present) {
      map['skip_reason_id'] = Variable<int>(skipReasonId.value);
    }
    if (energyLevel.present) {
      map['energy_level'] = Variable<int>(energyLevel.value);
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitLogsCompanion(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('status: $status, ')
          ..write('actualValue: $actualValue, ')
          ..write('skipReasonId: $skipReasonId, ')
          ..write('energyLevel: $energyLevel, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('timestamp: $timestamp, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $EnergyLogsTable extends EnergyLogs
    with TableInfo<$EnergyLogsTable, EnergyLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EnergyLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _energyLevelMeta = const VerificationMeta(
    'energyLevel',
  );
  @override
  late final GeneratedColumn<int> energyLevel = GeneratedColumn<int>(
    'energy_level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    energyLevel,
    note,
    timestamp,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'energy_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<EnergyLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('energy_level')) {
      context.handle(
        _energyLevelMeta,
        energyLevel.isAcceptableOrUnknown(
          data['energy_level']!,
          _energyLevelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_energyLevelMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EnergyLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EnergyLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      energyLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}energy_level'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $EnergyLogsTable createAlias(String alias) {
    return $EnergyLogsTable(attachedDatabase, alias);
  }
}

class EnergyLog extends DataClass implements Insertable<EnergyLog> {
  final int id;
  final int energyLevel;
  final String? note;
  final DateTime timestamp;
  final DateTime createdAt;
  const EnergyLog({
    required this.id,
    required this.energyLevel,
    this.note,
    required this.timestamp,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['energy_level'] = Variable<int>(energyLevel);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  EnergyLogsCompanion toCompanion(bool nullToAbsent) {
    return EnergyLogsCompanion(
      id: Value(id),
      energyLevel: Value(energyLevel),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      timestamp: Value(timestamp),
      createdAt: Value(createdAt),
    );
  }

  factory EnergyLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EnergyLog(
      id: serializer.fromJson<int>(json['id']),
      energyLevel: serializer.fromJson<int>(json['energyLevel']),
      note: serializer.fromJson<String?>(json['note']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'energyLevel': serializer.toJson<int>(energyLevel),
      'note': serializer.toJson<String?>(note),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  EnergyLog copyWith({
    int? id,
    int? energyLevel,
    Value<String?> note = const Value.absent(),
    DateTime? timestamp,
    DateTime? createdAt,
  }) => EnergyLog(
    id: id ?? this.id,
    energyLevel: energyLevel ?? this.energyLevel,
    note: note.present ? note.value : this.note,
    timestamp: timestamp ?? this.timestamp,
    createdAt: createdAt ?? this.createdAt,
  );
  EnergyLog copyWithCompanion(EnergyLogsCompanion data) {
    return EnergyLog(
      id: data.id.present ? data.id.value : this.id,
      energyLevel: data.energyLevel.present
          ? data.energyLevel.value
          : this.energyLevel,
      note: data.note.present ? data.note.value : this.note,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EnergyLog(')
          ..write('id: $id, ')
          ..write('energyLevel: $energyLevel, ')
          ..write('note: $note, ')
          ..write('timestamp: $timestamp, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, energyLevel, note, timestamp, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EnergyLog &&
          other.id == this.id &&
          other.energyLevel == this.energyLevel &&
          other.note == this.note &&
          other.timestamp == this.timestamp &&
          other.createdAt == this.createdAt);
}

class EnergyLogsCompanion extends UpdateCompanion<EnergyLog> {
  final Value<int> id;
  final Value<int> energyLevel;
  final Value<String?> note;
  final Value<DateTime> timestamp;
  final Value<DateTime> createdAt;
  const EnergyLogsCompanion({
    this.id = const Value.absent(),
    this.energyLevel = const Value.absent(),
    this.note = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  EnergyLogsCompanion.insert({
    this.id = const Value.absent(),
    required int energyLevel,
    this.note = const Value.absent(),
    required DateTime timestamp,
    required DateTime createdAt,
  }) : energyLevel = Value(energyLevel),
       timestamp = Value(timestamp),
       createdAt = Value(createdAt);
  static Insertable<EnergyLog> custom({
    Expression<int>? id,
    Expression<int>? energyLevel,
    Expression<String>? note,
    Expression<DateTime>? timestamp,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (energyLevel != null) 'energy_level': energyLevel,
      if (note != null) 'note': note,
      if (timestamp != null) 'timestamp': timestamp,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  EnergyLogsCompanion copyWith({
    Value<int>? id,
    Value<int>? energyLevel,
    Value<String?>? note,
    Value<DateTime>? timestamp,
    Value<DateTime>? createdAt,
  }) {
    return EnergyLogsCompanion(
      id: id ?? this.id,
      energyLevel: energyLevel ?? this.energyLevel,
      note: note ?? this.note,
      timestamp: timestamp ?? this.timestamp,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (energyLevel.present) {
      map['energy_level'] = Variable<int>(energyLevel.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EnergyLogsCompanion(')
          ..write('id: $id, ')
          ..write('energyLevel: $energyLevel, ')
          ..write('note: $note, ')
          ..write('timestamp: $timestamp, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $VisualRewardsConfigsTable extends VisualRewardsConfigs
    with TableInfo<$VisualRewardsConfigsTable, VisualRewardConfig> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VisualRewardsConfigsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _seasonThemeMeta = const VerificationMeta(
    'seasonTheme',
  );
  @override
  late final GeneratedColumn<String> seasonTheme = GeneratedColumn<String>(
    'season_theme',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('spring'),
  );
  static const VerificationMeta _seedMeta = const VerificationMeta('seed');
  @override
  late final GeneratedColumn<int> seed = GeneratedColumn<int>(
    'seed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _aggregateLevelMeta = const VerificationMeta(
    'aggregateLevel',
  );
  @override
  late final GeneratedColumn<int> aggregateLevel = GeneratedColumn<int>(
    'aggregate_level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _seasonStartAtMeta = const VerificationMeta(
    'seasonStartAt',
  );
  @override
  late final GeneratedColumn<DateTime> seasonStartAt =
      GeneratedColumn<DateTime>(
        'season_start_at',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    seasonTheme,
    seed,
    aggregateLevel,
    seasonStartAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'visual_rewards_configs';
  @override
  VerificationContext validateIntegrity(
    Insertable<VisualRewardConfig> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('season_theme')) {
      context.handle(
        _seasonThemeMeta,
        seasonTheme.isAcceptableOrUnknown(
          data['season_theme']!,
          _seasonThemeMeta,
        ),
      );
    }
    if (data.containsKey('seed')) {
      context.handle(
        _seedMeta,
        seed.isAcceptableOrUnknown(data['seed']!, _seedMeta),
      );
    } else if (isInserting) {
      context.missing(_seedMeta);
    }
    if (data.containsKey('aggregate_level')) {
      context.handle(
        _aggregateLevelMeta,
        aggregateLevel.isAcceptableOrUnknown(
          data['aggregate_level']!,
          _aggregateLevelMeta,
        ),
      );
    }
    if (data.containsKey('season_start_at')) {
      context.handle(
        _seasonStartAtMeta,
        seasonStartAt.isAcceptableOrUnknown(
          data['season_start_at']!,
          _seasonStartAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_seasonStartAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VisualRewardConfig map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VisualRewardConfig(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      seasonTheme: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}season_theme'],
      )!,
      seed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}seed'],
      )!,
      aggregateLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}aggregate_level'],
      )!,
      seasonStartAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}season_start_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $VisualRewardsConfigsTable createAlias(String alias) {
    return $VisualRewardsConfigsTable(attachedDatabase, alias);
  }
}

class VisualRewardConfig extends DataClass
    implements Insertable<VisualRewardConfig> {
  final int id;
  final String seasonTheme;
  final int seed;
  final int aggregateLevel;
  final DateTime seasonStartAt;
  final DateTime updatedAt;
  const VisualRewardConfig({
    required this.id,
    required this.seasonTheme,
    required this.seed,
    required this.aggregateLevel,
    required this.seasonStartAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['season_theme'] = Variable<String>(seasonTheme);
    map['seed'] = Variable<int>(seed);
    map['aggregate_level'] = Variable<int>(aggregateLevel);
    map['season_start_at'] = Variable<DateTime>(seasonStartAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  VisualRewardsConfigsCompanion toCompanion(bool nullToAbsent) {
    return VisualRewardsConfigsCompanion(
      id: Value(id),
      seasonTheme: Value(seasonTheme),
      seed: Value(seed),
      aggregateLevel: Value(aggregateLevel),
      seasonStartAt: Value(seasonStartAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory VisualRewardConfig.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VisualRewardConfig(
      id: serializer.fromJson<int>(json['id']),
      seasonTheme: serializer.fromJson<String>(json['seasonTheme']),
      seed: serializer.fromJson<int>(json['seed']),
      aggregateLevel: serializer.fromJson<int>(json['aggregateLevel']),
      seasonStartAt: serializer.fromJson<DateTime>(json['seasonStartAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'seasonTheme': serializer.toJson<String>(seasonTheme),
      'seed': serializer.toJson<int>(seed),
      'aggregateLevel': serializer.toJson<int>(aggregateLevel),
      'seasonStartAt': serializer.toJson<DateTime>(seasonStartAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  VisualRewardConfig copyWith({
    int? id,
    String? seasonTheme,
    int? seed,
    int? aggregateLevel,
    DateTime? seasonStartAt,
    DateTime? updatedAt,
  }) => VisualRewardConfig(
    id: id ?? this.id,
    seasonTheme: seasonTheme ?? this.seasonTheme,
    seed: seed ?? this.seed,
    aggregateLevel: aggregateLevel ?? this.aggregateLevel,
    seasonStartAt: seasonStartAt ?? this.seasonStartAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  VisualRewardConfig copyWithCompanion(VisualRewardsConfigsCompanion data) {
    return VisualRewardConfig(
      id: data.id.present ? data.id.value : this.id,
      seasonTheme: data.seasonTheme.present
          ? data.seasonTheme.value
          : this.seasonTheme,
      seed: data.seed.present ? data.seed.value : this.seed,
      aggregateLevel: data.aggregateLevel.present
          ? data.aggregateLevel.value
          : this.aggregateLevel,
      seasonStartAt: data.seasonStartAt.present
          ? data.seasonStartAt.value
          : this.seasonStartAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VisualRewardConfig(')
          ..write('id: $id, ')
          ..write('seasonTheme: $seasonTheme, ')
          ..write('seed: $seed, ')
          ..write('aggregateLevel: $aggregateLevel, ')
          ..write('seasonStartAt: $seasonStartAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    seasonTheme,
    seed,
    aggregateLevel,
    seasonStartAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VisualRewardConfig &&
          other.id == this.id &&
          other.seasonTheme == this.seasonTheme &&
          other.seed == this.seed &&
          other.aggregateLevel == this.aggregateLevel &&
          other.seasonStartAt == this.seasonStartAt &&
          other.updatedAt == this.updatedAt);
}

class VisualRewardsConfigsCompanion
    extends UpdateCompanion<VisualRewardConfig> {
  final Value<int> id;
  final Value<String> seasonTheme;
  final Value<int> seed;
  final Value<int> aggregateLevel;
  final Value<DateTime> seasonStartAt;
  final Value<DateTime> updatedAt;
  const VisualRewardsConfigsCompanion({
    this.id = const Value.absent(),
    this.seasonTheme = const Value.absent(),
    this.seed = const Value.absent(),
    this.aggregateLevel = const Value.absent(),
    this.seasonStartAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  VisualRewardsConfigsCompanion.insert({
    this.id = const Value.absent(),
    this.seasonTheme = const Value.absent(),
    required int seed,
    this.aggregateLevel = const Value.absent(),
    required DateTime seasonStartAt,
    required DateTime updatedAt,
  }) : seed = Value(seed),
       seasonStartAt = Value(seasonStartAt),
       updatedAt = Value(updatedAt);
  static Insertable<VisualRewardConfig> custom({
    Expression<int>? id,
    Expression<String>? seasonTheme,
    Expression<int>? seed,
    Expression<int>? aggregateLevel,
    Expression<DateTime>? seasonStartAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (seasonTheme != null) 'season_theme': seasonTheme,
      if (seed != null) 'seed': seed,
      if (aggregateLevel != null) 'aggregate_level': aggregateLevel,
      if (seasonStartAt != null) 'season_start_at': seasonStartAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  VisualRewardsConfigsCompanion copyWith({
    Value<int>? id,
    Value<String>? seasonTheme,
    Value<int>? seed,
    Value<int>? aggregateLevel,
    Value<DateTime>? seasonStartAt,
    Value<DateTime>? updatedAt,
  }) {
    return VisualRewardsConfigsCompanion(
      id: id ?? this.id,
      seasonTheme: seasonTheme ?? this.seasonTheme,
      seed: seed ?? this.seed,
      aggregateLevel: aggregateLevel ?? this.aggregateLevel,
      seasonStartAt: seasonStartAt ?? this.seasonStartAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (seasonTheme.present) {
      map['season_theme'] = Variable<String>(seasonTheme.value);
    }
    if (seed.present) {
      map['seed'] = Variable<int>(seed.value);
    }
    if (aggregateLevel.present) {
      map['aggregate_level'] = Variable<int>(aggregateLevel.value);
    }
    if (seasonStartAt.present) {
      map['season_start_at'] = Variable<DateTime>(seasonStartAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VisualRewardsConfigsCompanion(')
          ..write('id: $id, ')
          ..write('seasonTheme: $seasonTheme, ')
          ..write('seed: $seed, ')
          ..write('aggregateLevel: $aggregateLevel, ')
          ..write('seasonStartAt: $seasonStartAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $BackupRecordsTable extends BackupRecords
    with TableInfo<$BackupRecordsTable, BackupRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BackupRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _filePathMeta = const VerificationMeta(
    'filePath',
  );
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
    'file_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fileHashMeta = const VerificationMeta(
    'fileHash',
  );
  @override
  late final GeneratedColumn<String> fileHash = GeneratedColumn<String>(
    'file_hash',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fileSizeBytesMeta = const VerificationMeta(
    'fileSizeBytes',
  );
  @override
  late final GeneratedColumn<int> fileSizeBytes = GeneratedColumn<int>(
    'file_size_bytes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    filePath,
    fileHash,
    fileSizeBytes,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'backup_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<BackupRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('file_path')) {
      context.handle(
        _filePathMeta,
        filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta),
      );
    } else if (isInserting) {
      context.missing(_filePathMeta);
    }
    if (data.containsKey('file_hash')) {
      context.handle(
        _fileHashMeta,
        fileHash.isAcceptableOrUnknown(data['file_hash']!, _fileHashMeta),
      );
    }
    if (data.containsKey('file_size_bytes')) {
      context.handle(
        _fileSizeBytesMeta,
        fileSizeBytes.isAcceptableOrUnknown(
          data['file_size_bytes']!,
          _fileSizeBytesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fileSizeBytesMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BackupRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BackupRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      filePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_path'],
      )!,
      fileHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_hash'],
      ),
      fileSizeBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}file_size_bytes'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $BackupRecordsTable createAlias(String alias) {
    return $BackupRecordsTable(attachedDatabase, alias);
  }
}

class BackupRecord extends DataClass implements Insertable<BackupRecord> {
  final int id;
  final String filePath;
  final String? fileHash;
  final int fileSizeBytes;
  final DateTime createdAt;
  const BackupRecord({
    required this.id,
    required this.filePath,
    this.fileHash,
    required this.fileSizeBytes,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['file_path'] = Variable<String>(filePath);
    if (!nullToAbsent || fileHash != null) {
      map['file_hash'] = Variable<String>(fileHash);
    }
    map['file_size_bytes'] = Variable<int>(fileSizeBytes);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  BackupRecordsCompanion toCompanion(bool nullToAbsent) {
    return BackupRecordsCompanion(
      id: Value(id),
      filePath: Value(filePath),
      fileHash: fileHash == null && nullToAbsent
          ? const Value.absent()
          : Value(fileHash),
      fileSizeBytes: Value(fileSizeBytes),
      createdAt: Value(createdAt),
    );
  }

  factory BackupRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BackupRecord(
      id: serializer.fromJson<int>(json['id']),
      filePath: serializer.fromJson<String>(json['filePath']),
      fileHash: serializer.fromJson<String?>(json['fileHash']),
      fileSizeBytes: serializer.fromJson<int>(json['fileSizeBytes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'filePath': serializer.toJson<String>(filePath),
      'fileHash': serializer.toJson<String?>(fileHash),
      'fileSizeBytes': serializer.toJson<int>(fileSizeBytes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  BackupRecord copyWith({
    int? id,
    String? filePath,
    Value<String?> fileHash = const Value.absent(),
    int? fileSizeBytes,
    DateTime? createdAt,
  }) => BackupRecord(
    id: id ?? this.id,
    filePath: filePath ?? this.filePath,
    fileHash: fileHash.present ? fileHash.value : this.fileHash,
    fileSizeBytes: fileSizeBytes ?? this.fileSizeBytes,
    createdAt: createdAt ?? this.createdAt,
  );
  BackupRecord copyWithCompanion(BackupRecordsCompanion data) {
    return BackupRecord(
      id: data.id.present ? data.id.value : this.id,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      fileHash: data.fileHash.present ? data.fileHash.value : this.fileHash,
      fileSizeBytes: data.fileSizeBytes.present
          ? data.fileSizeBytes.value
          : this.fileSizeBytes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BackupRecord(')
          ..write('id: $id, ')
          ..write('filePath: $filePath, ')
          ..write('fileHash: $fileHash, ')
          ..write('fileSizeBytes: $fileSizeBytes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, filePath, fileHash, fileSizeBytes, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BackupRecord &&
          other.id == this.id &&
          other.filePath == this.filePath &&
          other.fileHash == this.fileHash &&
          other.fileSizeBytes == this.fileSizeBytes &&
          other.createdAt == this.createdAt);
}

class BackupRecordsCompanion extends UpdateCompanion<BackupRecord> {
  final Value<int> id;
  final Value<String> filePath;
  final Value<String?> fileHash;
  final Value<int> fileSizeBytes;
  final Value<DateTime> createdAt;
  const BackupRecordsCompanion({
    this.id = const Value.absent(),
    this.filePath = const Value.absent(),
    this.fileHash = const Value.absent(),
    this.fileSizeBytes = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  BackupRecordsCompanion.insert({
    this.id = const Value.absent(),
    required String filePath,
    this.fileHash = const Value.absent(),
    required int fileSizeBytes,
    required DateTime createdAt,
  }) : filePath = Value(filePath),
       fileSizeBytes = Value(fileSizeBytes),
       createdAt = Value(createdAt);
  static Insertable<BackupRecord> custom({
    Expression<int>? id,
    Expression<String>? filePath,
    Expression<String>? fileHash,
    Expression<int>? fileSizeBytes,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (filePath != null) 'file_path': filePath,
      if (fileHash != null) 'file_hash': fileHash,
      if (fileSizeBytes != null) 'file_size_bytes': fileSizeBytes,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  BackupRecordsCompanion copyWith({
    Value<int>? id,
    Value<String>? filePath,
    Value<String?>? fileHash,
    Value<int>? fileSizeBytes,
    Value<DateTime>? createdAt,
  }) {
    return BackupRecordsCompanion(
      id: id ?? this.id,
      filePath: filePath ?? this.filePath,
      fileHash: fileHash ?? this.fileHash,
      fileSizeBytes: fileSizeBytes ?? this.fileSizeBytes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (fileHash.present) {
      map['file_hash'] = Variable<String>(fileHash.value);
    }
    if (fileSizeBytes.present) {
      map['file_size_bytes'] = Variable<int>(fileSizeBytes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BackupRecordsCompanion(')
          ..write('id: $id, ')
          ..write('filePath: $filePath, ')
          ..write('fileHash: $fileHash, ')
          ..write('fileSizeBytes: $fileSizeBytes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $SleepLogsTable extends SleepLogs
    with TableInfo<$SleepLogsTable, SleepLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SleepLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _bedtimeMeta = const VerificationMeta(
    'bedtime',
  );
  @override
  late final GeneratedColumn<DateTime> bedtime = GeneratedColumn<DateTime>(
    'bedtime',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wakeTimeMeta = const VerificationMeta(
    'wakeTime',
  );
  @override
  late final GeneratedColumn<DateTime> wakeTime = GeneratedColumn<DateTime>(
    'wake_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMinutesMeta = const VerificationMeta(
    'durationMinutes',
  );
  @override
  late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>(
    'duration_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _qualityScoreMeta = const VerificationMeta(
    'qualityScore',
  );
  @override
  late final GeneratedColumn<int> qualityScore = GeneratedColumn<int>(
    'quality_score',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('manual'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    bedtime,
    wakeTime,
    durationMinutes,
    qualityScore,
    source,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sleep_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<SleepLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('bedtime')) {
      context.handle(
        _bedtimeMeta,
        bedtime.isAcceptableOrUnknown(data['bedtime']!, _bedtimeMeta),
      );
    } else if (isInserting) {
      context.missing(_bedtimeMeta);
    }
    if (data.containsKey('wake_time')) {
      context.handle(
        _wakeTimeMeta,
        wakeTime.isAcceptableOrUnknown(data['wake_time']!, _wakeTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_wakeTimeMeta);
    }
    if (data.containsKey('duration_minutes')) {
      context.handle(
        _durationMinutesMeta,
        durationMinutes.isAcceptableOrUnknown(
          data['duration_minutes']!,
          _durationMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationMinutesMeta);
    }
    if (data.containsKey('quality_score')) {
      context.handle(
        _qualityScoreMeta,
        qualityScore.isAcceptableOrUnknown(
          data['quality_score']!,
          _qualityScoreMeta,
        ),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SleepLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SleepLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      bedtime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}bedtime'],
      )!,
      wakeTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}wake_time'],
      )!,
      durationMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_minutes'],
      )!,
      qualityScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quality_score'],
      ),
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SleepLogsTable createAlias(String alias) {
    return $SleepLogsTable(attachedDatabase, alias);
  }
}

class SleepLog extends DataClass implements Insertable<SleepLog> {
  final int id;
  final DateTime bedtime;
  final DateTime wakeTime;
  final int durationMinutes;
  final int? qualityScore;
  final String source;
  final DateTime createdAt;
  const SleepLog({
    required this.id,
    required this.bedtime,
    required this.wakeTime,
    required this.durationMinutes,
    this.qualityScore,
    required this.source,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['bedtime'] = Variable<DateTime>(bedtime);
    map['wake_time'] = Variable<DateTime>(wakeTime);
    map['duration_minutes'] = Variable<int>(durationMinutes);
    if (!nullToAbsent || qualityScore != null) {
      map['quality_score'] = Variable<int>(qualityScore);
    }
    map['source'] = Variable<String>(source);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SleepLogsCompanion toCompanion(bool nullToAbsent) {
    return SleepLogsCompanion(
      id: Value(id),
      bedtime: Value(bedtime),
      wakeTime: Value(wakeTime),
      durationMinutes: Value(durationMinutes),
      qualityScore: qualityScore == null && nullToAbsent
          ? const Value.absent()
          : Value(qualityScore),
      source: Value(source),
      createdAt: Value(createdAt),
    );
  }

  factory SleepLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SleepLog(
      id: serializer.fromJson<int>(json['id']),
      bedtime: serializer.fromJson<DateTime>(json['bedtime']),
      wakeTime: serializer.fromJson<DateTime>(json['wakeTime']),
      durationMinutes: serializer.fromJson<int>(json['durationMinutes']),
      qualityScore: serializer.fromJson<int?>(json['qualityScore']),
      source: serializer.fromJson<String>(json['source']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bedtime': serializer.toJson<DateTime>(bedtime),
      'wakeTime': serializer.toJson<DateTime>(wakeTime),
      'durationMinutes': serializer.toJson<int>(durationMinutes),
      'qualityScore': serializer.toJson<int?>(qualityScore),
      'source': serializer.toJson<String>(source),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SleepLog copyWith({
    int? id,
    DateTime? bedtime,
    DateTime? wakeTime,
    int? durationMinutes,
    Value<int?> qualityScore = const Value.absent(),
    String? source,
    DateTime? createdAt,
  }) => SleepLog(
    id: id ?? this.id,
    bedtime: bedtime ?? this.bedtime,
    wakeTime: wakeTime ?? this.wakeTime,
    durationMinutes: durationMinutes ?? this.durationMinutes,
    qualityScore: qualityScore.present ? qualityScore.value : this.qualityScore,
    source: source ?? this.source,
    createdAt: createdAt ?? this.createdAt,
  );
  SleepLog copyWithCompanion(SleepLogsCompanion data) {
    return SleepLog(
      id: data.id.present ? data.id.value : this.id,
      bedtime: data.bedtime.present ? data.bedtime.value : this.bedtime,
      wakeTime: data.wakeTime.present ? data.wakeTime.value : this.wakeTime,
      durationMinutes: data.durationMinutes.present
          ? data.durationMinutes.value
          : this.durationMinutes,
      qualityScore: data.qualityScore.present
          ? data.qualityScore.value
          : this.qualityScore,
      source: data.source.present ? data.source.value : this.source,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SleepLog(')
          ..write('id: $id, ')
          ..write('bedtime: $bedtime, ')
          ..write('wakeTime: $wakeTime, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('qualityScore: $qualityScore, ')
          ..write('source: $source, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    bedtime,
    wakeTime,
    durationMinutes,
    qualityScore,
    source,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SleepLog &&
          other.id == this.id &&
          other.bedtime == this.bedtime &&
          other.wakeTime == this.wakeTime &&
          other.durationMinutes == this.durationMinutes &&
          other.qualityScore == this.qualityScore &&
          other.source == this.source &&
          other.createdAt == this.createdAt);
}

class SleepLogsCompanion extends UpdateCompanion<SleepLog> {
  final Value<int> id;
  final Value<DateTime> bedtime;
  final Value<DateTime> wakeTime;
  final Value<int> durationMinutes;
  final Value<int?> qualityScore;
  final Value<String> source;
  final Value<DateTime> createdAt;
  const SleepLogsCompanion({
    this.id = const Value.absent(),
    this.bedtime = const Value.absent(),
    this.wakeTime = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.qualityScore = const Value.absent(),
    this.source = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SleepLogsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime bedtime,
    required DateTime wakeTime,
    required int durationMinutes,
    this.qualityScore = const Value.absent(),
    this.source = const Value.absent(),
    required DateTime createdAt,
  }) : bedtime = Value(bedtime),
       wakeTime = Value(wakeTime),
       durationMinutes = Value(durationMinutes),
       createdAt = Value(createdAt);
  static Insertable<SleepLog> custom({
    Expression<int>? id,
    Expression<DateTime>? bedtime,
    Expression<DateTime>? wakeTime,
    Expression<int>? durationMinutes,
    Expression<int>? qualityScore,
    Expression<String>? source,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bedtime != null) 'bedtime': bedtime,
      if (wakeTime != null) 'wake_time': wakeTime,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (qualityScore != null) 'quality_score': qualityScore,
      if (source != null) 'source': source,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SleepLogsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? bedtime,
    Value<DateTime>? wakeTime,
    Value<int>? durationMinutes,
    Value<int?>? qualityScore,
    Value<String>? source,
    Value<DateTime>? createdAt,
  }) {
    return SleepLogsCompanion(
      id: id ?? this.id,
      bedtime: bedtime ?? this.bedtime,
      wakeTime: wakeTime ?? this.wakeTime,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      qualityScore: qualityScore ?? this.qualityScore,
      source: source ?? this.source,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bedtime.present) {
      map['bedtime'] = Variable<DateTime>(bedtime.value);
    }
    if (wakeTime.present) {
      map['wake_time'] = Variable<DateTime>(wakeTime.value);
    }
    if (durationMinutes.present) {
      map['duration_minutes'] = Variable<int>(durationMinutes.value);
    }
    if (qualityScore.present) {
      map['quality_score'] = Variable<int>(qualityScore.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SleepLogsCompanion(')
          ..write('id: $id, ')
          ..write('bedtime: $bedtime, ')
          ..write('wakeTime: $wakeTime, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('qualityScore: $qualityScore, ')
          ..write('source: $source, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $HabitTemplatesTable extends HabitTemplates
    with TableInfo<$HabitTemplatesTable, HabitTemplate> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitTemplatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isPresetMeta = const VerificationMeta(
    'isPreset',
  );
  @override
  late final GeneratedColumn<bool> isPreset = GeneratedColumn<bool>(
    'is_preset',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_preset" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    category,
    description,
    isPreset,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habit_templates';
  @override
  VerificationContext validateIntegrity(
    Insertable<HabitTemplate> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('is_preset')) {
      context.handle(
        _isPresetMeta,
        isPreset.isAcceptableOrUnknown(data['is_preset']!, _isPresetMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HabitTemplate map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HabitTemplate(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      isPreset: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_preset'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $HabitTemplatesTable createAlias(String alias) {
    return $HabitTemplatesTable(attachedDatabase, alias);
  }
}

class HabitTemplate extends DataClass implements Insertable<HabitTemplate> {
  final int id;
  final String name;
  final String? category;
  final String? description;
  final bool isPreset;
  final DateTime createdAt;
  const HabitTemplate({
    required this.id,
    required this.name,
    this.category,
    this.description,
    required this.isPreset,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['is_preset'] = Variable<bool>(isPreset);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  HabitTemplatesCompanion toCompanion(bool nullToAbsent) {
    return HabitTemplatesCompanion(
      id: Value(id),
      name: Value(name),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      isPreset: Value(isPreset),
      createdAt: Value(createdAt),
    );
  }

  factory HabitTemplate.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HabitTemplate(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String?>(json['category']),
      description: serializer.fromJson<String?>(json['description']),
      isPreset: serializer.fromJson<bool>(json['isPreset']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String?>(category),
      'description': serializer.toJson<String?>(description),
      'isPreset': serializer.toJson<bool>(isPreset),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  HabitTemplate copyWith({
    int? id,
    String? name,
    Value<String?> category = const Value.absent(),
    Value<String?> description = const Value.absent(),
    bool? isPreset,
    DateTime? createdAt,
  }) => HabitTemplate(
    id: id ?? this.id,
    name: name ?? this.name,
    category: category.present ? category.value : this.category,
    description: description.present ? description.value : this.description,
    isPreset: isPreset ?? this.isPreset,
    createdAt: createdAt ?? this.createdAt,
  );
  HabitTemplate copyWithCompanion(HabitTemplatesCompanion data) {
    return HabitTemplate(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      description: data.description.present
          ? data.description.value
          : this.description,
      isPreset: data.isPreset.present ? data.isPreset.value : this.isPreset,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HabitTemplate(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('description: $description, ')
          ..write('isPreset: $isPreset, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, category, description, isPreset, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HabitTemplate &&
          other.id == this.id &&
          other.name == this.name &&
          other.category == this.category &&
          other.description == this.description &&
          other.isPreset == this.isPreset &&
          other.createdAt == this.createdAt);
}

class HabitTemplatesCompanion extends UpdateCompanion<HabitTemplate> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> category;
  final Value<String?> description;
  final Value<bool> isPreset;
  final Value<DateTime> createdAt;
  const HabitTemplatesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.description = const Value.absent(),
    this.isPreset = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  HabitTemplatesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.category = const Value.absent(),
    this.description = const Value.absent(),
    this.isPreset = const Value.absent(),
    required DateTime createdAt,
  }) : name = Value(name),
       createdAt = Value(createdAt);
  static Insertable<HabitTemplate> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? category,
    Expression<String>? description,
    Expression<bool>? isPreset,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (description != null) 'description': description,
      if (isPreset != null) 'is_preset': isPreset,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  HabitTemplatesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? category,
    Value<String?>? description,
    Value<bool>? isPreset,
    Value<DateTime>? createdAt,
  }) {
    return HabitTemplatesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      description: description ?? this.description,
      isPreset: isPreset ?? this.isPreset,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (isPreset.present) {
      map['is_preset'] = Variable<bool>(isPreset.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitTemplatesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('description: $description, ')
          ..write('isPreset: $isPreset, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $HabitTemplateItemsTable extends HabitTemplateItems
    with TableInfo<$HabitTemplateItemsTable, HabitTemplateItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitTemplateItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _templateIdMeta = const VerificationMeta(
    'templateId',
  );
  @override
  late final GeneratedColumn<int> templateId = GeneratedColumn<int>(
    'template_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES habit_templates (id)',
    ),
  );
  static const VerificationMeta _habitNameMeta = const VerificationMeta(
    'habitName',
  );
  @override
  late final GeneratedColumn<String> habitName = GeneratedColumn<String>(
    'habit_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _habitTypeMeta = const VerificationMeta(
    'habitType',
  );
  @override
  late final GeneratedColumn<String> habitType = GeneratedColumn<String>(
    'habit_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('binary'),
  );
  static const VerificationMeta _targetValueMeta = const VerificationMeta(
    'targetValue',
  );
  @override
  late final GeneratedColumn<int> targetValue = GeneratedColumn<int>(
    'target_value',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _minValueMeta = const VerificationMeta(
    'minValue',
  );
  @override
  late final GeneratedColumn<int> minValue = GeneratedColumn<int>(
    'min_value',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sphereIdMeta = const VerificationMeta(
    'sphereId',
  );
  @override
  late final GeneratedColumn<int> sphereId = GeneratedColumn<int>(
    'sphere_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _energyRequiredMeta = const VerificationMeta(
    'energyRequired',
  );
  @override
  late final GeneratedColumn<int> energyRequired = GeneratedColumn<int>(
    'energy_required',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(2),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    templateId,
    habitName,
    habitType,
    targetValue,
    minValue,
    unit,
    sphereId,
    priority,
    energyRequired,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habit_template_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<HabitTemplateItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('template_id')) {
      context.handle(
        _templateIdMeta,
        templateId.isAcceptableOrUnknown(data['template_id']!, _templateIdMeta),
      );
    } else if (isInserting) {
      context.missing(_templateIdMeta);
    }
    if (data.containsKey('habit_name')) {
      context.handle(
        _habitNameMeta,
        habitName.isAcceptableOrUnknown(data['habit_name']!, _habitNameMeta),
      );
    } else if (isInserting) {
      context.missing(_habitNameMeta);
    }
    if (data.containsKey('habit_type')) {
      context.handle(
        _habitTypeMeta,
        habitType.isAcceptableOrUnknown(data['habit_type']!, _habitTypeMeta),
      );
    }
    if (data.containsKey('target_value')) {
      context.handle(
        _targetValueMeta,
        targetValue.isAcceptableOrUnknown(
          data['target_value']!,
          _targetValueMeta,
        ),
      );
    }
    if (data.containsKey('min_value')) {
      context.handle(
        _minValueMeta,
        minValue.isAcceptableOrUnknown(data['min_value']!, _minValueMeta),
      );
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    }
    if (data.containsKey('sphere_id')) {
      context.handle(
        _sphereIdMeta,
        sphereId.isAcceptableOrUnknown(data['sphere_id']!, _sphereIdMeta),
      );
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    }
    if (data.containsKey('energy_required')) {
      context.handle(
        _energyRequiredMeta,
        energyRequired.isAcceptableOrUnknown(
          data['energy_required']!,
          _energyRequiredMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HabitTemplateItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HabitTemplateItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      templateId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}template_id'],
      )!,
      habitName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}habit_name'],
      )!,
      habitType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}habit_type'],
      )!,
      targetValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_value'],
      )!,
      minValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}min_value'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      ),
      sphereId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sphere_id'],
      ),
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority'],
      )!,
      energyRequired: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}energy_required'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $HabitTemplateItemsTable createAlias(String alias) {
    return $HabitTemplateItemsTable(attachedDatabase, alias);
  }
}

class HabitTemplateItem extends DataClass
    implements Insertable<HabitTemplateItem> {
  final int id;
  final int templateId;
  final String habitName;
  final String habitType;
  final int targetValue;
  final int minValue;
  final String? unit;
  final int? sphereId;
  final int priority;
  final int energyRequired;
  final DateTime createdAt;
  const HabitTemplateItem({
    required this.id,
    required this.templateId,
    required this.habitName,
    required this.habitType,
    required this.targetValue,
    required this.minValue,
    this.unit,
    this.sphereId,
    required this.priority,
    required this.energyRequired,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['template_id'] = Variable<int>(templateId);
    map['habit_name'] = Variable<String>(habitName);
    map['habit_type'] = Variable<String>(habitType);
    map['target_value'] = Variable<int>(targetValue);
    map['min_value'] = Variable<int>(minValue);
    if (!nullToAbsent || unit != null) {
      map['unit'] = Variable<String>(unit);
    }
    if (!nullToAbsent || sphereId != null) {
      map['sphere_id'] = Variable<int>(sphereId);
    }
    map['priority'] = Variable<int>(priority);
    map['energy_required'] = Variable<int>(energyRequired);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  HabitTemplateItemsCompanion toCompanion(bool nullToAbsent) {
    return HabitTemplateItemsCompanion(
      id: Value(id),
      templateId: Value(templateId),
      habitName: Value(habitName),
      habitType: Value(habitType),
      targetValue: Value(targetValue),
      minValue: Value(minValue),
      unit: unit == null && nullToAbsent ? const Value.absent() : Value(unit),
      sphereId: sphereId == null && nullToAbsent
          ? const Value.absent()
          : Value(sphereId),
      priority: Value(priority),
      energyRequired: Value(energyRequired),
      createdAt: Value(createdAt),
    );
  }

  factory HabitTemplateItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HabitTemplateItem(
      id: serializer.fromJson<int>(json['id']),
      templateId: serializer.fromJson<int>(json['templateId']),
      habitName: serializer.fromJson<String>(json['habitName']),
      habitType: serializer.fromJson<String>(json['habitType']),
      targetValue: serializer.fromJson<int>(json['targetValue']),
      minValue: serializer.fromJson<int>(json['minValue']),
      unit: serializer.fromJson<String?>(json['unit']),
      sphereId: serializer.fromJson<int?>(json['sphereId']),
      priority: serializer.fromJson<int>(json['priority']),
      energyRequired: serializer.fromJson<int>(json['energyRequired']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'templateId': serializer.toJson<int>(templateId),
      'habitName': serializer.toJson<String>(habitName),
      'habitType': serializer.toJson<String>(habitType),
      'targetValue': serializer.toJson<int>(targetValue),
      'minValue': serializer.toJson<int>(minValue),
      'unit': serializer.toJson<String?>(unit),
      'sphereId': serializer.toJson<int?>(sphereId),
      'priority': serializer.toJson<int>(priority),
      'energyRequired': serializer.toJson<int>(energyRequired),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  HabitTemplateItem copyWith({
    int? id,
    int? templateId,
    String? habitName,
    String? habitType,
    int? targetValue,
    int? minValue,
    Value<String?> unit = const Value.absent(),
    Value<int?> sphereId = const Value.absent(),
    int? priority,
    int? energyRequired,
    DateTime? createdAt,
  }) => HabitTemplateItem(
    id: id ?? this.id,
    templateId: templateId ?? this.templateId,
    habitName: habitName ?? this.habitName,
    habitType: habitType ?? this.habitType,
    targetValue: targetValue ?? this.targetValue,
    minValue: minValue ?? this.minValue,
    unit: unit.present ? unit.value : this.unit,
    sphereId: sphereId.present ? sphereId.value : this.sphereId,
    priority: priority ?? this.priority,
    energyRequired: energyRequired ?? this.energyRequired,
    createdAt: createdAt ?? this.createdAt,
  );
  HabitTemplateItem copyWithCompanion(HabitTemplateItemsCompanion data) {
    return HabitTemplateItem(
      id: data.id.present ? data.id.value : this.id,
      templateId: data.templateId.present
          ? data.templateId.value
          : this.templateId,
      habitName: data.habitName.present ? data.habitName.value : this.habitName,
      habitType: data.habitType.present ? data.habitType.value : this.habitType,
      targetValue: data.targetValue.present
          ? data.targetValue.value
          : this.targetValue,
      minValue: data.minValue.present ? data.minValue.value : this.minValue,
      unit: data.unit.present ? data.unit.value : this.unit,
      sphereId: data.sphereId.present ? data.sphereId.value : this.sphereId,
      priority: data.priority.present ? data.priority.value : this.priority,
      energyRequired: data.energyRequired.present
          ? data.energyRequired.value
          : this.energyRequired,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HabitTemplateItem(')
          ..write('id: $id, ')
          ..write('templateId: $templateId, ')
          ..write('habitName: $habitName, ')
          ..write('habitType: $habitType, ')
          ..write('targetValue: $targetValue, ')
          ..write('minValue: $minValue, ')
          ..write('unit: $unit, ')
          ..write('sphereId: $sphereId, ')
          ..write('priority: $priority, ')
          ..write('energyRequired: $energyRequired, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    templateId,
    habitName,
    habitType,
    targetValue,
    minValue,
    unit,
    sphereId,
    priority,
    energyRequired,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HabitTemplateItem &&
          other.id == this.id &&
          other.templateId == this.templateId &&
          other.habitName == this.habitName &&
          other.habitType == this.habitType &&
          other.targetValue == this.targetValue &&
          other.minValue == this.minValue &&
          other.unit == this.unit &&
          other.sphereId == this.sphereId &&
          other.priority == this.priority &&
          other.energyRequired == this.energyRequired &&
          other.createdAt == this.createdAt);
}

class HabitTemplateItemsCompanion extends UpdateCompanion<HabitTemplateItem> {
  final Value<int> id;
  final Value<int> templateId;
  final Value<String> habitName;
  final Value<String> habitType;
  final Value<int> targetValue;
  final Value<int> minValue;
  final Value<String?> unit;
  final Value<int?> sphereId;
  final Value<int> priority;
  final Value<int> energyRequired;
  final Value<DateTime> createdAt;
  const HabitTemplateItemsCompanion({
    this.id = const Value.absent(),
    this.templateId = const Value.absent(),
    this.habitName = const Value.absent(),
    this.habitType = const Value.absent(),
    this.targetValue = const Value.absent(),
    this.minValue = const Value.absent(),
    this.unit = const Value.absent(),
    this.sphereId = const Value.absent(),
    this.priority = const Value.absent(),
    this.energyRequired = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  HabitTemplateItemsCompanion.insert({
    this.id = const Value.absent(),
    required int templateId,
    required String habitName,
    this.habitType = const Value.absent(),
    this.targetValue = const Value.absent(),
    this.minValue = const Value.absent(),
    this.unit = const Value.absent(),
    this.sphereId = const Value.absent(),
    this.priority = const Value.absent(),
    this.energyRequired = const Value.absent(),
    required DateTime createdAt,
  }) : templateId = Value(templateId),
       habitName = Value(habitName),
       createdAt = Value(createdAt);
  static Insertable<HabitTemplateItem> custom({
    Expression<int>? id,
    Expression<int>? templateId,
    Expression<String>? habitName,
    Expression<String>? habitType,
    Expression<int>? targetValue,
    Expression<int>? minValue,
    Expression<String>? unit,
    Expression<int>? sphereId,
    Expression<int>? priority,
    Expression<int>? energyRequired,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (templateId != null) 'template_id': templateId,
      if (habitName != null) 'habit_name': habitName,
      if (habitType != null) 'habit_type': habitType,
      if (targetValue != null) 'target_value': targetValue,
      if (minValue != null) 'min_value': minValue,
      if (unit != null) 'unit': unit,
      if (sphereId != null) 'sphere_id': sphereId,
      if (priority != null) 'priority': priority,
      if (energyRequired != null) 'energy_required': energyRequired,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  HabitTemplateItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? templateId,
    Value<String>? habitName,
    Value<String>? habitType,
    Value<int>? targetValue,
    Value<int>? minValue,
    Value<String?>? unit,
    Value<int?>? sphereId,
    Value<int>? priority,
    Value<int>? energyRequired,
    Value<DateTime>? createdAt,
  }) {
    return HabitTemplateItemsCompanion(
      id: id ?? this.id,
      templateId: templateId ?? this.templateId,
      habitName: habitName ?? this.habitName,
      habitType: habitType ?? this.habitType,
      targetValue: targetValue ?? this.targetValue,
      minValue: minValue ?? this.minValue,
      unit: unit ?? this.unit,
      sphereId: sphereId ?? this.sphereId,
      priority: priority ?? this.priority,
      energyRequired: energyRequired ?? this.energyRequired,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (templateId.present) {
      map['template_id'] = Variable<int>(templateId.value);
    }
    if (habitName.present) {
      map['habit_name'] = Variable<String>(habitName.value);
    }
    if (habitType.present) {
      map['habit_type'] = Variable<String>(habitType.value);
    }
    if (targetValue.present) {
      map['target_value'] = Variable<int>(targetValue.value);
    }
    if (minValue.present) {
      map['min_value'] = Variable<int>(minValue.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (sphereId.present) {
      map['sphere_id'] = Variable<int>(sphereId.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (energyRequired.present) {
      map['energy_required'] = Variable<int>(energyRequired.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitTemplateItemsCompanion(')
          ..write('id: $id, ')
          ..write('templateId: $templateId, ')
          ..write('habitName: $habitName, ')
          ..write('habitType: $habitType, ')
          ..write('targetValue: $targetValue, ')
          ..write('minValue: $minValue, ')
          ..write('unit: $unit, ')
          ..write('sphereId: $sphereId, ')
          ..write('priority: $priority, ')
          ..write('energyRequired: $energyRequired, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProfilesTable profiles = $ProfilesTable(this);
  late final $SpheresTable spheres = $SpheresTable(this);
  late final $TagsTable tags = $TagsTable(this);
  late final $HabitsTable habits = $HabitsTable(this);
  late final $HabitTagsTable habitTags = $HabitTagsTable(this);
  late final $SkipDaysTable skipDays = $SkipDaysTable(this);
  late final $HabitLogsTable habitLogs = $HabitLogsTable(this);
  late final $EnergyLogsTable energyLogs = $EnergyLogsTable(this);
  late final $VisualRewardsConfigsTable visualRewardsConfigs =
      $VisualRewardsConfigsTable(this);
  late final $BackupRecordsTable backupRecords = $BackupRecordsTable(this);
  late final $SleepLogsTable sleepLogs = $SleepLogsTable(this);
  late final $HabitTemplatesTable habitTemplates = $HabitTemplatesTable(this);
  late final $HabitTemplateItemsTable habitTemplateItems =
      $HabitTemplateItemsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    profiles,
    spheres,
    tags,
    habits,
    habitTags,
    skipDays,
    habitLogs,
    energyLogs,
    visualRewardsConfigs,
    backupRecords,
    sleepLogs,
    habitTemplates,
    habitTemplateItems,
  ];
}

typedef $$ProfilesTableCreateCompanionBuilder =
    ProfilesCompanion Function({
      Value<int> id,
      required String name,
      Value<int> dayStartHour,
      Value<String> timezoneMode,
      Value<String?> fixedTimezone,
      Value<bool> backupEnabled,
      Value<int> backupFrequencyDays,
      Value<int> maxBackupCount,
      Value<DateTime?> lastBackupAt,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$ProfilesTableUpdateCompanionBuilder =
    ProfilesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<int> dayStartHour,
      Value<String> timezoneMode,
      Value<String?> fixedTimezone,
      Value<bool> backupEnabled,
      Value<int> backupFrequencyDays,
      Value<int> maxBackupCount,
      Value<DateTime?> lastBackupAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$ProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dayStartHour => $composableBuilder(
    column: $table.dayStartHour,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timezoneMode => $composableBuilder(
    column: $table.timezoneMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fixedTimezone => $composableBuilder(
    column: $table.fixedTimezone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get backupEnabled => $composableBuilder(
    column: $table.backupEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get backupFrequencyDays => $composableBuilder(
    column: $table.backupFrequencyDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxBackupCount => $composableBuilder(
    column: $table.maxBackupCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastBackupAt => $composableBuilder(
    column: $table.lastBackupAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dayStartHour => $composableBuilder(
    column: $table.dayStartHour,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timezoneMode => $composableBuilder(
    column: $table.timezoneMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fixedTimezone => $composableBuilder(
    column: $table.fixedTimezone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get backupEnabled => $composableBuilder(
    column: $table.backupEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get backupFrequencyDays => $composableBuilder(
    column: $table.backupFrequencyDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxBackupCount => $composableBuilder(
    column: $table.maxBackupCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastBackupAt => $composableBuilder(
    column: $table.lastBackupAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get dayStartHour => $composableBuilder(
    column: $table.dayStartHour,
    builder: (column) => column,
  );

  GeneratedColumn<String> get timezoneMode => $composableBuilder(
    column: $table.timezoneMode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fixedTimezone => $composableBuilder(
    column: $table.fixedTimezone,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get backupEnabled => $composableBuilder(
    column: $table.backupEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<int> get backupFrequencyDays => $composableBuilder(
    column: $table.backupFrequencyDays,
    builder: (column) => column,
  );

  GeneratedColumn<int> get maxBackupCount => $composableBuilder(
    column: $table.maxBackupCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastBackupAt => $composableBuilder(
    column: $table.lastBackupAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProfilesTable,
          Profile,
          $$ProfilesTableFilterComposer,
          $$ProfilesTableOrderingComposer,
          $$ProfilesTableAnnotationComposer,
          $$ProfilesTableCreateCompanionBuilder,
          $$ProfilesTableUpdateCompanionBuilder,
          (Profile, BaseReferences<_$AppDatabase, $ProfilesTable, Profile>),
          Profile,
          PrefetchHooks Function()
        > {
  $$ProfilesTableTableManager(_$AppDatabase db, $ProfilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> dayStartHour = const Value.absent(),
                Value<String> timezoneMode = const Value.absent(),
                Value<String?> fixedTimezone = const Value.absent(),
                Value<bool> backupEnabled = const Value.absent(),
                Value<int> backupFrequencyDays = const Value.absent(),
                Value<int> maxBackupCount = const Value.absent(),
                Value<DateTime?> lastBackupAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ProfilesCompanion(
                id: id,
                name: name,
                dayStartHour: dayStartHour,
                timezoneMode: timezoneMode,
                fixedTimezone: fixedTimezone,
                backupEnabled: backupEnabled,
                backupFrequencyDays: backupFrequencyDays,
                maxBackupCount: maxBackupCount,
                lastBackupAt: lastBackupAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<int> dayStartHour = const Value.absent(),
                Value<String> timezoneMode = const Value.absent(),
                Value<String?> fixedTimezone = const Value.absent(),
                Value<bool> backupEnabled = const Value.absent(),
                Value<int> backupFrequencyDays = const Value.absent(),
                Value<int> maxBackupCount = const Value.absent(),
                Value<DateTime?> lastBackupAt = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => ProfilesCompanion.insert(
                id: id,
                name: name,
                dayStartHour: dayStartHour,
                timezoneMode: timezoneMode,
                fixedTimezone: fixedTimezone,
                backupEnabled: backupEnabled,
                backupFrequencyDays: backupFrequencyDays,
                maxBackupCount: maxBackupCount,
                lastBackupAt: lastBackupAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProfilesTable,
      Profile,
      $$ProfilesTableFilterComposer,
      $$ProfilesTableOrderingComposer,
      $$ProfilesTableAnnotationComposer,
      $$ProfilesTableCreateCompanionBuilder,
      $$ProfilesTableUpdateCompanionBuilder,
      (Profile, BaseReferences<_$AppDatabase, $ProfilesTable, Profile>),
      Profile,
      PrefetchHooks Function()
    >;
typedef $$SpheresTableCreateCompanionBuilder =
    SpheresCompanion Function({
      Value<int> id,
      required String name,
      Value<String> color,
      Value<int> sortOrder,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$SpheresTableUpdateCompanionBuilder =
    SpheresCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> color,
      Value<int> sortOrder,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$SpheresTableReferences
    extends BaseReferences<_$AppDatabase, $SpheresTable, Sphere> {
  $$SpheresTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$HabitsTable, List<Habit>> _habitsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.habits,
    aliasName: $_aliasNameGenerator(db.spheres.id, db.habits.sphereId),
  );

  $$HabitsTableProcessedTableManager get habitsRefs {
    final manager = $$HabitsTableTableManager(
      $_db,
      $_db.habits,
    ).filter((f) => f.sphereId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_habitsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SpheresTableFilterComposer
    extends Composer<_$AppDatabase, $SpheresTable> {
  $$SpheresTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> habitsRefs(
    Expression<bool> Function($$HabitsTableFilterComposer f) f,
  ) {
    final $$HabitsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.sphereId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableFilterComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SpheresTableOrderingComposer
    extends Composer<_$AppDatabase, $SpheresTable> {
  $$SpheresTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SpheresTableAnnotationComposer
    extends Composer<_$AppDatabase, $SpheresTable> {
  $$SpheresTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> habitsRefs<T extends Object>(
    Expression<T> Function($$HabitsTableAnnotationComposer a) f,
  ) {
    final $$HabitsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.sphereId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableAnnotationComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SpheresTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SpheresTable,
          Sphere,
          $$SpheresTableFilterComposer,
          $$SpheresTableOrderingComposer,
          $$SpheresTableAnnotationComposer,
          $$SpheresTableCreateCompanionBuilder,
          $$SpheresTableUpdateCompanionBuilder,
          (Sphere, $$SpheresTableReferences),
          Sphere,
          PrefetchHooks Function({bool habitsRefs})
        > {
  $$SpheresTableTableManager(_$AppDatabase db, $SpheresTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SpheresTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SpheresTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SpheresTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> color = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SpheresCompanion(
                id: id,
                name: name,
                color: color,
                sortOrder: sortOrder,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String> color = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => SpheresCompanion.insert(
                id: id,
                name: name,
                color: color,
                sortOrder: sortOrder,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SpheresTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({habitsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (habitsRefs) db.habits],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (habitsRefs)
                    await $_getPrefetchedData<Sphere, $SpheresTable, Habit>(
                      currentTable: table,
                      referencedTable: $$SpheresTableReferences
                          ._habitsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$SpheresTableReferences(db, table, p0).habitsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.sphereId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SpheresTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SpheresTable,
      Sphere,
      $$SpheresTableFilterComposer,
      $$SpheresTableOrderingComposer,
      $$SpheresTableAnnotationComposer,
      $$SpheresTableCreateCompanionBuilder,
      $$SpheresTableUpdateCompanionBuilder,
      (Sphere, $$SpheresTableReferences),
      Sphere,
      PrefetchHooks Function({bool habitsRefs})
    >;
typedef $$TagsTableCreateCompanionBuilder =
    TagsCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> color,
      required DateTime createdAt,
    });
typedef $$TagsTableUpdateCompanionBuilder =
    TagsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> color,
      Value<DateTime> createdAt,
    });

final class $$TagsTableReferences
    extends BaseReferences<_$AppDatabase, $TagsTable, Tag> {
  $$TagsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$HabitTagsTable, List<HabitTag>>
  _habitTagsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.habitTags,
    aliasName: $_aliasNameGenerator(db.tags.id, db.habitTags.tagId),
  );

  $$HabitTagsTableProcessedTableManager get habitTagsRefs {
    final manager = $$HabitTagsTableTableManager(
      $_db,
      $_db.habitTags,
    ).filter((f) => f.tagId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_habitTagsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TagsTableFilterComposer extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> habitTagsRefs(
    Expression<bool> Function($$HabitTagsTableFilterComposer f) f,
  ) {
    final $$HabitTagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habitTags,
      getReferencedColumn: (t) => t.tagId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitTagsTableFilterComposer(
            $db: $db,
            $table: $db.habitTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TagsTableOrderingComposer extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> habitTagsRefs<T extends Object>(
    Expression<T> Function($$HabitTagsTableAnnotationComposer a) f,
  ) {
    final $$HabitTagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habitTags,
      getReferencedColumn: (t) => t.tagId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitTagsTableAnnotationComposer(
            $db: $db,
            $table: $db.habitTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TagsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TagsTable,
          Tag,
          $$TagsTableFilterComposer,
          $$TagsTableOrderingComposer,
          $$TagsTableAnnotationComposer,
          $$TagsTableCreateCompanionBuilder,
          $$TagsTableUpdateCompanionBuilder,
          (Tag, $$TagsTableReferences),
          Tag,
          PrefetchHooks Function({bool habitTagsRefs})
        > {
  $$TagsTableTableManager(_$AppDatabase db, $TagsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> color = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => TagsCompanion(
                id: id,
                name: name,
                color: color,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> color = const Value.absent(),
                required DateTime createdAt,
              }) => TagsCompanion.insert(
                id: id,
                name: name,
                color: color,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$TagsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({habitTagsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (habitTagsRefs) db.habitTags],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (habitTagsRefs)
                    await $_getPrefetchedData<Tag, $TagsTable, HabitTag>(
                      currentTable: table,
                      referencedTable: $$TagsTableReferences
                          ._habitTagsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$TagsTableReferences(db, table, p0).habitTagsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.tagId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TagsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TagsTable,
      Tag,
      $$TagsTableFilterComposer,
      $$TagsTableOrderingComposer,
      $$TagsTableAnnotationComposer,
      $$TagsTableCreateCompanionBuilder,
      $$TagsTableUpdateCompanionBuilder,
      (Tag, $$TagsTableReferences),
      Tag,
      PrefetchHooks Function({bool habitTagsRefs})
    >;
typedef $$HabitsTableCreateCompanionBuilder =
    HabitsCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> description,
      Value<int?> sphereId,
      Value<String> type,
      Value<int> targetValue,
      Value<int> minValue,
      Value<String?> unit,
      Value<int> priority,
      Value<int> energyRequired,
      Value<int> goalPerWeek,
      Value<bool> archived,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$HabitsTableUpdateCompanionBuilder =
    HabitsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> description,
      Value<int?> sphereId,
      Value<String> type,
      Value<int> targetValue,
      Value<int> minValue,
      Value<String?> unit,
      Value<int> priority,
      Value<int> energyRequired,
      Value<int> goalPerWeek,
      Value<bool> archived,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$HabitsTableReferences
    extends BaseReferences<_$AppDatabase, $HabitsTable, Habit> {
  $$HabitsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SpheresTable _sphereIdTable(_$AppDatabase db) => db.spheres
      .createAlias($_aliasNameGenerator(db.habits.sphereId, db.spheres.id));

  $$SpheresTableProcessedTableManager? get sphereId {
    final $_column = $_itemColumn<int>('sphere_id');
    if ($_column == null) return null;
    final manager = $$SpheresTableTableManager(
      $_db,
      $_db.spheres,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sphereIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$HabitTagsTable, List<HabitTag>>
  _habitTagsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.habitTags,
    aliasName: $_aliasNameGenerator(db.habits.id, db.habitTags.habitId),
  );

  $$HabitTagsTableProcessedTableManager get habitTagsRefs {
    final manager = $$HabitTagsTableTableManager(
      $_db,
      $_db.habitTags,
    ).filter((f) => f.habitId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_habitTagsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$HabitLogsTable, List<HabitLog>>
  _habitLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.habitLogs,
    aliasName: $_aliasNameGenerator(db.habits.id, db.habitLogs.habitId),
  );

  $$HabitLogsTableProcessedTableManager get habitLogsRefs {
    final manager = $$HabitLogsTableTableManager(
      $_db,
      $_db.habitLogs,
    ).filter((f) => f.habitId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_habitLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$HabitsTableFilterComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetValue => $composableBuilder(
    column: $table.targetValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minValue => $composableBuilder(
    column: $table.minValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get energyRequired => $composableBuilder(
    column: $table.energyRequired,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get goalPerWeek => $composableBuilder(
    column: $table.goalPerWeek,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SpheresTableFilterComposer get sphereId {
    final $$SpheresTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sphereId,
      referencedTable: $db.spheres,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpheresTableFilterComposer(
            $db: $db,
            $table: $db.spheres,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> habitTagsRefs(
    Expression<bool> Function($$HabitTagsTableFilterComposer f) f,
  ) {
    final $$HabitTagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habitTags,
      getReferencedColumn: (t) => t.habitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitTagsTableFilterComposer(
            $db: $db,
            $table: $db.habitTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> habitLogsRefs(
    Expression<bool> Function($$HabitLogsTableFilterComposer f) f,
  ) {
    final $$HabitLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habitLogs,
      getReferencedColumn: (t) => t.habitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitLogsTableFilterComposer(
            $db: $db,
            $table: $db.habitLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$HabitsTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetValue => $composableBuilder(
    column: $table.targetValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minValue => $composableBuilder(
    column: $table.minValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get energyRequired => $composableBuilder(
    column: $table.energyRequired,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get goalPerWeek => $composableBuilder(
    column: $table.goalPerWeek,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SpheresTableOrderingComposer get sphereId {
    final $$SpheresTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sphereId,
      referencedTable: $db.spheres,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpheresTableOrderingComposer(
            $db: $db,
            $table: $db.spheres,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get targetValue => $composableBuilder(
    column: $table.targetValue,
    builder: (column) => column,
  );

  GeneratedColumn<int> get minValue =>
      $composableBuilder(column: $table.minValue, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<int> get energyRequired => $composableBuilder(
    column: $table.energyRequired,
    builder: (column) => column,
  );

  GeneratedColumn<int> get goalPerWeek => $composableBuilder(
    column: $table.goalPerWeek,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get archived =>
      $composableBuilder(column: $table.archived, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$SpheresTableAnnotationComposer get sphereId {
    final $$SpheresTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sphereId,
      referencedTable: $db.spheres,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpheresTableAnnotationComposer(
            $db: $db,
            $table: $db.spheres,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> habitTagsRefs<T extends Object>(
    Expression<T> Function($$HabitTagsTableAnnotationComposer a) f,
  ) {
    final $$HabitTagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habitTags,
      getReferencedColumn: (t) => t.habitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitTagsTableAnnotationComposer(
            $db: $db,
            $table: $db.habitTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> habitLogsRefs<T extends Object>(
    Expression<T> Function($$HabitLogsTableAnnotationComposer a) f,
  ) {
    final $$HabitLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habitLogs,
      getReferencedColumn: (t) => t.habitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.habitLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$HabitsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HabitsTable,
          Habit,
          $$HabitsTableFilterComposer,
          $$HabitsTableOrderingComposer,
          $$HabitsTableAnnotationComposer,
          $$HabitsTableCreateCompanionBuilder,
          $$HabitsTableUpdateCompanionBuilder,
          (Habit, $$HabitsTableReferences),
          Habit,
          PrefetchHooks Function({
            bool sphereId,
            bool habitTagsRefs,
            bool habitLogsRefs,
          })
        > {
  $$HabitsTableTableManager(_$AppDatabase db, $HabitsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int?> sphereId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<int> targetValue = const Value.absent(),
                Value<int> minValue = const Value.absent(),
                Value<String?> unit = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<int> energyRequired = const Value.absent(),
                Value<int> goalPerWeek = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => HabitsCompanion(
                id: id,
                name: name,
                description: description,
                sphereId: sphereId,
                type: type,
                targetValue: targetValue,
                minValue: minValue,
                unit: unit,
                priority: priority,
                energyRequired: energyRequired,
                goalPerWeek: goalPerWeek,
                archived: archived,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
                Value<int?> sphereId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<int> targetValue = const Value.absent(),
                Value<int> minValue = const Value.absent(),
                Value<String?> unit = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<int> energyRequired = const Value.absent(),
                Value<int> goalPerWeek = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => HabitsCompanion.insert(
                id: id,
                name: name,
                description: description,
                sphereId: sphereId,
                type: type,
                targetValue: targetValue,
                minValue: minValue,
                unit: unit,
                priority: priority,
                energyRequired: energyRequired,
                goalPerWeek: goalPerWeek,
                archived: archived,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$HabitsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                sphereId = false,
                habitTagsRefs = false,
                habitLogsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (habitTagsRefs) db.habitTags,
                    if (habitLogsRefs) db.habitLogs,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (sphereId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.sphereId,
                                    referencedTable: $$HabitsTableReferences
                                        ._sphereIdTable(db),
                                    referencedColumn: $$HabitsTableReferences
                                        ._sphereIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (habitTagsRefs)
                        await $_getPrefetchedData<
                          Habit,
                          $HabitsTable,
                          HabitTag
                        >(
                          currentTable: table,
                          referencedTable: $$HabitsTableReferences
                              ._habitTagsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HabitsTableReferences(
                                db,
                                table,
                                p0,
                              ).habitTagsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.habitId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (habitLogsRefs)
                        await $_getPrefetchedData<
                          Habit,
                          $HabitsTable,
                          HabitLog
                        >(
                          currentTable: table,
                          referencedTable: $$HabitsTableReferences
                              ._habitLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HabitsTableReferences(
                                db,
                                table,
                                p0,
                              ).habitLogsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.habitId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$HabitsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HabitsTable,
      Habit,
      $$HabitsTableFilterComposer,
      $$HabitsTableOrderingComposer,
      $$HabitsTableAnnotationComposer,
      $$HabitsTableCreateCompanionBuilder,
      $$HabitsTableUpdateCompanionBuilder,
      (Habit, $$HabitsTableReferences),
      Habit,
      PrefetchHooks Function({
        bool sphereId,
        bool habitTagsRefs,
        bool habitLogsRefs,
      })
    >;
typedef $$HabitTagsTableCreateCompanionBuilder =
    HabitTagsCompanion Function({
      required int habitId,
      required int tagId,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$HabitTagsTableUpdateCompanionBuilder =
    HabitTagsCompanion Function({
      Value<int> habitId,
      Value<int> tagId,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$HabitTagsTableReferences
    extends BaseReferences<_$AppDatabase, $HabitTagsTable, HabitTag> {
  $$HabitTagsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $HabitsTable _habitIdTable(_$AppDatabase db) => db.habits.createAlias(
    $_aliasNameGenerator(db.habitTags.habitId, db.habits.id),
  );

  $$HabitsTableProcessedTableManager get habitId {
    final $_column = $_itemColumn<int>('habit_id')!;

    final manager = $$HabitsTableTableManager(
      $_db,
      $_db.habits,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_habitIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TagsTable _tagIdTable(_$AppDatabase db) =>
      db.tags.createAlias($_aliasNameGenerator(db.habitTags.tagId, db.tags.id));

  $$TagsTableProcessedTableManager get tagId {
    final $_column = $_itemColumn<int>('tag_id')!;

    final manager = $$TagsTableTableManager(
      $_db,
      $_db.tags,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tagIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$HabitTagsTableFilterComposer
    extends Composer<_$AppDatabase, $HabitTagsTable> {
  $$HabitTagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$HabitsTableFilterComposer get habitId {
    final $$HabitsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableFilterComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableFilterComposer get tagId {
    final $$TagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableFilterComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitTagsTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitTagsTable> {
  $$HabitTagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$HabitsTableOrderingComposer get habitId {
    final $$HabitsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableOrderingComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableOrderingComposer get tagId {
    final $$TagsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableOrderingComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitTagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitTagsTable> {
  $$HabitTagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$HabitsTableAnnotationComposer get habitId {
    final $$HabitsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableAnnotationComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableAnnotationComposer get tagId {
    final $$TagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableAnnotationComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitTagsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HabitTagsTable,
          HabitTag,
          $$HabitTagsTableFilterComposer,
          $$HabitTagsTableOrderingComposer,
          $$HabitTagsTableAnnotationComposer,
          $$HabitTagsTableCreateCompanionBuilder,
          $$HabitTagsTableUpdateCompanionBuilder,
          (HabitTag, $$HabitTagsTableReferences),
          HabitTag,
          PrefetchHooks Function({bool habitId, bool tagId})
        > {
  $$HabitTagsTableTableManager(_$AppDatabase db, $HabitTagsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitTagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitTagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitTagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> habitId = const Value.absent(),
                Value<int> tagId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HabitTagsCompanion(
                habitId: habitId,
                tagId: tagId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int habitId,
                required int tagId,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => HabitTagsCompanion.insert(
                habitId: habitId,
                tagId: tagId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$HabitTagsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({habitId = false, tagId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (habitId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.habitId,
                                referencedTable: $$HabitTagsTableReferences
                                    ._habitIdTable(db),
                                referencedColumn: $$HabitTagsTableReferences
                                    ._habitIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (tagId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.tagId,
                                referencedTable: $$HabitTagsTableReferences
                                    ._tagIdTable(db),
                                referencedColumn: $$HabitTagsTableReferences
                                    ._tagIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$HabitTagsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HabitTagsTable,
      HabitTag,
      $$HabitTagsTableFilterComposer,
      $$HabitTagsTableOrderingComposer,
      $$HabitTagsTableAnnotationComposer,
      $$HabitTagsTableCreateCompanionBuilder,
      $$HabitTagsTableUpdateCompanionBuilder,
      (HabitTag, $$HabitTagsTableReferences),
      HabitTag,
      PrefetchHooks Function({bool habitId, bool tagId})
    >;
typedef $$SkipDaysTableCreateCompanionBuilder =
    SkipDaysCompanion Function({
      Value<int> id,
      required String reason,
      Value<String?> note,
      required DateTime date,
      required DateTime createdAt,
    });
typedef $$SkipDaysTableUpdateCompanionBuilder =
    SkipDaysCompanion Function({
      Value<int> id,
      Value<String> reason,
      Value<String?> note,
      Value<DateTime> date,
      Value<DateTime> createdAt,
    });

final class $$SkipDaysTableReferences
    extends BaseReferences<_$AppDatabase, $SkipDaysTable, SkipDay> {
  $$SkipDaysTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$HabitLogsTable, List<HabitLog>>
  _habitLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.habitLogs,
    aliasName: $_aliasNameGenerator(db.skipDays.id, db.habitLogs.skipReasonId),
  );

  $$HabitLogsTableProcessedTableManager get habitLogsRefs {
    final manager = $$HabitLogsTableTableManager(
      $_db,
      $_db.habitLogs,
    ).filter((f) => f.skipReasonId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_habitLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SkipDaysTableFilterComposer
    extends Composer<_$AppDatabase, $SkipDaysTable> {
  $$SkipDaysTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> habitLogsRefs(
    Expression<bool> Function($$HabitLogsTableFilterComposer f) f,
  ) {
    final $$HabitLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habitLogs,
      getReferencedColumn: (t) => t.skipReasonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitLogsTableFilterComposer(
            $db: $db,
            $table: $db.habitLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SkipDaysTableOrderingComposer
    extends Composer<_$AppDatabase, $SkipDaysTable> {
  $$SkipDaysTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SkipDaysTableAnnotationComposer
    extends Composer<_$AppDatabase, $SkipDaysTable> {
  $$SkipDaysTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> habitLogsRefs<T extends Object>(
    Expression<T> Function($$HabitLogsTableAnnotationComposer a) f,
  ) {
    final $$HabitLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habitLogs,
      getReferencedColumn: (t) => t.skipReasonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.habitLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SkipDaysTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SkipDaysTable,
          SkipDay,
          $$SkipDaysTableFilterComposer,
          $$SkipDaysTableOrderingComposer,
          $$SkipDaysTableAnnotationComposer,
          $$SkipDaysTableCreateCompanionBuilder,
          $$SkipDaysTableUpdateCompanionBuilder,
          (SkipDay, $$SkipDaysTableReferences),
          SkipDay,
          PrefetchHooks Function({bool habitLogsRefs})
        > {
  $$SkipDaysTableTableManager(_$AppDatabase db, $SkipDaysTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SkipDaysTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SkipDaysTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SkipDaysTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> reason = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SkipDaysCompanion(
                id: id,
                reason: reason,
                note: note,
                date: date,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String reason,
                Value<String?> note = const Value.absent(),
                required DateTime date,
                required DateTime createdAt,
              }) => SkipDaysCompanion.insert(
                id: id,
                reason: reason,
                note: note,
                date: date,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SkipDaysTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({habitLogsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (habitLogsRefs) db.habitLogs],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (habitLogsRefs)
                    await $_getPrefetchedData<
                      SkipDay,
                      $SkipDaysTable,
                      HabitLog
                    >(
                      currentTable: table,
                      referencedTable: $$SkipDaysTableReferences
                          ._habitLogsRefsTable(db),
                      managerFromTypedResult: (p0) => $$SkipDaysTableReferences(
                        db,
                        table,
                        p0,
                      ).habitLogsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.skipReasonId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SkipDaysTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SkipDaysTable,
      SkipDay,
      $$SkipDaysTableFilterComposer,
      $$SkipDaysTableOrderingComposer,
      $$SkipDaysTableAnnotationComposer,
      $$SkipDaysTableCreateCompanionBuilder,
      $$SkipDaysTableUpdateCompanionBuilder,
      (SkipDay, $$SkipDaysTableReferences),
      SkipDay,
      PrefetchHooks Function({bool habitLogsRefs})
    >;
typedef $$HabitLogsTableCreateCompanionBuilder =
    HabitLogsCompanion Function({
      Value<int> id,
      required int habitId,
      required int status,
      Value<int> actualValue,
      Value<int?> skipReasonId,
      Value<int?> energyLevel,
      Value<int?> durationSeconds,
      required DateTime timestamp,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$HabitLogsTableUpdateCompanionBuilder =
    HabitLogsCompanion Function({
      Value<int> id,
      Value<int> habitId,
      Value<int> status,
      Value<int> actualValue,
      Value<int?> skipReasonId,
      Value<int?> energyLevel,
      Value<int?> durationSeconds,
      Value<DateTime> timestamp,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$HabitLogsTableReferences
    extends BaseReferences<_$AppDatabase, $HabitLogsTable, HabitLog> {
  $$HabitLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $HabitsTable _habitIdTable(_$AppDatabase db) => db.habits.createAlias(
    $_aliasNameGenerator(db.habitLogs.habitId, db.habits.id),
  );

  $$HabitsTableProcessedTableManager get habitId {
    final $_column = $_itemColumn<int>('habit_id')!;

    final manager = $$HabitsTableTableManager(
      $_db,
      $_db.habits,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_habitIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SkipDaysTable _skipReasonIdTable(_$AppDatabase db) =>
      db.skipDays.createAlias(
        $_aliasNameGenerator(db.habitLogs.skipReasonId, db.skipDays.id),
      );

  $$SkipDaysTableProcessedTableManager? get skipReasonId {
    final $_column = $_itemColumn<int>('skip_reason_id');
    if ($_column == null) return null;
    final manager = $$SkipDaysTableTableManager(
      $_db,
      $_db.skipDays,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_skipReasonIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$HabitLogsTableFilterComposer
    extends Composer<_$AppDatabase, $HabitLogsTable> {
  $$HabitLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get actualValue => $composableBuilder(
    column: $table.actualValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get energyLevel => $composableBuilder(
    column: $table.energyLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$HabitsTableFilterComposer get habitId {
    final $$HabitsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableFilterComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SkipDaysTableFilterComposer get skipReasonId {
    final $$SkipDaysTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.skipReasonId,
      referencedTable: $db.skipDays,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkipDaysTableFilterComposer(
            $db: $db,
            $table: $db.skipDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitLogsTable> {
  $$HabitLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get actualValue => $composableBuilder(
    column: $table.actualValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get energyLevel => $composableBuilder(
    column: $table.energyLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$HabitsTableOrderingComposer get habitId {
    final $$HabitsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableOrderingComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SkipDaysTableOrderingComposer get skipReasonId {
    final $$SkipDaysTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.skipReasonId,
      referencedTable: $db.skipDays,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkipDaysTableOrderingComposer(
            $db: $db,
            $table: $db.skipDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitLogsTable> {
  $$HabitLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get actualValue => $composableBuilder(
    column: $table.actualValue,
    builder: (column) => column,
  );

  GeneratedColumn<int> get energyLevel => $composableBuilder(
    column: $table.energyLevel,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$HabitsTableAnnotationComposer get habitId {
    final $$HabitsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableAnnotationComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SkipDaysTableAnnotationComposer get skipReasonId {
    final $$SkipDaysTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.skipReasonId,
      referencedTable: $db.skipDays,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkipDaysTableAnnotationComposer(
            $db: $db,
            $table: $db.skipDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HabitLogsTable,
          HabitLog,
          $$HabitLogsTableFilterComposer,
          $$HabitLogsTableOrderingComposer,
          $$HabitLogsTableAnnotationComposer,
          $$HabitLogsTableCreateCompanionBuilder,
          $$HabitLogsTableUpdateCompanionBuilder,
          (HabitLog, $$HabitLogsTableReferences),
          HabitLog,
          PrefetchHooks Function({bool habitId, bool skipReasonId})
        > {
  $$HabitLogsTableTableManager(_$AppDatabase db, $HabitLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> habitId = const Value.absent(),
                Value<int> status = const Value.absent(),
                Value<int> actualValue = const Value.absent(),
                Value<int?> skipReasonId = const Value.absent(),
                Value<int?> energyLevel = const Value.absent(),
                Value<int?> durationSeconds = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => HabitLogsCompanion(
                id: id,
                habitId: habitId,
                status: status,
                actualValue: actualValue,
                skipReasonId: skipReasonId,
                energyLevel: energyLevel,
                durationSeconds: durationSeconds,
                timestamp: timestamp,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int habitId,
                required int status,
                Value<int> actualValue = const Value.absent(),
                Value<int?> skipReasonId = const Value.absent(),
                Value<int?> energyLevel = const Value.absent(),
                Value<int?> durationSeconds = const Value.absent(),
                required DateTime timestamp,
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => HabitLogsCompanion.insert(
                id: id,
                habitId: habitId,
                status: status,
                actualValue: actualValue,
                skipReasonId: skipReasonId,
                energyLevel: energyLevel,
                durationSeconds: durationSeconds,
                timestamp: timestamp,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$HabitLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({habitId = false, skipReasonId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (habitId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.habitId,
                                referencedTable: $$HabitLogsTableReferences
                                    ._habitIdTable(db),
                                referencedColumn: $$HabitLogsTableReferences
                                    ._habitIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (skipReasonId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.skipReasonId,
                                referencedTable: $$HabitLogsTableReferences
                                    ._skipReasonIdTable(db),
                                referencedColumn: $$HabitLogsTableReferences
                                    ._skipReasonIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$HabitLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HabitLogsTable,
      HabitLog,
      $$HabitLogsTableFilterComposer,
      $$HabitLogsTableOrderingComposer,
      $$HabitLogsTableAnnotationComposer,
      $$HabitLogsTableCreateCompanionBuilder,
      $$HabitLogsTableUpdateCompanionBuilder,
      (HabitLog, $$HabitLogsTableReferences),
      HabitLog,
      PrefetchHooks Function({bool habitId, bool skipReasonId})
    >;
typedef $$EnergyLogsTableCreateCompanionBuilder =
    EnergyLogsCompanion Function({
      Value<int> id,
      required int energyLevel,
      Value<String?> note,
      required DateTime timestamp,
      required DateTime createdAt,
    });
typedef $$EnergyLogsTableUpdateCompanionBuilder =
    EnergyLogsCompanion Function({
      Value<int> id,
      Value<int> energyLevel,
      Value<String?> note,
      Value<DateTime> timestamp,
      Value<DateTime> createdAt,
    });

class $$EnergyLogsTableFilterComposer
    extends Composer<_$AppDatabase, $EnergyLogsTable> {
  $$EnergyLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get energyLevel => $composableBuilder(
    column: $table.energyLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EnergyLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $EnergyLogsTable> {
  $$EnergyLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get energyLevel => $composableBuilder(
    column: $table.energyLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EnergyLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EnergyLogsTable> {
  $$EnergyLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get energyLevel => $composableBuilder(
    column: $table.energyLevel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$EnergyLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EnergyLogsTable,
          EnergyLog,
          $$EnergyLogsTableFilterComposer,
          $$EnergyLogsTableOrderingComposer,
          $$EnergyLogsTableAnnotationComposer,
          $$EnergyLogsTableCreateCompanionBuilder,
          $$EnergyLogsTableUpdateCompanionBuilder,
          (
            EnergyLog,
            BaseReferences<_$AppDatabase, $EnergyLogsTable, EnergyLog>,
          ),
          EnergyLog,
          PrefetchHooks Function()
        > {
  $$EnergyLogsTableTableManager(_$AppDatabase db, $EnergyLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EnergyLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EnergyLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EnergyLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> energyLevel = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => EnergyLogsCompanion(
                id: id,
                energyLevel: energyLevel,
                note: note,
                timestamp: timestamp,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int energyLevel,
                Value<String?> note = const Value.absent(),
                required DateTime timestamp,
                required DateTime createdAt,
              }) => EnergyLogsCompanion.insert(
                id: id,
                energyLevel: energyLevel,
                note: note,
                timestamp: timestamp,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EnergyLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EnergyLogsTable,
      EnergyLog,
      $$EnergyLogsTableFilterComposer,
      $$EnergyLogsTableOrderingComposer,
      $$EnergyLogsTableAnnotationComposer,
      $$EnergyLogsTableCreateCompanionBuilder,
      $$EnergyLogsTableUpdateCompanionBuilder,
      (EnergyLog, BaseReferences<_$AppDatabase, $EnergyLogsTable, EnergyLog>),
      EnergyLog,
      PrefetchHooks Function()
    >;
typedef $$VisualRewardsConfigsTableCreateCompanionBuilder =
    VisualRewardsConfigsCompanion Function({
      Value<int> id,
      Value<String> seasonTheme,
      required int seed,
      Value<int> aggregateLevel,
      required DateTime seasonStartAt,
      required DateTime updatedAt,
    });
typedef $$VisualRewardsConfigsTableUpdateCompanionBuilder =
    VisualRewardsConfigsCompanion Function({
      Value<int> id,
      Value<String> seasonTheme,
      Value<int> seed,
      Value<int> aggregateLevel,
      Value<DateTime> seasonStartAt,
      Value<DateTime> updatedAt,
    });

class $$VisualRewardsConfigsTableFilterComposer
    extends Composer<_$AppDatabase, $VisualRewardsConfigsTable> {
  $$VisualRewardsConfigsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get seasonTheme => $composableBuilder(
    column: $table.seasonTheme,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get seed => $composableBuilder(
    column: $table.seed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get aggregateLevel => $composableBuilder(
    column: $table.aggregateLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get seasonStartAt => $composableBuilder(
    column: $table.seasonStartAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$VisualRewardsConfigsTableOrderingComposer
    extends Composer<_$AppDatabase, $VisualRewardsConfigsTable> {
  $$VisualRewardsConfigsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get seasonTheme => $composableBuilder(
    column: $table.seasonTheme,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get seed => $composableBuilder(
    column: $table.seed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get aggregateLevel => $composableBuilder(
    column: $table.aggregateLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get seasonStartAt => $composableBuilder(
    column: $table.seasonStartAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VisualRewardsConfigsTableAnnotationComposer
    extends Composer<_$AppDatabase, $VisualRewardsConfigsTable> {
  $$VisualRewardsConfigsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get seasonTheme => $composableBuilder(
    column: $table.seasonTheme,
    builder: (column) => column,
  );

  GeneratedColumn<int> get seed =>
      $composableBuilder(column: $table.seed, builder: (column) => column);

  GeneratedColumn<int> get aggregateLevel => $composableBuilder(
    column: $table.aggregateLevel,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get seasonStartAt => $composableBuilder(
    column: $table.seasonStartAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$VisualRewardsConfigsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VisualRewardsConfigsTable,
          VisualRewardConfig,
          $$VisualRewardsConfigsTableFilterComposer,
          $$VisualRewardsConfigsTableOrderingComposer,
          $$VisualRewardsConfigsTableAnnotationComposer,
          $$VisualRewardsConfigsTableCreateCompanionBuilder,
          $$VisualRewardsConfigsTableUpdateCompanionBuilder,
          (
            VisualRewardConfig,
            BaseReferences<
              _$AppDatabase,
              $VisualRewardsConfigsTable,
              VisualRewardConfig
            >,
          ),
          VisualRewardConfig,
          PrefetchHooks Function()
        > {
  $$VisualRewardsConfigsTableTableManager(
    _$AppDatabase db,
    $VisualRewardsConfigsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VisualRewardsConfigsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VisualRewardsConfigsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$VisualRewardsConfigsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> seasonTheme = const Value.absent(),
                Value<int> seed = const Value.absent(),
                Value<int> aggregateLevel = const Value.absent(),
                Value<DateTime> seasonStartAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => VisualRewardsConfigsCompanion(
                id: id,
                seasonTheme: seasonTheme,
                seed: seed,
                aggregateLevel: aggregateLevel,
                seasonStartAt: seasonStartAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> seasonTheme = const Value.absent(),
                required int seed,
                Value<int> aggregateLevel = const Value.absent(),
                required DateTime seasonStartAt,
                required DateTime updatedAt,
              }) => VisualRewardsConfigsCompanion.insert(
                id: id,
                seasonTheme: seasonTheme,
                seed: seed,
                aggregateLevel: aggregateLevel,
                seasonStartAt: seasonStartAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$VisualRewardsConfigsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VisualRewardsConfigsTable,
      VisualRewardConfig,
      $$VisualRewardsConfigsTableFilterComposer,
      $$VisualRewardsConfigsTableOrderingComposer,
      $$VisualRewardsConfigsTableAnnotationComposer,
      $$VisualRewardsConfigsTableCreateCompanionBuilder,
      $$VisualRewardsConfigsTableUpdateCompanionBuilder,
      (
        VisualRewardConfig,
        BaseReferences<
          _$AppDatabase,
          $VisualRewardsConfigsTable,
          VisualRewardConfig
        >,
      ),
      VisualRewardConfig,
      PrefetchHooks Function()
    >;
typedef $$BackupRecordsTableCreateCompanionBuilder =
    BackupRecordsCompanion Function({
      Value<int> id,
      required String filePath,
      Value<String?> fileHash,
      required int fileSizeBytes,
      required DateTime createdAt,
    });
typedef $$BackupRecordsTableUpdateCompanionBuilder =
    BackupRecordsCompanion Function({
      Value<int> id,
      Value<String> filePath,
      Value<String?> fileHash,
      Value<int> fileSizeBytes,
      Value<DateTime> createdAt,
    });

class $$BackupRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $BackupRecordsTable> {
  $$BackupRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileHash => $composableBuilder(
    column: $table.fileHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fileSizeBytes => $composableBuilder(
    column: $table.fileSizeBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BackupRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $BackupRecordsTable> {
  $$BackupRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileHash => $composableBuilder(
    column: $table.fileHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fileSizeBytes => $composableBuilder(
    column: $table.fileSizeBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BackupRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BackupRecordsTable> {
  $$BackupRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<String> get fileHash =>
      $composableBuilder(column: $table.fileHash, builder: (column) => column);

  GeneratedColumn<int> get fileSizeBytes => $composableBuilder(
    column: $table.fileSizeBytes,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$BackupRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BackupRecordsTable,
          BackupRecord,
          $$BackupRecordsTableFilterComposer,
          $$BackupRecordsTableOrderingComposer,
          $$BackupRecordsTableAnnotationComposer,
          $$BackupRecordsTableCreateCompanionBuilder,
          $$BackupRecordsTableUpdateCompanionBuilder,
          (
            BackupRecord,
            BaseReferences<_$AppDatabase, $BackupRecordsTable, BackupRecord>,
          ),
          BackupRecord,
          PrefetchHooks Function()
        > {
  $$BackupRecordsTableTableManager(_$AppDatabase db, $BackupRecordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BackupRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BackupRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BackupRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> filePath = const Value.absent(),
                Value<String?> fileHash = const Value.absent(),
                Value<int> fileSizeBytes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => BackupRecordsCompanion(
                id: id,
                filePath: filePath,
                fileHash: fileHash,
                fileSizeBytes: fileSizeBytes,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String filePath,
                Value<String?> fileHash = const Value.absent(),
                required int fileSizeBytes,
                required DateTime createdAt,
              }) => BackupRecordsCompanion.insert(
                id: id,
                filePath: filePath,
                fileHash: fileHash,
                fileSizeBytes: fileSizeBytes,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BackupRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BackupRecordsTable,
      BackupRecord,
      $$BackupRecordsTableFilterComposer,
      $$BackupRecordsTableOrderingComposer,
      $$BackupRecordsTableAnnotationComposer,
      $$BackupRecordsTableCreateCompanionBuilder,
      $$BackupRecordsTableUpdateCompanionBuilder,
      (
        BackupRecord,
        BaseReferences<_$AppDatabase, $BackupRecordsTable, BackupRecord>,
      ),
      BackupRecord,
      PrefetchHooks Function()
    >;
typedef $$SleepLogsTableCreateCompanionBuilder =
    SleepLogsCompanion Function({
      Value<int> id,
      required DateTime bedtime,
      required DateTime wakeTime,
      required int durationMinutes,
      Value<int?> qualityScore,
      Value<String> source,
      required DateTime createdAt,
    });
typedef $$SleepLogsTableUpdateCompanionBuilder =
    SleepLogsCompanion Function({
      Value<int> id,
      Value<DateTime> bedtime,
      Value<DateTime> wakeTime,
      Value<int> durationMinutes,
      Value<int?> qualityScore,
      Value<String> source,
      Value<DateTime> createdAt,
    });

class $$SleepLogsTableFilterComposer
    extends Composer<_$AppDatabase, $SleepLogsTable> {
  $$SleepLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get bedtime => $composableBuilder(
    column: $table.bedtime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get wakeTime => $composableBuilder(
    column: $table.wakeTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get qualityScore => $composableBuilder(
    column: $table.qualityScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SleepLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $SleepLogsTable> {
  $$SleepLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get bedtime => $composableBuilder(
    column: $table.bedtime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get wakeTime => $composableBuilder(
    column: $table.wakeTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get qualityScore => $composableBuilder(
    column: $table.qualityScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SleepLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SleepLogsTable> {
  $$SleepLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get bedtime =>
      $composableBuilder(column: $table.bedtime, builder: (column) => column);

  GeneratedColumn<DateTime> get wakeTime =>
      $composableBuilder(column: $table.wakeTime, builder: (column) => column);

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get qualityScore => $composableBuilder(
    column: $table.qualityScore,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SleepLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SleepLogsTable,
          SleepLog,
          $$SleepLogsTableFilterComposer,
          $$SleepLogsTableOrderingComposer,
          $$SleepLogsTableAnnotationComposer,
          $$SleepLogsTableCreateCompanionBuilder,
          $$SleepLogsTableUpdateCompanionBuilder,
          (SleepLog, BaseReferences<_$AppDatabase, $SleepLogsTable, SleepLog>),
          SleepLog,
          PrefetchHooks Function()
        > {
  $$SleepLogsTableTableManager(_$AppDatabase db, $SleepLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SleepLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SleepLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SleepLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> bedtime = const Value.absent(),
                Value<DateTime> wakeTime = const Value.absent(),
                Value<int> durationMinutes = const Value.absent(),
                Value<int?> qualityScore = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SleepLogsCompanion(
                id: id,
                bedtime: bedtime,
                wakeTime: wakeTime,
                durationMinutes: durationMinutes,
                qualityScore: qualityScore,
                source: source,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime bedtime,
                required DateTime wakeTime,
                required int durationMinutes,
                Value<int?> qualityScore = const Value.absent(),
                Value<String> source = const Value.absent(),
                required DateTime createdAt,
              }) => SleepLogsCompanion.insert(
                id: id,
                bedtime: bedtime,
                wakeTime: wakeTime,
                durationMinutes: durationMinutes,
                qualityScore: qualityScore,
                source: source,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SleepLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SleepLogsTable,
      SleepLog,
      $$SleepLogsTableFilterComposer,
      $$SleepLogsTableOrderingComposer,
      $$SleepLogsTableAnnotationComposer,
      $$SleepLogsTableCreateCompanionBuilder,
      $$SleepLogsTableUpdateCompanionBuilder,
      (SleepLog, BaseReferences<_$AppDatabase, $SleepLogsTable, SleepLog>),
      SleepLog,
      PrefetchHooks Function()
    >;
typedef $$HabitTemplatesTableCreateCompanionBuilder =
    HabitTemplatesCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> category,
      Value<String?> description,
      Value<bool> isPreset,
      required DateTime createdAt,
    });
typedef $$HabitTemplatesTableUpdateCompanionBuilder =
    HabitTemplatesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> category,
      Value<String?> description,
      Value<bool> isPreset,
      Value<DateTime> createdAt,
    });

final class $$HabitTemplatesTableReferences
    extends BaseReferences<_$AppDatabase, $HabitTemplatesTable, HabitTemplate> {
  $$HabitTemplatesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$HabitTemplateItemsTable, List<HabitTemplateItem>>
  _habitTemplateItemsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.habitTemplateItems,
        aliasName: $_aliasNameGenerator(
          db.habitTemplates.id,
          db.habitTemplateItems.templateId,
        ),
      );

  $$HabitTemplateItemsTableProcessedTableManager get habitTemplateItemsRefs {
    final manager = $$HabitTemplateItemsTableTableManager(
      $_db,
      $_db.habitTemplateItems,
    ).filter((f) => f.templateId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _habitTemplateItemsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$HabitTemplatesTableFilterComposer
    extends Composer<_$AppDatabase, $HabitTemplatesTable> {
  $$HabitTemplatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPreset => $composableBuilder(
    column: $table.isPreset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> habitTemplateItemsRefs(
    Expression<bool> Function($$HabitTemplateItemsTableFilterComposer f) f,
  ) {
    final $$HabitTemplateItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habitTemplateItems,
      getReferencedColumn: (t) => t.templateId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitTemplateItemsTableFilterComposer(
            $db: $db,
            $table: $db.habitTemplateItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$HabitTemplatesTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitTemplatesTable> {
  $$HabitTemplatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPreset => $composableBuilder(
    column: $table.isPreset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HabitTemplatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitTemplatesTable> {
  $$HabitTemplatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isPreset =>
      $composableBuilder(column: $table.isPreset, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> habitTemplateItemsRefs<T extends Object>(
    Expression<T> Function($$HabitTemplateItemsTableAnnotationComposer a) f,
  ) {
    final $$HabitTemplateItemsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.habitTemplateItems,
          getReferencedColumn: (t) => t.templateId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$HabitTemplateItemsTableAnnotationComposer(
                $db: $db,
                $table: $db.habitTemplateItems,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$HabitTemplatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HabitTemplatesTable,
          HabitTemplate,
          $$HabitTemplatesTableFilterComposer,
          $$HabitTemplatesTableOrderingComposer,
          $$HabitTemplatesTableAnnotationComposer,
          $$HabitTemplatesTableCreateCompanionBuilder,
          $$HabitTemplatesTableUpdateCompanionBuilder,
          (HabitTemplate, $$HabitTemplatesTableReferences),
          HabitTemplate,
          PrefetchHooks Function({bool habitTemplateItemsRefs})
        > {
  $$HabitTemplatesTableTableManager(
    _$AppDatabase db,
    $HabitTemplatesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitTemplatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitTemplatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitTemplatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<bool> isPreset = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => HabitTemplatesCompanion(
                id: id,
                name: name,
                category: category,
                description: description,
                isPreset: isPreset,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> category = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<bool> isPreset = const Value.absent(),
                required DateTime createdAt,
              }) => HabitTemplatesCompanion.insert(
                id: id,
                name: name,
                category: category,
                description: description,
                isPreset: isPreset,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$HabitTemplatesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({habitTemplateItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (habitTemplateItemsRefs) db.habitTemplateItems,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (habitTemplateItemsRefs)
                    await $_getPrefetchedData<
                      HabitTemplate,
                      $HabitTemplatesTable,
                      HabitTemplateItem
                    >(
                      currentTable: table,
                      referencedTable: $$HabitTemplatesTableReferences
                          ._habitTemplateItemsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$HabitTemplatesTableReferences(
                            db,
                            table,
                            p0,
                          ).habitTemplateItemsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.templateId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$HabitTemplatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HabitTemplatesTable,
      HabitTemplate,
      $$HabitTemplatesTableFilterComposer,
      $$HabitTemplatesTableOrderingComposer,
      $$HabitTemplatesTableAnnotationComposer,
      $$HabitTemplatesTableCreateCompanionBuilder,
      $$HabitTemplatesTableUpdateCompanionBuilder,
      (HabitTemplate, $$HabitTemplatesTableReferences),
      HabitTemplate,
      PrefetchHooks Function({bool habitTemplateItemsRefs})
    >;
typedef $$HabitTemplateItemsTableCreateCompanionBuilder =
    HabitTemplateItemsCompanion Function({
      Value<int> id,
      required int templateId,
      required String habitName,
      Value<String> habitType,
      Value<int> targetValue,
      Value<int> minValue,
      Value<String?> unit,
      Value<int?> sphereId,
      Value<int> priority,
      Value<int> energyRequired,
      required DateTime createdAt,
    });
typedef $$HabitTemplateItemsTableUpdateCompanionBuilder =
    HabitTemplateItemsCompanion Function({
      Value<int> id,
      Value<int> templateId,
      Value<String> habitName,
      Value<String> habitType,
      Value<int> targetValue,
      Value<int> minValue,
      Value<String?> unit,
      Value<int?> sphereId,
      Value<int> priority,
      Value<int> energyRequired,
      Value<DateTime> createdAt,
    });

final class $$HabitTemplateItemsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $HabitTemplateItemsTable,
          HabitTemplateItem
        > {
  $$HabitTemplateItemsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $HabitTemplatesTable _templateIdTable(_$AppDatabase db) =>
      db.habitTemplates.createAlias(
        $_aliasNameGenerator(
          db.habitTemplateItems.templateId,
          db.habitTemplates.id,
        ),
      );

  $$HabitTemplatesTableProcessedTableManager get templateId {
    final $_column = $_itemColumn<int>('template_id')!;

    final manager = $$HabitTemplatesTableTableManager(
      $_db,
      $_db.habitTemplates,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_templateIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$HabitTemplateItemsTableFilterComposer
    extends Composer<_$AppDatabase, $HabitTemplateItemsTable> {
  $$HabitTemplateItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get habitName => $composableBuilder(
    column: $table.habitName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get habitType => $composableBuilder(
    column: $table.habitType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetValue => $composableBuilder(
    column: $table.targetValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minValue => $composableBuilder(
    column: $table.minValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sphereId => $composableBuilder(
    column: $table.sphereId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get energyRequired => $composableBuilder(
    column: $table.energyRequired,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$HabitTemplatesTableFilterComposer get templateId {
    final $$HabitTemplatesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.templateId,
      referencedTable: $db.habitTemplates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitTemplatesTableFilterComposer(
            $db: $db,
            $table: $db.habitTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitTemplateItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitTemplateItemsTable> {
  $$HabitTemplateItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get habitName => $composableBuilder(
    column: $table.habitName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get habitType => $composableBuilder(
    column: $table.habitType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetValue => $composableBuilder(
    column: $table.targetValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minValue => $composableBuilder(
    column: $table.minValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sphereId => $composableBuilder(
    column: $table.sphereId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get energyRequired => $composableBuilder(
    column: $table.energyRequired,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$HabitTemplatesTableOrderingComposer get templateId {
    final $$HabitTemplatesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.templateId,
      referencedTable: $db.habitTemplates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitTemplatesTableOrderingComposer(
            $db: $db,
            $table: $db.habitTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitTemplateItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitTemplateItemsTable> {
  $$HabitTemplateItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get habitName =>
      $composableBuilder(column: $table.habitName, builder: (column) => column);

  GeneratedColumn<String> get habitType =>
      $composableBuilder(column: $table.habitType, builder: (column) => column);

  GeneratedColumn<int> get targetValue => $composableBuilder(
    column: $table.targetValue,
    builder: (column) => column,
  );

  GeneratedColumn<int> get minValue =>
      $composableBuilder(column: $table.minValue, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<int> get sphereId =>
      $composableBuilder(column: $table.sphereId, builder: (column) => column);

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<int> get energyRequired => $composableBuilder(
    column: $table.energyRequired,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$HabitTemplatesTableAnnotationComposer get templateId {
    final $$HabitTemplatesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.templateId,
      referencedTable: $db.habitTemplates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitTemplatesTableAnnotationComposer(
            $db: $db,
            $table: $db.habitTemplates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitTemplateItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HabitTemplateItemsTable,
          HabitTemplateItem,
          $$HabitTemplateItemsTableFilterComposer,
          $$HabitTemplateItemsTableOrderingComposer,
          $$HabitTemplateItemsTableAnnotationComposer,
          $$HabitTemplateItemsTableCreateCompanionBuilder,
          $$HabitTemplateItemsTableUpdateCompanionBuilder,
          (HabitTemplateItem, $$HabitTemplateItemsTableReferences),
          HabitTemplateItem,
          PrefetchHooks Function({bool templateId})
        > {
  $$HabitTemplateItemsTableTableManager(
    _$AppDatabase db,
    $HabitTemplateItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitTemplateItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitTemplateItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitTemplateItemsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> templateId = const Value.absent(),
                Value<String> habitName = const Value.absent(),
                Value<String> habitType = const Value.absent(),
                Value<int> targetValue = const Value.absent(),
                Value<int> minValue = const Value.absent(),
                Value<String?> unit = const Value.absent(),
                Value<int?> sphereId = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<int> energyRequired = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => HabitTemplateItemsCompanion(
                id: id,
                templateId: templateId,
                habitName: habitName,
                habitType: habitType,
                targetValue: targetValue,
                minValue: minValue,
                unit: unit,
                sphereId: sphereId,
                priority: priority,
                energyRequired: energyRequired,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int templateId,
                required String habitName,
                Value<String> habitType = const Value.absent(),
                Value<int> targetValue = const Value.absent(),
                Value<int> minValue = const Value.absent(),
                Value<String?> unit = const Value.absent(),
                Value<int?> sphereId = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<int> energyRequired = const Value.absent(),
                required DateTime createdAt,
              }) => HabitTemplateItemsCompanion.insert(
                id: id,
                templateId: templateId,
                habitName: habitName,
                habitType: habitType,
                targetValue: targetValue,
                minValue: minValue,
                unit: unit,
                sphereId: sphereId,
                priority: priority,
                energyRequired: energyRequired,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$HabitTemplateItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({templateId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (templateId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.templateId,
                                referencedTable:
                                    $$HabitTemplateItemsTableReferences
                                        ._templateIdTable(db),
                                referencedColumn:
                                    $$HabitTemplateItemsTableReferences
                                        ._templateIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$HabitTemplateItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HabitTemplateItemsTable,
      HabitTemplateItem,
      $$HabitTemplateItemsTableFilterComposer,
      $$HabitTemplateItemsTableOrderingComposer,
      $$HabitTemplateItemsTableAnnotationComposer,
      $$HabitTemplateItemsTableCreateCompanionBuilder,
      $$HabitTemplateItemsTableUpdateCompanionBuilder,
      (HabitTemplateItem, $$HabitTemplateItemsTableReferences),
      HabitTemplateItem,
      PrefetchHooks Function({bool templateId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProfilesTableTableManager get profiles =>
      $$ProfilesTableTableManager(_db, _db.profiles);
  $$SpheresTableTableManager get spheres =>
      $$SpheresTableTableManager(_db, _db.spheres);
  $$TagsTableTableManager get tags => $$TagsTableTableManager(_db, _db.tags);
  $$HabitsTableTableManager get habits =>
      $$HabitsTableTableManager(_db, _db.habits);
  $$HabitTagsTableTableManager get habitTags =>
      $$HabitTagsTableTableManager(_db, _db.habitTags);
  $$SkipDaysTableTableManager get skipDays =>
      $$SkipDaysTableTableManager(_db, _db.skipDays);
  $$HabitLogsTableTableManager get habitLogs =>
      $$HabitLogsTableTableManager(_db, _db.habitLogs);
  $$EnergyLogsTableTableManager get energyLogs =>
      $$EnergyLogsTableTableManager(_db, _db.energyLogs);
  $$VisualRewardsConfigsTableTableManager get visualRewardsConfigs =>
      $$VisualRewardsConfigsTableTableManager(_db, _db.visualRewardsConfigs);
  $$BackupRecordsTableTableManager get backupRecords =>
      $$BackupRecordsTableTableManager(_db, _db.backupRecords);
  $$SleepLogsTableTableManager get sleepLogs =>
      $$SleepLogsTableTableManager(_db, _db.sleepLogs);
  $$HabitTemplatesTableTableManager get habitTemplates =>
      $$HabitTemplatesTableTableManager(_db, _db.habitTemplates);
  $$HabitTemplateItemsTableTableManager get habitTemplateItems =>
      $$HabitTemplateItemsTableTableManager(_db, _db.habitTemplateItems);
}
