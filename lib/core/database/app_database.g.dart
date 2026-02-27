// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
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
      maxTextLength: 200,
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
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('general'),
  );
  static const VerificationMeta _seedArchetypeMeta = const VerificationMeta(
    'seedArchetype',
  );
  @override
  late final GeneratedColumn<String> seedArchetype = GeneratedColumn<String>(
    'seed_archetype',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('oak'),
  );
  static const VerificationMeta _frequencyTypeMeta = const VerificationMeta(
    'frequencyType',
  );
  @override
  late final GeneratedColumn<String> frequencyType = GeneratedColumn<String>(
    'frequency_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('daily'),
  );
  static const VerificationMeta _frequencyValueMeta = const VerificationMeta(
    'frequencyValue',
  );
  @override
  late final GeneratedColumn<String> frequencyValue = GeneratedColumn<String>(
    'frequency_value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _timeOfDayMeta = const VerificationMeta(
    'timeOfDay',
  );
  @override
  late final GeneratedColumn<String> timeOfDay = GeneratedColumn<String>(
    'time_of_day',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('anytime'),
  );
  static const VerificationMeta _isFocusMeta = const VerificationMeta(
    'isFocus',
  );
  @override
  late final GeneratedColumn<bool> isFocus = GeneratedColumn<bool>(
    'is_focus',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_focus" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    category,
    seedArchetype,
    frequencyType,
    frequencyValue,
    timeOfDay,
    isFocus,
    isArchived,
    createdAt,
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
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('seed_archetype')) {
      context.handle(
        _seedArchetypeMeta,
        seedArchetype.isAcceptableOrUnknown(
          data['seed_archetype']!,
          _seedArchetypeMeta,
        ),
      );
    }
    if (data.containsKey('frequency_type')) {
      context.handle(
        _frequencyTypeMeta,
        frequencyType.isAcceptableOrUnknown(
          data['frequency_type']!,
          _frequencyTypeMeta,
        ),
      );
    }
    if (data.containsKey('frequency_value')) {
      context.handle(
        _frequencyValueMeta,
        frequencyValue.isAcceptableOrUnknown(
          data['frequency_value']!,
          _frequencyValueMeta,
        ),
      );
    }
    if (data.containsKey('time_of_day')) {
      context.handle(
        _timeOfDayMeta,
        timeOfDay.isAcceptableOrUnknown(data['time_of_day']!, _timeOfDayMeta),
      );
    }
    if (data.containsKey('is_focus')) {
      context.handle(
        _isFocusMeta,
        isFocus.isAcceptableOrUnknown(data['is_focus']!, _isFocusMeta),
      );
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
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
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      seedArchetype: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}seed_archetype'],
      )!,
      frequencyType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}frequency_type'],
      )!,
      frequencyValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}frequency_value'],
      )!,
      timeOfDay: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}time_of_day'],
      )!,
      isFocus: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_focus'],
      )!,
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
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
  final String category;
  final String seedArchetype;
  final String frequencyType;
  final String frequencyValue;
  final String timeOfDay;
  final bool isFocus;
  final bool isArchived;
  final int createdAt;
  const Habit({
    required this.id,
    required this.name,
    required this.category,
    required this.seedArchetype,
    required this.frequencyType,
    required this.frequencyValue,
    required this.timeOfDay,
    required this.isFocus,
    required this.isArchived,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    map['seed_archetype'] = Variable<String>(seedArchetype);
    map['frequency_type'] = Variable<String>(frequencyType);
    map['frequency_value'] = Variable<String>(frequencyValue);
    map['time_of_day'] = Variable<String>(timeOfDay);
    map['is_focus'] = Variable<bool>(isFocus);
    map['is_archived'] = Variable<bool>(isArchived);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  HabitsCompanion toCompanion(bool nullToAbsent) {
    return HabitsCompanion(
      id: Value(id),
      name: Value(name),
      category: Value(category),
      seedArchetype: Value(seedArchetype),
      frequencyType: Value(frequencyType),
      frequencyValue: Value(frequencyValue),
      timeOfDay: Value(timeOfDay),
      isFocus: Value(isFocus),
      isArchived: Value(isArchived),
      createdAt: Value(createdAt),
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
      category: serializer.fromJson<String>(json['category']),
      seedArchetype: serializer.fromJson<String>(json['seedArchetype']),
      frequencyType: serializer.fromJson<String>(json['frequencyType']),
      frequencyValue: serializer.fromJson<String>(json['frequencyValue']),
      timeOfDay: serializer.fromJson<String>(json['timeOfDay']),
      isFocus: serializer.fromJson<bool>(json['isFocus']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'seedArchetype': serializer.toJson<String>(seedArchetype),
      'frequencyType': serializer.toJson<String>(frequencyType),
      'frequencyValue': serializer.toJson<String>(frequencyValue),
      'timeOfDay': serializer.toJson<String>(timeOfDay),
      'isFocus': serializer.toJson<bool>(isFocus),
      'isArchived': serializer.toJson<bool>(isArchived),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  Habit copyWith({
    int? id,
    String? name,
    String? category,
    String? seedArchetype,
    String? frequencyType,
    String? frequencyValue,
    String? timeOfDay,
    bool? isFocus,
    bool? isArchived,
    int? createdAt,
  }) => Habit(
    id: id ?? this.id,
    name: name ?? this.name,
    category: category ?? this.category,
    seedArchetype: seedArchetype ?? this.seedArchetype,
    frequencyType: frequencyType ?? this.frequencyType,
    frequencyValue: frequencyValue ?? this.frequencyValue,
    timeOfDay: timeOfDay ?? this.timeOfDay,
    isFocus: isFocus ?? this.isFocus,
    isArchived: isArchived ?? this.isArchived,
    createdAt: createdAt ?? this.createdAt,
  );
  Habit copyWithCompanion(HabitsCompanion data) {
    return Habit(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      seedArchetype: data.seedArchetype.present
          ? data.seedArchetype.value
          : this.seedArchetype,
      frequencyType: data.frequencyType.present
          ? data.frequencyType.value
          : this.frequencyType,
      frequencyValue: data.frequencyValue.present
          ? data.frequencyValue.value
          : this.frequencyValue,
      timeOfDay: data.timeOfDay.present ? data.timeOfDay.value : this.timeOfDay,
      isFocus: data.isFocus.present ? data.isFocus.value : this.isFocus,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Habit(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('seedArchetype: $seedArchetype, ')
          ..write('frequencyType: $frequencyType, ')
          ..write('frequencyValue: $frequencyValue, ')
          ..write('timeOfDay: $timeOfDay, ')
          ..write('isFocus: $isFocus, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    category,
    seedArchetype,
    frequencyType,
    frequencyValue,
    timeOfDay,
    isFocus,
    isArchived,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Habit &&
          other.id == this.id &&
          other.name == this.name &&
          other.category == this.category &&
          other.seedArchetype == this.seedArchetype &&
          other.frequencyType == this.frequencyType &&
          other.frequencyValue == this.frequencyValue &&
          other.timeOfDay == this.timeOfDay &&
          other.isFocus == this.isFocus &&
          other.isArchived == this.isArchived &&
          other.createdAt == this.createdAt);
}

class HabitsCompanion extends UpdateCompanion<Habit> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> category;
  final Value<String> seedArchetype;
  final Value<String> frequencyType;
  final Value<String> frequencyValue;
  final Value<String> timeOfDay;
  final Value<bool> isFocus;
  final Value<bool> isArchived;
  final Value<int> createdAt;
  const HabitsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.seedArchetype = const Value.absent(),
    this.frequencyType = const Value.absent(),
    this.frequencyValue = const Value.absent(),
    this.timeOfDay = const Value.absent(),
    this.isFocus = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  HabitsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.category = const Value.absent(),
    this.seedArchetype = const Value.absent(),
    this.frequencyType = const Value.absent(),
    this.frequencyValue = const Value.absent(),
    this.timeOfDay = const Value.absent(),
    this.isFocus = const Value.absent(),
    this.isArchived = const Value.absent(),
    required int createdAt,
  }) : name = Value(name),
       createdAt = Value(createdAt);
  static Insertable<Habit> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? category,
    Expression<String>? seedArchetype,
    Expression<String>? frequencyType,
    Expression<String>? frequencyValue,
    Expression<String>? timeOfDay,
    Expression<bool>? isFocus,
    Expression<bool>? isArchived,
    Expression<int>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (seedArchetype != null) 'seed_archetype': seedArchetype,
      if (frequencyType != null) 'frequency_type': frequencyType,
      if (frequencyValue != null) 'frequency_value': frequencyValue,
      if (timeOfDay != null) 'time_of_day': timeOfDay,
      if (isFocus != null) 'is_focus': isFocus,
      if (isArchived != null) 'is_archived': isArchived,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  HabitsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? category,
    Value<String>? seedArchetype,
    Value<String>? frequencyType,
    Value<String>? frequencyValue,
    Value<String>? timeOfDay,
    Value<bool>? isFocus,
    Value<bool>? isArchived,
    Value<int>? createdAt,
  }) {
    return HabitsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      seedArchetype: seedArchetype ?? this.seedArchetype,
      frequencyType: frequencyType ?? this.frequencyType,
      frequencyValue: frequencyValue ?? this.frequencyValue,
      timeOfDay: timeOfDay ?? this.timeOfDay,
      isFocus: isFocus ?? this.isFocus,
      isArchived: isArchived ?? this.isArchived,
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
    if (seedArchetype.present) {
      map['seed_archetype'] = Variable<String>(seedArchetype.value);
    }
    if (frequencyType.present) {
      map['frequency_type'] = Variable<String>(frequencyType.value);
    }
    if (frequencyValue.present) {
      map['frequency_value'] = Variable<String>(frequencyValue.value);
    }
    if (timeOfDay.present) {
      map['time_of_day'] = Variable<String>(timeOfDay.value);
    }
    if (isFocus.present) {
      map['is_focus'] = Variable<bool>(isFocus.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('seedArchetype: $seedArchetype, ')
          ..write('frequencyType: $frequencyType, ')
          ..write('frequencyValue: $frequencyValue, ')
          ..write('timeOfDay: $timeOfDay, ')
          ..write('isFocus: $isFocus, ')
          ..write('isArchived: $isArchived, ')
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
      'REFERENCES habits (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<int> date = GeneratedColumn<int>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _loggedHourMeta = const VerificationMeta(
    'loggedHour',
  );
  @override
  late final GeneratedColumn<int> loggedHour = GeneratedColumn<int>(
    'logged_hour',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, habitId, date, status, loggedHour];
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
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('logged_hour')) {
      context.handle(
        _loggedHourMeta,
        loggedHour.isAcceptableOrUnknown(data['logged_hour']!, _loggedHourMeta),
      );
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
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}date'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      loggedHour: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}logged_hour'],
      ),
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
  final int date;
  final String status;
  final int? loggedHour;
  const HabitLog({
    required this.id,
    required this.habitId,
    required this.date,
    required this.status,
    this.loggedHour,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['habit_id'] = Variable<int>(habitId);
    map['date'] = Variable<int>(date);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || loggedHour != null) {
      map['logged_hour'] = Variable<int>(loggedHour);
    }
    return map;
  }

  HabitLogsCompanion toCompanion(bool nullToAbsent) {
    return HabitLogsCompanion(
      id: Value(id),
      habitId: Value(habitId),
      date: Value(date),
      status: Value(status),
      loggedHour: loggedHour == null && nullToAbsent
          ? const Value.absent()
          : Value(loggedHour),
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
      date: serializer.fromJson<int>(json['date']),
      status: serializer.fromJson<String>(json['status']),
      loggedHour: serializer.fromJson<int?>(json['loggedHour']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'habitId': serializer.toJson<int>(habitId),
      'date': serializer.toJson<int>(date),
      'status': serializer.toJson<String>(status),
      'loggedHour': serializer.toJson<int?>(loggedHour),
    };
  }

  HabitLog copyWith({
    int? id,
    int? habitId,
    int? date,
    String? status,
    Value<int?> loggedHour = const Value.absent(),
  }) => HabitLog(
    id: id ?? this.id,
    habitId: habitId ?? this.habitId,
    date: date ?? this.date,
    status: status ?? this.status,
    loggedHour: loggedHour.present ? loggedHour.value : this.loggedHour,
  );
  HabitLog copyWithCompanion(HabitLogsCompanion data) {
    return HabitLog(
      id: data.id.present ? data.id.value : this.id,
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      date: data.date.present ? data.date.value : this.date,
      status: data.status.present ? data.status.value : this.status,
      loggedHour: data.loggedHour.present
          ? data.loggedHour.value
          : this.loggedHour,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HabitLog(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('date: $date, ')
          ..write('status: $status, ')
          ..write('loggedHour: $loggedHour')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, habitId, date, status, loggedHour);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HabitLog &&
          other.id == this.id &&
          other.habitId == this.habitId &&
          other.date == this.date &&
          other.status == this.status &&
          other.loggedHour == this.loggedHour);
}

class HabitLogsCompanion extends UpdateCompanion<HabitLog> {
  final Value<int> id;
  final Value<int> habitId;
  final Value<int> date;
  final Value<String> status;
  final Value<int?> loggedHour;
  const HabitLogsCompanion({
    this.id = const Value.absent(),
    this.habitId = const Value.absent(),
    this.date = const Value.absent(),
    this.status = const Value.absent(),
    this.loggedHour = const Value.absent(),
  });
  HabitLogsCompanion.insert({
    this.id = const Value.absent(),
    required int habitId,
    required int date,
    this.status = const Value.absent(),
    this.loggedHour = const Value.absent(),
  }) : habitId = Value(habitId),
       date = Value(date);
  static Insertable<HabitLog> custom({
    Expression<int>? id,
    Expression<int>? habitId,
    Expression<int>? date,
    Expression<String>? status,
    Expression<int>? loggedHour,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (habitId != null) 'habit_id': habitId,
      if (date != null) 'date': date,
      if (status != null) 'status': status,
      if (loggedHour != null) 'logged_hour': loggedHour,
    });
  }

  HabitLogsCompanion copyWith({
    Value<int>? id,
    Value<int>? habitId,
    Value<int>? date,
    Value<String>? status,
    Value<int?>? loggedHour,
  }) {
    return HabitLogsCompanion(
      id: id ?? this.id,
      habitId: habitId ?? this.habitId,
      date: date ?? this.date,
      status: status ?? this.status,
      loggedHour: loggedHour ?? this.loggedHour,
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
    if (date.present) {
      map['date'] = Variable<int>(date.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (loggedHour.present) {
      map['logged_hour'] = Variable<int>(loggedHour.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitLogsCompanion(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('date: $date, ')
          ..write('status: $status, ')
          ..write('loggedHour: $loggedHour')
          ..write(')'))
        .toString();
  }
}

class $GardenObjectsTable extends GardenObjects
    with TableInfo<$GardenObjectsTable, GardenObject> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GardenObjectsTable(this.attachedDatabase, [this._alias]);
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
      'REFERENCES habits (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
    'year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _monthMeta = const VerificationMeta('month');
  @override
  late final GeneratedColumn<int> month = GeneratedColumn<int>(
    'month',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completionPctMeta = const VerificationMeta(
    'completionPct',
  );
  @override
  late final GeneratedColumn<double> completionPct = GeneratedColumn<double>(
    'completion_pct',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _absoluteCompletionsMeta =
      const VerificationMeta('absoluteCompletions');
  @override
  late final GeneratedColumn<int> absoluteCompletions = GeneratedColumn<int>(
    'absolute_completions',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _maxStreakMeta = const VerificationMeta(
    'maxStreak',
  );
  @override
  late final GeneratedColumn<int> maxStreak = GeneratedColumn<int>(
    'max_streak',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _morningRatioMeta = const VerificationMeta(
    'morningRatio',
  );
  @override
  late final GeneratedColumn<double> morningRatio = GeneratedColumn<double>(
    'morning_ratio',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _afternoonRatioMeta = const VerificationMeta(
    'afternoonRatio',
  );
  @override
  late final GeneratedColumn<double> afternoonRatio = GeneratedColumn<double>(
    'afternoon_ratio',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _eveningRatioMeta = const VerificationMeta(
    'eveningRatio',
  );
  @override
  late final GeneratedColumn<double> eveningRatio = GeneratedColumn<double>(
    'evening_ratio',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _objectTypeMeta = const VerificationMeta(
    'objectType',
  );
  @override
  late final GeneratedColumn<String> objectType = GeneratedColumn<String>(
    'object_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('moss'),
  );
  static const VerificationMeta _generationSeedMeta = const VerificationMeta(
    'generationSeed',
  );
  @override
  late final GeneratedColumn<int> generationSeed = GeneratedColumn<int>(
    'generation_seed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pngPathMeta = const VerificationMeta(
    'pngPath',
  );
  @override
  late final GeneratedColumn<String> pngPath = GeneratedColumn<String>(
    'png_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isShortPerfectMeta = const VerificationMeta(
    'isShortPerfect',
  );
  @override
  late final GeneratedColumn<bool> isShortPerfect = GeneratedColumn<bool>(
    'is_short_perfect',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_short_perfect" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    habitId,
    year,
    month,
    completionPct,
    absoluteCompletions,
    maxStreak,
    morningRatio,
    afternoonRatio,
    eveningRatio,
    objectType,
    generationSeed,
    pngPath,
    isShortPerfect,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'garden_objects';
  @override
  VerificationContext validateIntegrity(
    Insertable<GardenObject> instance, {
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
    if (data.containsKey('year')) {
      context.handle(
        _yearMeta,
        year.isAcceptableOrUnknown(data['year']!, _yearMeta),
      );
    } else if (isInserting) {
      context.missing(_yearMeta);
    }
    if (data.containsKey('month')) {
      context.handle(
        _monthMeta,
        month.isAcceptableOrUnknown(data['month']!, _monthMeta),
      );
    } else if (isInserting) {
      context.missing(_monthMeta);
    }
    if (data.containsKey('completion_pct')) {
      context.handle(
        _completionPctMeta,
        completionPct.isAcceptableOrUnknown(
          data['completion_pct']!,
          _completionPctMeta,
        ),
      );
    }
    if (data.containsKey('absolute_completions')) {
      context.handle(
        _absoluteCompletionsMeta,
        absoluteCompletions.isAcceptableOrUnknown(
          data['absolute_completions']!,
          _absoluteCompletionsMeta,
        ),
      );
    }
    if (data.containsKey('max_streak')) {
      context.handle(
        _maxStreakMeta,
        maxStreak.isAcceptableOrUnknown(data['max_streak']!, _maxStreakMeta),
      );
    }
    if (data.containsKey('morning_ratio')) {
      context.handle(
        _morningRatioMeta,
        morningRatio.isAcceptableOrUnknown(
          data['morning_ratio']!,
          _morningRatioMeta,
        ),
      );
    }
    if (data.containsKey('afternoon_ratio')) {
      context.handle(
        _afternoonRatioMeta,
        afternoonRatio.isAcceptableOrUnknown(
          data['afternoon_ratio']!,
          _afternoonRatioMeta,
        ),
      );
    }
    if (data.containsKey('evening_ratio')) {
      context.handle(
        _eveningRatioMeta,
        eveningRatio.isAcceptableOrUnknown(
          data['evening_ratio']!,
          _eveningRatioMeta,
        ),
      );
    }
    if (data.containsKey('object_type')) {
      context.handle(
        _objectTypeMeta,
        objectType.isAcceptableOrUnknown(data['object_type']!, _objectTypeMeta),
      );
    }
    if (data.containsKey('generation_seed')) {
      context.handle(
        _generationSeedMeta,
        generationSeed.isAcceptableOrUnknown(
          data['generation_seed']!,
          _generationSeedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_generationSeedMeta);
    }
    if (data.containsKey('png_path')) {
      context.handle(
        _pngPathMeta,
        pngPath.isAcceptableOrUnknown(data['png_path']!, _pngPathMeta),
      );
    }
    if (data.containsKey('is_short_perfect')) {
      context.handle(
        _isShortPerfectMeta,
        isShortPerfect.isAcceptableOrUnknown(
          data['is_short_perfect']!,
          _isShortPerfectMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GardenObject map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GardenObject(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      habitId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}habit_id'],
      )!,
      year: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}year'],
      )!,
      month: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}month'],
      )!,
      completionPct: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}completion_pct'],
      )!,
      absoluteCompletions: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}absolute_completions'],
      )!,
      maxStreak: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_streak'],
      )!,
      morningRatio: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}morning_ratio'],
      )!,
      afternoonRatio: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}afternoon_ratio'],
      )!,
      eveningRatio: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}evening_ratio'],
      )!,
      objectType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}object_type'],
      )!,
      generationSeed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}generation_seed'],
      )!,
      pngPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}png_path'],
      ),
      isShortPerfect: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_short_perfect'],
      )!,
    );
  }

  @override
  $GardenObjectsTable createAlias(String alias) {
    return $GardenObjectsTable(attachedDatabase, alias);
  }
}

class GardenObject extends DataClass implements Insertable<GardenObject> {
  final int id;
  final int habitId;
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
  final String? pngPath;
  final bool isShortPerfect;
  const GardenObject({
    required this.id,
    required this.habitId,
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
    this.pngPath,
    required this.isShortPerfect,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['habit_id'] = Variable<int>(habitId);
    map['year'] = Variable<int>(year);
    map['month'] = Variable<int>(month);
    map['completion_pct'] = Variable<double>(completionPct);
    map['absolute_completions'] = Variable<int>(absoluteCompletions);
    map['max_streak'] = Variable<int>(maxStreak);
    map['morning_ratio'] = Variable<double>(morningRatio);
    map['afternoon_ratio'] = Variable<double>(afternoonRatio);
    map['evening_ratio'] = Variable<double>(eveningRatio);
    map['object_type'] = Variable<String>(objectType);
    map['generation_seed'] = Variable<int>(generationSeed);
    if (!nullToAbsent || pngPath != null) {
      map['png_path'] = Variable<String>(pngPath);
    }
    map['is_short_perfect'] = Variable<bool>(isShortPerfect);
    return map;
  }

  GardenObjectsCompanion toCompanion(bool nullToAbsent) {
    return GardenObjectsCompanion(
      id: Value(id),
      habitId: Value(habitId),
      year: Value(year),
      month: Value(month),
      completionPct: Value(completionPct),
      absoluteCompletions: Value(absoluteCompletions),
      maxStreak: Value(maxStreak),
      morningRatio: Value(morningRatio),
      afternoonRatio: Value(afternoonRatio),
      eveningRatio: Value(eveningRatio),
      objectType: Value(objectType),
      generationSeed: Value(generationSeed),
      pngPath: pngPath == null && nullToAbsent
          ? const Value.absent()
          : Value(pngPath),
      isShortPerfect: Value(isShortPerfect),
    );
  }

  factory GardenObject.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GardenObject(
      id: serializer.fromJson<int>(json['id']),
      habitId: serializer.fromJson<int>(json['habitId']),
      year: serializer.fromJson<int>(json['year']),
      month: serializer.fromJson<int>(json['month']),
      completionPct: serializer.fromJson<double>(json['completionPct']),
      absoluteCompletions: serializer.fromJson<int>(
        json['absoluteCompletions'],
      ),
      maxStreak: serializer.fromJson<int>(json['maxStreak']),
      morningRatio: serializer.fromJson<double>(json['morningRatio']),
      afternoonRatio: serializer.fromJson<double>(json['afternoonRatio']),
      eveningRatio: serializer.fromJson<double>(json['eveningRatio']),
      objectType: serializer.fromJson<String>(json['objectType']),
      generationSeed: serializer.fromJson<int>(json['generationSeed']),
      pngPath: serializer.fromJson<String?>(json['pngPath']),
      isShortPerfect: serializer.fromJson<bool>(json['isShortPerfect']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'habitId': serializer.toJson<int>(habitId),
      'year': serializer.toJson<int>(year),
      'month': serializer.toJson<int>(month),
      'completionPct': serializer.toJson<double>(completionPct),
      'absoluteCompletions': serializer.toJson<int>(absoluteCompletions),
      'maxStreak': serializer.toJson<int>(maxStreak),
      'morningRatio': serializer.toJson<double>(morningRatio),
      'afternoonRatio': serializer.toJson<double>(afternoonRatio),
      'eveningRatio': serializer.toJson<double>(eveningRatio),
      'objectType': serializer.toJson<String>(objectType),
      'generationSeed': serializer.toJson<int>(generationSeed),
      'pngPath': serializer.toJson<String?>(pngPath),
      'isShortPerfect': serializer.toJson<bool>(isShortPerfect),
    };
  }

  GardenObject copyWith({
    int? id,
    int? habitId,
    int? year,
    int? month,
    double? completionPct,
    int? absoluteCompletions,
    int? maxStreak,
    double? morningRatio,
    double? afternoonRatio,
    double? eveningRatio,
    String? objectType,
    int? generationSeed,
    Value<String?> pngPath = const Value.absent(),
    bool? isShortPerfect,
  }) => GardenObject(
    id: id ?? this.id,
    habitId: habitId ?? this.habitId,
    year: year ?? this.year,
    month: month ?? this.month,
    completionPct: completionPct ?? this.completionPct,
    absoluteCompletions: absoluteCompletions ?? this.absoluteCompletions,
    maxStreak: maxStreak ?? this.maxStreak,
    morningRatio: morningRatio ?? this.morningRatio,
    afternoonRatio: afternoonRatio ?? this.afternoonRatio,
    eveningRatio: eveningRatio ?? this.eveningRatio,
    objectType: objectType ?? this.objectType,
    generationSeed: generationSeed ?? this.generationSeed,
    pngPath: pngPath.present ? pngPath.value : this.pngPath,
    isShortPerfect: isShortPerfect ?? this.isShortPerfect,
  );
  GardenObject copyWithCompanion(GardenObjectsCompanion data) {
    return GardenObject(
      id: data.id.present ? data.id.value : this.id,
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      year: data.year.present ? data.year.value : this.year,
      month: data.month.present ? data.month.value : this.month,
      completionPct: data.completionPct.present
          ? data.completionPct.value
          : this.completionPct,
      absoluteCompletions: data.absoluteCompletions.present
          ? data.absoluteCompletions.value
          : this.absoluteCompletions,
      maxStreak: data.maxStreak.present ? data.maxStreak.value : this.maxStreak,
      morningRatio: data.morningRatio.present
          ? data.morningRatio.value
          : this.morningRatio,
      afternoonRatio: data.afternoonRatio.present
          ? data.afternoonRatio.value
          : this.afternoonRatio,
      eveningRatio: data.eveningRatio.present
          ? data.eveningRatio.value
          : this.eveningRatio,
      objectType: data.objectType.present
          ? data.objectType.value
          : this.objectType,
      generationSeed: data.generationSeed.present
          ? data.generationSeed.value
          : this.generationSeed,
      pngPath: data.pngPath.present ? data.pngPath.value : this.pngPath,
      isShortPerfect: data.isShortPerfect.present
          ? data.isShortPerfect.value
          : this.isShortPerfect,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GardenObject(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('year: $year, ')
          ..write('month: $month, ')
          ..write('completionPct: $completionPct, ')
          ..write('absoluteCompletions: $absoluteCompletions, ')
          ..write('maxStreak: $maxStreak, ')
          ..write('morningRatio: $morningRatio, ')
          ..write('afternoonRatio: $afternoonRatio, ')
          ..write('eveningRatio: $eveningRatio, ')
          ..write('objectType: $objectType, ')
          ..write('generationSeed: $generationSeed, ')
          ..write('pngPath: $pngPath, ')
          ..write('isShortPerfect: $isShortPerfect')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    habitId,
    year,
    month,
    completionPct,
    absoluteCompletions,
    maxStreak,
    morningRatio,
    afternoonRatio,
    eveningRatio,
    objectType,
    generationSeed,
    pngPath,
    isShortPerfect,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GardenObject &&
          other.id == this.id &&
          other.habitId == this.habitId &&
          other.year == this.year &&
          other.month == this.month &&
          other.completionPct == this.completionPct &&
          other.absoluteCompletions == this.absoluteCompletions &&
          other.maxStreak == this.maxStreak &&
          other.morningRatio == this.morningRatio &&
          other.afternoonRatio == this.afternoonRatio &&
          other.eveningRatio == this.eveningRatio &&
          other.objectType == this.objectType &&
          other.generationSeed == this.generationSeed &&
          other.pngPath == this.pngPath &&
          other.isShortPerfect == this.isShortPerfect);
}

class GardenObjectsCompanion extends UpdateCompanion<GardenObject> {
  final Value<int> id;
  final Value<int> habitId;
  final Value<int> year;
  final Value<int> month;
  final Value<double> completionPct;
  final Value<int> absoluteCompletions;
  final Value<int> maxStreak;
  final Value<double> morningRatio;
  final Value<double> afternoonRatio;
  final Value<double> eveningRatio;
  final Value<String> objectType;
  final Value<int> generationSeed;
  final Value<String?> pngPath;
  final Value<bool> isShortPerfect;
  const GardenObjectsCompanion({
    this.id = const Value.absent(),
    this.habitId = const Value.absent(),
    this.year = const Value.absent(),
    this.month = const Value.absent(),
    this.completionPct = const Value.absent(),
    this.absoluteCompletions = const Value.absent(),
    this.maxStreak = const Value.absent(),
    this.morningRatio = const Value.absent(),
    this.afternoonRatio = const Value.absent(),
    this.eveningRatio = const Value.absent(),
    this.objectType = const Value.absent(),
    this.generationSeed = const Value.absent(),
    this.pngPath = const Value.absent(),
    this.isShortPerfect = const Value.absent(),
  });
  GardenObjectsCompanion.insert({
    this.id = const Value.absent(),
    required int habitId,
    required int year,
    required int month,
    this.completionPct = const Value.absent(),
    this.absoluteCompletions = const Value.absent(),
    this.maxStreak = const Value.absent(),
    this.morningRatio = const Value.absent(),
    this.afternoonRatio = const Value.absent(),
    this.eveningRatio = const Value.absent(),
    this.objectType = const Value.absent(),
    required int generationSeed,
    this.pngPath = const Value.absent(),
    this.isShortPerfect = const Value.absent(),
  }) : habitId = Value(habitId),
       year = Value(year),
       month = Value(month),
       generationSeed = Value(generationSeed);
  static Insertable<GardenObject> custom({
    Expression<int>? id,
    Expression<int>? habitId,
    Expression<int>? year,
    Expression<int>? month,
    Expression<double>? completionPct,
    Expression<int>? absoluteCompletions,
    Expression<int>? maxStreak,
    Expression<double>? morningRatio,
    Expression<double>? afternoonRatio,
    Expression<double>? eveningRatio,
    Expression<String>? objectType,
    Expression<int>? generationSeed,
    Expression<String>? pngPath,
    Expression<bool>? isShortPerfect,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (habitId != null) 'habit_id': habitId,
      if (year != null) 'year': year,
      if (month != null) 'month': month,
      if (completionPct != null) 'completion_pct': completionPct,
      if (absoluteCompletions != null)
        'absolute_completions': absoluteCompletions,
      if (maxStreak != null) 'max_streak': maxStreak,
      if (morningRatio != null) 'morning_ratio': morningRatio,
      if (afternoonRatio != null) 'afternoon_ratio': afternoonRatio,
      if (eveningRatio != null) 'evening_ratio': eveningRatio,
      if (objectType != null) 'object_type': objectType,
      if (generationSeed != null) 'generation_seed': generationSeed,
      if (pngPath != null) 'png_path': pngPath,
      if (isShortPerfect != null) 'is_short_perfect': isShortPerfect,
    });
  }

  GardenObjectsCompanion copyWith({
    Value<int>? id,
    Value<int>? habitId,
    Value<int>? year,
    Value<int>? month,
    Value<double>? completionPct,
    Value<int>? absoluteCompletions,
    Value<int>? maxStreak,
    Value<double>? morningRatio,
    Value<double>? afternoonRatio,
    Value<double>? eveningRatio,
    Value<String>? objectType,
    Value<int>? generationSeed,
    Value<String?>? pngPath,
    Value<bool>? isShortPerfect,
  }) {
    return GardenObjectsCompanion(
      id: id ?? this.id,
      habitId: habitId ?? this.habitId,
      year: year ?? this.year,
      month: month ?? this.month,
      completionPct: completionPct ?? this.completionPct,
      absoluteCompletions: absoluteCompletions ?? this.absoluteCompletions,
      maxStreak: maxStreak ?? this.maxStreak,
      morningRatio: morningRatio ?? this.morningRatio,
      afternoonRatio: afternoonRatio ?? this.afternoonRatio,
      eveningRatio: eveningRatio ?? this.eveningRatio,
      objectType: objectType ?? this.objectType,
      generationSeed: generationSeed ?? this.generationSeed,
      pngPath: pngPath ?? this.pngPath,
      isShortPerfect: isShortPerfect ?? this.isShortPerfect,
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
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (month.present) {
      map['month'] = Variable<int>(month.value);
    }
    if (completionPct.present) {
      map['completion_pct'] = Variable<double>(completionPct.value);
    }
    if (absoluteCompletions.present) {
      map['absolute_completions'] = Variable<int>(absoluteCompletions.value);
    }
    if (maxStreak.present) {
      map['max_streak'] = Variable<int>(maxStreak.value);
    }
    if (morningRatio.present) {
      map['morning_ratio'] = Variable<double>(morningRatio.value);
    }
    if (afternoonRatio.present) {
      map['afternoon_ratio'] = Variable<double>(afternoonRatio.value);
    }
    if (eveningRatio.present) {
      map['evening_ratio'] = Variable<double>(eveningRatio.value);
    }
    if (objectType.present) {
      map['object_type'] = Variable<String>(objectType.value);
    }
    if (generationSeed.present) {
      map['generation_seed'] = Variable<int>(generationSeed.value);
    }
    if (pngPath.present) {
      map['png_path'] = Variable<String>(pngPath.value);
    }
    if (isShortPerfect.present) {
      map['is_short_perfect'] = Variable<bool>(isShortPerfect.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GardenObjectsCompanion(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('year: $year, ')
          ..write('month: $month, ')
          ..write('completionPct: $completionPct, ')
          ..write('absoluteCompletions: $absoluteCompletions, ')
          ..write('maxStreak: $maxStreak, ')
          ..write('morningRatio: $morningRatio, ')
          ..write('afternoonRatio: $afternoonRatio, ')
          ..write('eveningRatio: $eveningRatio, ')
          ..write('objectType: $objectType, ')
          ..write('generationSeed: $generationSeed, ')
          ..write('pngPath: $pngPath, ')
          ..write('isShortPerfect: $isShortPerfect')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $HabitsTable habits = $HabitsTable(this);
  late final $HabitLogsTable habitLogs = $HabitLogsTable(this);
  late final $GardenObjectsTable gardenObjects = $GardenObjectsTable(this);
  late final HabitsDao habitsDao = HabitsDao(this as AppDatabase);
  late final HabitLogsDao habitLogsDao = HabitLogsDao(this as AppDatabase);
  late final GardenObjectsDao gardenObjectsDao = GardenObjectsDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    habits,
    habitLogs,
    gardenObjects,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'habits',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('habit_logs', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'habits',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('garden_objects', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$HabitsTableCreateCompanionBuilder =
    HabitsCompanion Function({
      Value<int> id,
      required String name,
      Value<String> category,
      Value<String> seedArchetype,
      Value<String> frequencyType,
      Value<String> frequencyValue,
      Value<String> timeOfDay,
      Value<bool> isFocus,
      Value<bool> isArchived,
      required int createdAt,
    });
typedef $$HabitsTableUpdateCompanionBuilder =
    HabitsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> category,
      Value<String> seedArchetype,
      Value<String> frequencyType,
      Value<String> frequencyValue,
      Value<String> timeOfDay,
      Value<bool> isFocus,
      Value<bool> isArchived,
      Value<int> createdAt,
    });

final class $$HabitsTableReferences
    extends BaseReferences<_$AppDatabase, $HabitsTable, Habit> {
  $$HabitsTableReferences(super.$_db, super.$_table, super.$_typedResult);

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

  static MultiTypedResultKey<$GardenObjectsTable, List<GardenObject>>
  _gardenObjectsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.gardenObjects,
    aliasName: $_aliasNameGenerator(db.habits.id, db.gardenObjects.habitId),
  );

  $$GardenObjectsTableProcessedTableManager get gardenObjectsRefs {
    final manager = $$GardenObjectsTableTableManager(
      $_db,
      $_db.gardenObjects,
    ).filter((f) => f.habitId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_gardenObjectsRefsTable($_db));
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

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get seedArchetype => $composableBuilder(
    column: $table.seedArchetype,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get frequencyType => $composableBuilder(
    column: $table.frequencyType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get frequencyValue => $composableBuilder(
    column: $table.frequencyValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timeOfDay => $composableBuilder(
    column: $table.timeOfDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFocus => $composableBuilder(
    column: $table.isFocus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
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

  Expression<bool> gardenObjectsRefs(
    Expression<bool> Function($$GardenObjectsTableFilterComposer f) f,
  ) {
    final $$GardenObjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.gardenObjects,
      getReferencedColumn: (t) => t.habitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GardenObjectsTableFilterComposer(
            $db: $db,
            $table: $db.gardenObjects,
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

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get seedArchetype => $composableBuilder(
    column: $table.seedArchetype,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get frequencyType => $composableBuilder(
    column: $table.frequencyType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get frequencyValue => $composableBuilder(
    column: $table.frequencyValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timeOfDay => $composableBuilder(
    column: $table.timeOfDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFocus => $composableBuilder(
    column: $table.isFocus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
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

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get seedArchetype => $composableBuilder(
    column: $table.seedArchetype,
    builder: (column) => column,
  );

  GeneratedColumn<String> get frequencyType => $composableBuilder(
    column: $table.frequencyType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get frequencyValue => $composableBuilder(
    column: $table.frequencyValue,
    builder: (column) => column,
  );

  GeneratedColumn<String> get timeOfDay =>
      $composableBuilder(column: $table.timeOfDay, builder: (column) => column);

  GeneratedColumn<bool> get isFocus =>
      $composableBuilder(column: $table.isFocus, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

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

  Expression<T> gardenObjectsRefs<T extends Object>(
    Expression<T> Function($$GardenObjectsTableAnnotationComposer a) f,
  ) {
    final $$GardenObjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.gardenObjects,
      getReferencedColumn: (t) => t.habitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GardenObjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.gardenObjects,
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
          PrefetchHooks Function({bool habitLogsRefs, bool gardenObjectsRefs})
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
                Value<String> category = const Value.absent(),
                Value<String> seedArchetype = const Value.absent(),
                Value<String> frequencyType = const Value.absent(),
                Value<String> frequencyValue = const Value.absent(),
                Value<String> timeOfDay = const Value.absent(),
                Value<bool> isFocus = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
              }) => HabitsCompanion(
                id: id,
                name: name,
                category: category,
                seedArchetype: seedArchetype,
                frequencyType: frequencyType,
                frequencyValue: frequencyValue,
                timeOfDay: timeOfDay,
                isFocus: isFocus,
                isArchived: isArchived,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String> category = const Value.absent(),
                Value<String> seedArchetype = const Value.absent(),
                Value<String> frequencyType = const Value.absent(),
                Value<String> frequencyValue = const Value.absent(),
                Value<String> timeOfDay = const Value.absent(),
                Value<bool> isFocus = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                required int createdAt,
              }) => HabitsCompanion.insert(
                id: id,
                name: name,
                category: category,
                seedArchetype: seedArchetype,
                frequencyType: frequencyType,
                frequencyValue: frequencyValue,
                timeOfDay: timeOfDay,
                isFocus: isFocus,
                isArchived: isArchived,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$HabitsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({habitLogsRefs = false, gardenObjectsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (habitLogsRefs) db.habitLogs,
                    if (gardenObjectsRefs) db.gardenObjects,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
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
                      if (gardenObjectsRefs)
                        await $_getPrefetchedData<
                          Habit,
                          $HabitsTable,
                          GardenObject
                        >(
                          currentTable: table,
                          referencedTable: $$HabitsTableReferences
                              ._gardenObjectsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HabitsTableReferences(
                                db,
                                table,
                                p0,
                              ).gardenObjectsRefs,
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
      PrefetchHooks Function({bool habitLogsRefs, bool gardenObjectsRefs})
    >;
typedef $$HabitLogsTableCreateCompanionBuilder =
    HabitLogsCompanion Function({
      Value<int> id,
      required int habitId,
      required int date,
      Value<String> status,
      Value<int?> loggedHour,
    });
typedef $$HabitLogsTableUpdateCompanionBuilder =
    HabitLogsCompanion Function({
      Value<int> id,
      Value<int> habitId,
      Value<int> date,
      Value<String> status,
      Value<int?> loggedHour,
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

  ColumnFilters<int> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get loggedHour => $composableBuilder(
    column: $table.loggedHour,
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

  ColumnOrderings<int> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get loggedHour => $composableBuilder(
    column: $table.loggedHour,
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

  GeneratedColumn<int> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get loggedHour => $composableBuilder(
    column: $table.loggedHour,
    builder: (column) => column,
  );

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
          PrefetchHooks Function({bool habitId})
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
                Value<int> date = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int?> loggedHour = const Value.absent(),
              }) => HabitLogsCompanion(
                id: id,
                habitId: habitId,
                date: date,
                status: status,
                loggedHour: loggedHour,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int habitId,
                required int date,
                Value<String> status = const Value.absent(),
                Value<int?> loggedHour = const Value.absent(),
              }) => HabitLogsCompanion.insert(
                id: id,
                habitId: habitId,
                date: date,
                status: status,
                loggedHour: loggedHour,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$HabitLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({habitId = false}) {
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
      PrefetchHooks Function({bool habitId})
    >;
typedef $$GardenObjectsTableCreateCompanionBuilder =
    GardenObjectsCompanion Function({
      Value<int> id,
      required int habitId,
      required int year,
      required int month,
      Value<double> completionPct,
      Value<int> absoluteCompletions,
      Value<int> maxStreak,
      Value<double> morningRatio,
      Value<double> afternoonRatio,
      Value<double> eveningRatio,
      Value<String> objectType,
      required int generationSeed,
      Value<String?> pngPath,
      Value<bool> isShortPerfect,
    });
typedef $$GardenObjectsTableUpdateCompanionBuilder =
    GardenObjectsCompanion Function({
      Value<int> id,
      Value<int> habitId,
      Value<int> year,
      Value<int> month,
      Value<double> completionPct,
      Value<int> absoluteCompletions,
      Value<int> maxStreak,
      Value<double> morningRatio,
      Value<double> afternoonRatio,
      Value<double> eveningRatio,
      Value<String> objectType,
      Value<int> generationSeed,
      Value<String?> pngPath,
      Value<bool> isShortPerfect,
    });

final class $$GardenObjectsTableReferences
    extends BaseReferences<_$AppDatabase, $GardenObjectsTable, GardenObject> {
  $$GardenObjectsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $HabitsTable _habitIdTable(_$AppDatabase db) => db.habits.createAlias(
    $_aliasNameGenerator(db.gardenObjects.habitId, db.habits.id),
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
}

class $$GardenObjectsTableFilterComposer
    extends Composer<_$AppDatabase, $GardenObjectsTable> {
  $$GardenObjectsTableFilterComposer({
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

  ColumnFilters<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get month => $composableBuilder(
    column: $table.month,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get completionPct => $composableBuilder(
    column: $table.completionPct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get absoluteCompletions => $composableBuilder(
    column: $table.absoluteCompletions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxStreak => $composableBuilder(
    column: $table.maxStreak,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get morningRatio => $composableBuilder(
    column: $table.morningRatio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get afternoonRatio => $composableBuilder(
    column: $table.afternoonRatio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get eveningRatio => $composableBuilder(
    column: $table.eveningRatio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get objectType => $composableBuilder(
    column: $table.objectType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get generationSeed => $composableBuilder(
    column: $table.generationSeed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pngPath => $composableBuilder(
    column: $table.pngPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isShortPerfect => $composableBuilder(
    column: $table.isShortPerfect,
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
}

class $$GardenObjectsTableOrderingComposer
    extends Composer<_$AppDatabase, $GardenObjectsTable> {
  $$GardenObjectsTableOrderingComposer({
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

  ColumnOrderings<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get month => $composableBuilder(
    column: $table.month,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get completionPct => $composableBuilder(
    column: $table.completionPct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get absoluteCompletions => $composableBuilder(
    column: $table.absoluteCompletions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxStreak => $composableBuilder(
    column: $table.maxStreak,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get morningRatio => $composableBuilder(
    column: $table.morningRatio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get afternoonRatio => $composableBuilder(
    column: $table.afternoonRatio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get eveningRatio => $composableBuilder(
    column: $table.eveningRatio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get objectType => $composableBuilder(
    column: $table.objectType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get generationSeed => $composableBuilder(
    column: $table.generationSeed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pngPath => $composableBuilder(
    column: $table.pngPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isShortPerfect => $composableBuilder(
    column: $table.isShortPerfect,
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
}

class $$GardenObjectsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GardenObjectsTable> {
  $$GardenObjectsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get year =>
      $composableBuilder(column: $table.year, builder: (column) => column);

  GeneratedColumn<int> get month =>
      $composableBuilder(column: $table.month, builder: (column) => column);

  GeneratedColumn<double> get completionPct => $composableBuilder(
    column: $table.completionPct,
    builder: (column) => column,
  );

  GeneratedColumn<int> get absoluteCompletions => $composableBuilder(
    column: $table.absoluteCompletions,
    builder: (column) => column,
  );

  GeneratedColumn<int> get maxStreak =>
      $composableBuilder(column: $table.maxStreak, builder: (column) => column);

  GeneratedColumn<double> get morningRatio => $composableBuilder(
    column: $table.morningRatio,
    builder: (column) => column,
  );

  GeneratedColumn<double> get afternoonRatio => $composableBuilder(
    column: $table.afternoonRatio,
    builder: (column) => column,
  );

  GeneratedColumn<double> get eveningRatio => $composableBuilder(
    column: $table.eveningRatio,
    builder: (column) => column,
  );

  GeneratedColumn<String> get objectType => $composableBuilder(
    column: $table.objectType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get generationSeed => $composableBuilder(
    column: $table.generationSeed,
    builder: (column) => column,
  );

  GeneratedColumn<String> get pngPath =>
      $composableBuilder(column: $table.pngPath, builder: (column) => column);

  GeneratedColumn<bool> get isShortPerfect => $composableBuilder(
    column: $table.isShortPerfect,
    builder: (column) => column,
  );

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
}

class $$GardenObjectsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GardenObjectsTable,
          GardenObject,
          $$GardenObjectsTableFilterComposer,
          $$GardenObjectsTableOrderingComposer,
          $$GardenObjectsTableAnnotationComposer,
          $$GardenObjectsTableCreateCompanionBuilder,
          $$GardenObjectsTableUpdateCompanionBuilder,
          (GardenObject, $$GardenObjectsTableReferences),
          GardenObject,
          PrefetchHooks Function({bool habitId})
        > {
  $$GardenObjectsTableTableManager(_$AppDatabase db, $GardenObjectsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GardenObjectsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GardenObjectsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GardenObjectsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> habitId = const Value.absent(),
                Value<int> year = const Value.absent(),
                Value<int> month = const Value.absent(),
                Value<double> completionPct = const Value.absent(),
                Value<int> absoluteCompletions = const Value.absent(),
                Value<int> maxStreak = const Value.absent(),
                Value<double> morningRatio = const Value.absent(),
                Value<double> afternoonRatio = const Value.absent(),
                Value<double> eveningRatio = const Value.absent(),
                Value<String> objectType = const Value.absent(),
                Value<int> generationSeed = const Value.absent(),
                Value<String?> pngPath = const Value.absent(),
                Value<bool> isShortPerfect = const Value.absent(),
              }) => GardenObjectsCompanion(
                id: id,
                habitId: habitId,
                year: year,
                month: month,
                completionPct: completionPct,
                absoluteCompletions: absoluteCompletions,
                maxStreak: maxStreak,
                morningRatio: morningRatio,
                afternoonRatio: afternoonRatio,
                eveningRatio: eveningRatio,
                objectType: objectType,
                generationSeed: generationSeed,
                pngPath: pngPath,
                isShortPerfect: isShortPerfect,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int habitId,
                required int year,
                required int month,
                Value<double> completionPct = const Value.absent(),
                Value<int> absoluteCompletions = const Value.absent(),
                Value<int> maxStreak = const Value.absent(),
                Value<double> morningRatio = const Value.absent(),
                Value<double> afternoonRatio = const Value.absent(),
                Value<double> eveningRatio = const Value.absent(),
                Value<String> objectType = const Value.absent(),
                required int generationSeed,
                Value<String?> pngPath = const Value.absent(),
                Value<bool> isShortPerfect = const Value.absent(),
              }) => GardenObjectsCompanion.insert(
                id: id,
                habitId: habitId,
                year: year,
                month: month,
                completionPct: completionPct,
                absoluteCompletions: absoluteCompletions,
                maxStreak: maxStreak,
                morningRatio: morningRatio,
                afternoonRatio: afternoonRatio,
                eveningRatio: eveningRatio,
                objectType: objectType,
                generationSeed: generationSeed,
                pngPath: pngPath,
                isShortPerfect: isShortPerfect,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$GardenObjectsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({habitId = false}) {
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
                                referencedTable: $$GardenObjectsTableReferences
                                    ._habitIdTable(db),
                                referencedColumn: $$GardenObjectsTableReferences
                                    ._habitIdTable(db)
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

typedef $$GardenObjectsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GardenObjectsTable,
      GardenObject,
      $$GardenObjectsTableFilterComposer,
      $$GardenObjectsTableOrderingComposer,
      $$GardenObjectsTableAnnotationComposer,
      $$GardenObjectsTableCreateCompanionBuilder,
      $$GardenObjectsTableUpdateCompanionBuilder,
      (GardenObject, $$GardenObjectsTableReferences),
      GardenObject,
      PrefetchHooks Function({bool habitId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$HabitsTableTableManager get habits =>
      $$HabitsTableTableManager(_db, _db.habits);
  $$HabitLogsTableTableManager get habitLogs =>
      $$HabitLogsTableTableManager(_db, _db.habitLogs);
  $$GardenObjectsTableTableManager get gardenObjects =>
      $$GardenObjectsTableTableManager(_db, _db.gardenObjects);
}
