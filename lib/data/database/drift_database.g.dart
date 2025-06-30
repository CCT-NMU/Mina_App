// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database.dart';

// ignore_for_file: type=lint
class $AppUserSettingsTable extends AppUserSettings
    with TableInfo<$AppUserSettingsTable, AppUserSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppUserSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [key, value, userId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_user_settings';
  @override
  VerificationContext validateIntegrity(Insertable<AppUserSetting> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key, userId};
  @override
  AppUserSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppUserSetting(
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
    );
  }

  @override
  $AppUserSettingsTable createAlias(String alias) {
    return $AppUserSettingsTable(attachedDatabase, alias);
  }
}

class AppUserSetting extends DataClass implements Insertable<AppUserSetting> {
  final String key;
  final String value;
  final String userId;
  const AppUserSetting(
      {required this.key, required this.value, required this.userId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['user_id'] = Variable<String>(userId);
    return map;
  }

  AppUserSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppUserSettingsCompanion(
      key: Value(key),
      value: Value(value),
      userId: Value(userId),
    );
  }

  factory AppUserSetting.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppUserSetting(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      userId: serializer.fromJson<String>(json['userId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'userId': serializer.toJson<String>(userId),
    };
  }

  AppUserSetting copyWith({String? key, String? value, String? userId}) =>
      AppUserSetting(
        key: key ?? this.key,
        value: value ?? this.value,
        userId: userId ?? this.userId,
      );
  AppUserSetting copyWithCompanion(AppUserSettingsCompanion data) {
    return AppUserSetting(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      userId: data.userId.present ? data.userId.value : this.userId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppUserSetting(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value, userId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppUserSetting &&
          other.key == this.key &&
          other.value == this.value &&
          other.userId == this.userId);
}

class AppUserSettingsCompanion extends UpdateCompanion<AppUserSetting> {
  final Value<String> key;
  final Value<String> value;
  final Value<String> userId;
  final Value<int> rowid;
  const AppUserSettingsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.userId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppUserSettingsCompanion.insert({
    required String key,
    required String value,
    required String userId,
    this.rowid = const Value.absent(),
  })  : key = Value(key),
        value = Value(value),
        userId = Value(userId);
  static Insertable<AppUserSetting> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<String>? userId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (userId != null) 'user_id': userId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppUserSettingsCompanion copyWith(
      {Value<String>? key,
      Value<String>? value,
      Value<String>? userId,
      Value<int>? rowid}) {
    return AppUserSettingsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      userId: userId ?? this.userId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppUserSettingsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('userId: $userId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppDaysTable extends AppDays with TableInfo<$AppDaysTable, AppDay> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppDaysTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _isPeriodDayMeta =
      const VerificationMeta('isPeriodDay');
  @override
  late final GeneratedColumn<bool> isPeriodDay = GeneratedColumn<bool>(
      'is_period_day', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_period_day" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _symptomListMeta =
      const VerificationMeta('symptomList');
  @override
  late final GeneratedColumn<String> symptomList = GeneratedColumn<String>(
      'symptom_list', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _moodListMeta =
      const VerificationMeta('moodList');
  @override
  late final GeneratedColumn<String> moodList = GeneratedColumn<String>(
      'mood_list', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [date, isPeriodDay, note, symptomList, moodList, userId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_days';
  @override
  VerificationContext validateIntegrity(Insertable<AppDay> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('is_period_day')) {
      context.handle(
          _isPeriodDayMeta,
          isPeriodDay.isAcceptableOrUnknown(
              data['is_period_day']!, _isPeriodDayMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('symptom_list')) {
      context.handle(
          _symptomListMeta,
          symptomList.isAcceptableOrUnknown(
              data['symptom_list']!, _symptomListMeta));
    }
    if (data.containsKey('mood_list')) {
      context.handle(_moodListMeta,
          moodList.isAcceptableOrUnknown(data['mood_list']!, _moodListMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {date, userId};
  @override
  AppDay map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppDay(
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      isPeriodDay: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_period_day'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      symptomList: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}symptom_list']),
      moodList: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mood_list']),
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
    );
  }

  @override
  $AppDaysTable createAlias(String alias) {
    return $AppDaysTable(attachedDatabase, alias);
  }
}

class AppDay extends DataClass implements Insertable<AppDay> {
  final DateTime date;
  final bool isPeriodDay;
  final String? note;
  final String? symptomList;
  final String? moodList;
  final String userId;
  const AppDay(
      {required this.date,
      required this.isPeriodDay,
      this.note,
      this.symptomList,
      this.moodList,
      required this.userId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['date'] = Variable<DateTime>(date);
    map['is_period_day'] = Variable<bool>(isPeriodDay);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || symptomList != null) {
      map['symptom_list'] = Variable<String>(symptomList);
    }
    if (!nullToAbsent || moodList != null) {
      map['mood_list'] = Variable<String>(moodList);
    }
    map['user_id'] = Variable<String>(userId);
    return map;
  }

  AppDaysCompanion toCompanion(bool nullToAbsent) {
    return AppDaysCompanion(
      date: Value(date),
      isPeriodDay: Value(isPeriodDay),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      symptomList: symptomList == null && nullToAbsent
          ? const Value.absent()
          : Value(symptomList),
      moodList: moodList == null && nullToAbsent
          ? const Value.absent()
          : Value(moodList),
      userId: Value(userId),
    );
  }

  factory AppDay.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppDay(
      date: serializer.fromJson<DateTime>(json['date']),
      isPeriodDay: serializer.fromJson<bool>(json['isPeriodDay']),
      note: serializer.fromJson<String?>(json['note']),
      symptomList: serializer.fromJson<String?>(json['symptomList']),
      moodList: serializer.fromJson<String?>(json['moodList']),
      userId: serializer.fromJson<String>(json['userId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'date': serializer.toJson<DateTime>(date),
      'isPeriodDay': serializer.toJson<bool>(isPeriodDay),
      'note': serializer.toJson<String?>(note),
      'symptomList': serializer.toJson<String?>(symptomList),
      'moodList': serializer.toJson<String?>(moodList),
      'userId': serializer.toJson<String>(userId),
    };
  }

  AppDay copyWith(
          {DateTime? date,
          bool? isPeriodDay,
          Value<String?> note = const Value.absent(),
          Value<String?> symptomList = const Value.absent(),
          Value<String?> moodList = const Value.absent(),
          String? userId}) =>
      AppDay(
        date: date ?? this.date,
        isPeriodDay: isPeriodDay ?? this.isPeriodDay,
        note: note.present ? note.value : this.note,
        symptomList: symptomList.present ? symptomList.value : this.symptomList,
        moodList: moodList.present ? moodList.value : this.moodList,
        userId: userId ?? this.userId,
      );
  AppDay copyWithCompanion(AppDaysCompanion data) {
    return AppDay(
      date: data.date.present ? data.date.value : this.date,
      isPeriodDay:
          data.isPeriodDay.present ? data.isPeriodDay.value : this.isPeriodDay,
      note: data.note.present ? data.note.value : this.note,
      symptomList:
          data.symptomList.present ? data.symptomList.value : this.symptomList,
      moodList: data.moodList.present ? data.moodList.value : this.moodList,
      userId: data.userId.present ? data.userId.value : this.userId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppDay(')
          ..write('date: $date, ')
          ..write('isPeriodDay: $isPeriodDay, ')
          ..write('note: $note, ')
          ..write('symptomList: $symptomList, ')
          ..write('moodList: $moodList, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(date, isPeriodDay, note, symptomList, moodList, userId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppDay &&
          other.date == this.date &&
          other.isPeriodDay == this.isPeriodDay &&
          other.note == this.note &&
          other.symptomList == this.symptomList &&
          other.moodList == this.moodList &&
          other.userId == this.userId);
}

class AppDaysCompanion extends UpdateCompanion<AppDay> {
  final Value<DateTime> date;
  final Value<bool> isPeriodDay;
  final Value<String?> note;
  final Value<String?> symptomList;
  final Value<String?> moodList;
  final Value<String> userId;
  final Value<int> rowid;
  const AppDaysCompanion({
    this.date = const Value.absent(),
    this.isPeriodDay = const Value.absent(),
    this.note = const Value.absent(),
    this.symptomList = const Value.absent(),
    this.moodList = const Value.absent(),
    this.userId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppDaysCompanion.insert({
    required DateTime date,
    this.isPeriodDay = const Value.absent(),
    this.note = const Value.absent(),
    this.symptomList = const Value.absent(),
    this.moodList = const Value.absent(),
    required String userId,
    this.rowid = const Value.absent(),
  })  : date = Value(date),
        userId = Value(userId);
  static Insertable<AppDay> custom({
    Expression<DateTime>? date,
    Expression<bool>? isPeriodDay,
    Expression<String>? note,
    Expression<String>? symptomList,
    Expression<String>? moodList,
    Expression<String>? userId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (date != null) 'date': date,
      if (isPeriodDay != null) 'is_period_day': isPeriodDay,
      if (note != null) 'note': note,
      if (symptomList != null) 'symptom_list': symptomList,
      if (moodList != null) 'mood_list': moodList,
      if (userId != null) 'user_id': userId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppDaysCompanion copyWith(
      {Value<DateTime>? date,
      Value<bool>? isPeriodDay,
      Value<String?>? note,
      Value<String?>? symptomList,
      Value<String?>? moodList,
      Value<String>? userId,
      Value<int>? rowid}) {
    return AppDaysCompanion(
      date: date ?? this.date,
      isPeriodDay: isPeriodDay ?? this.isPeriodDay,
      note: note ?? this.note,
      symptomList: symptomList ?? this.symptomList,
      moodList: moodList ?? this.moodList,
      userId: userId ?? this.userId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (isPeriodDay.present) {
      map['is_period_day'] = Variable<bool>(isPeriodDay.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (symptomList.present) {
      map['symptom_list'] = Variable<String>(symptomList.value);
    }
    if (moodList.present) {
      map['mood_list'] = Variable<String>(moodList.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppDaysCompanion(')
          ..write('date: $date, ')
          ..write('isPeriodDay: $isPeriodDay, ')
          ..write('note: $note, ')
          ..write('symptomList: $symptomList, ')
          ..write('moodList: $moodList, ')
          ..write('userId: $userId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppPeriodDaysTable extends AppPeriodDays
    with TableInfo<$AppPeriodDaysTable, AppPeriodDay> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppPeriodDaysTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _flowWeightMeta =
      const VerificationMeta('flowWeight');
  @override
  late final GeneratedColumn<int> flowWeight = GeneratedColumn<int>(
      'flow_weight', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _isPeriodStartDayMeta =
      const VerificationMeta('isPeriodStartDay');
  @override
  late final GeneratedColumn<bool> isPeriodStartDay = GeneratedColumn<bool>(
      'is_period_start_day', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_period_start_day" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isPeriodEndDayMeta =
      const VerificationMeta('isPeriodEndDay');
  @override
  late final GeneratedColumn<bool> isPeriodEndDay = GeneratedColumn<bool>(
      'is_period_end_day', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_period_end_day" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [date, flowWeight, isPeriodStartDay, isPeriodEndDay, userId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_period_days';
  @override
  VerificationContext validateIntegrity(Insertable<AppPeriodDay> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('flow_weight')) {
      context.handle(
          _flowWeightMeta,
          flowWeight.isAcceptableOrUnknown(
              data['flow_weight']!, _flowWeightMeta));
    }
    if (data.containsKey('is_period_start_day')) {
      context.handle(
          _isPeriodStartDayMeta,
          isPeriodStartDay.isAcceptableOrUnknown(
              data['is_period_start_day']!, _isPeriodStartDayMeta));
    }
    if (data.containsKey('is_period_end_day')) {
      context.handle(
          _isPeriodEndDayMeta,
          isPeriodEndDay.isAcceptableOrUnknown(
              data['is_period_end_day']!, _isPeriodEndDayMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {date, userId};
  @override
  AppPeriodDay map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppPeriodDay(
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      flowWeight: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}flow_weight']),
      isPeriodStartDay: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}is_period_start_day'])!,
      isPeriodEndDay: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}is_period_end_day'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
    );
  }

  @override
  $AppPeriodDaysTable createAlias(String alias) {
    return $AppPeriodDaysTable(attachedDatabase, alias);
  }
}

class AppPeriodDay extends DataClass implements Insertable<AppPeriodDay> {
  final DateTime date;
  final int? flowWeight;
  final bool isPeriodStartDay;
  final bool isPeriodEndDay;
  final String userId;
  const AppPeriodDay(
      {required this.date,
      this.flowWeight,
      required this.isPeriodStartDay,
      required this.isPeriodEndDay,
      required this.userId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || flowWeight != null) {
      map['flow_weight'] = Variable<int>(flowWeight);
    }
    map['is_period_start_day'] = Variable<bool>(isPeriodStartDay);
    map['is_period_end_day'] = Variable<bool>(isPeriodEndDay);
    map['user_id'] = Variable<String>(userId);
    return map;
  }

  AppPeriodDaysCompanion toCompanion(bool nullToAbsent) {
    return AppPeriodDaysCompanion(
      date: Value(date),
      flowWeight: flowWeight == null && nullToAbsent
          ? const Value.absent()
          : Value(flowWeight),
      isPeriodStartDay: Value(isPeriodStartDay),
      isPeriodEndDay: Value(isPeriodEndDay),
      userId: Value(userId),
    );
  }

  factory AppPeriodDay.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppPeriodDay(
      date: serializer.fromJson<DateTime>(json['date']),
      flowWeight: serializer.fromJson<int?>(json['flowWeight']),
      isPeriodStartDay: serializer.fromJson<bool>(json['isPeriodStartDay']),
      isPeriodEndDay: serializer.fromJson<bool>(json['isPeriodEndDay']),
      userId: serializer.fromJson<String>(json['userId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'date': serializer.toJson<DateTime>(date),
      'flowWeight': serializer.toJson<int?>(flowWeight),
      'isPeriodStartDay': serializer.toJson<bool>(isPeriodStartDay),
      'isPeriodEndDay': serializer.toJson<bool>(isPeriodEndDay),
      'userId': serializer.toJson<String>(userId),
    };
  }

  AppPeriodDay copyWith(
          {DateTime? date,
          Value<int?> flowWeight = const Value.absent(),
          bool? isPeriodStartDay,
          bool? isPeriodEndDay,
          String? userId}) =>
      AppPeriodDay(
        date: date ?? this.date,
        flowWeight: flowWeight.present ? flowWeight.value : this.flowWeight,
        isPeriodStartDay: isPeriodStartDay ?? this.isPeriodStartDay,
        isPeriodEndDay: isPeriodEndDay ?? this.isPeriodEndDay,
        userId: userId ?? this.userId,
      );
  AppPeriodDay copyWithCompanion(AppPeriodDaysCompanion data) {
    return AppPeriodDay(
      date: data.date.present ? data.date.value : this.date,
      flowWeight:
          data.flowWeight.present ? data.flowWeight.value : this.flowWeight,
      isPeriodStartDay: data.isPeriodStartDay.present
          ? data.isPeriodStartDay.value
          : this.isPeriodStartDay,
      isPeriodEndDay: data.isPeriodEndDay.present
          ? data.isPeriodEndDay.value
          : this.isPeriodEndDay,
      userId: data.userId.present ? data.userId.value : this.userId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppPeriodDay(')
          ..write('date: $date, ')
          ..write('flowWeight: $flowWeight, ')
          ..write('isPeriodStartDay: $isPeriodStartDay, ')
          ..write('isPeriodEndDay: $isPeriodEndDay, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(date, flowWeight, isPeriodStartDay, isPeriodEndDay, userId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppPeriodDay &&
          other.date == this.date &&
          other.flowWeight == this.flowWeight &&
          other.isPeriodStartDay == this.isPeriodStartDay &&
          other.isPeriodEndDay == this.isPeriodEndDay &&
          other.userId == this.userId);
}

class AppPeriodDaysCompanion extends UpdateCompanion<AppPeriodDay> {
  final Value<DateTime> date;
  final Value<int?> flowWeight;
  final Value<bool> isPeriodStartDay;
  final Value<bool> isPeriodEndDay;
  final Value<String> userId;
  final Value<int> rowid;
  const AppPeriodDaysCompanion({
    this.date = const Value.absent(),
    this.flowWeight = const Value.absent(),
    this.isPeriodStartDay = const Value.absent(),
    this.isPeriodEndDay = const Value.absent(),
    this.userId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppPeriodDaysCompanion.insert({
    required DateTime date,
    this.flowWeight = const Value.absent(),
    this.isPeriodStartDay = const Value.absent(),
    this.isPeriodEndDay = const Value.absent(),
    required String userId,
    this.rowid = const Value.absent(),
  })  : date = Value(date),
        userId = Value(userId);
  static Insertable<AppPeriodDay> custom({
    Expression<DateTime>? date,
    Expression<int>? flowWeight,
    Expression<bool>? isPeriodStartDay,
    Expression<bool>? isPeriodEndDay,
    Expression<String>? userId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (date != null) 'date': date,
      if (flowWeight != null) 'flow_weight': flowWeight,
      if (isPeriodStartDay != null) 'is_period_start_day': isPeriodStartDay,
      if (isPeriodEndDay != null) 'is_period_end_day': isPeriodEndDay,
      if (userId != null) 'user_id': userId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppPeriodDaysCompanion copyWith(
      {Value<DateTime>? date,
      Value<int?>? flowWeight,
      Value<bool>? isPeriodStartDay,
      Value<bool>? isPeriodEndDay,
      Value<String>? userId,
      Value<int>? rowid}) {
    return AppPeriodDaysCompanion(
      date: date ?? this.date,
      flowWeight: flowWeight ?? this.flowWeight,
      isPeriodStartDay: isPeriodStartDay ?? this.isPeriodStartDay,
      isPeriodEndDay: isPeriodEndDay ?? this.isPeriodEndDay,
      userId: userId ?? this.userId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (flowWeight.present) {
      map['flow_weight'] = Variable<int>(flowWeight.value);
    }
    if (isPeriodStartDay.present) {
      map['is_period_start_day'] = Variable<bool>(isPeriodStartDay.value);
    }
    if (isPeriodEndDay.present) {
      map['is_period_end_day'] = Variable<bool>(isPeriodEndDay.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppPeriodDaysCompanion(')
          ..write('date: $date, ')
          ..write('flowWeight: $flowWeight, ')
          ..write('isPeriodStartDay: $isPeriodStartDay, ')
          ..write('isPeriodEndDay: $isPeriodEndDay, ')
          ..write('userId: $userId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppMoodsTable extends AppMoods with TableInfo<$AppMoodsTable, AppMood> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppMoodsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [date, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_moods';
  @override
  VerificationContext validateIntegrity(Insertable<AppMood> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  AppMood map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppMood(
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $AppMoodsTable createAlias(String alias) {
    return $AppMoodsTable(attachedDatabase, alias);
  }
}

class AppMood extends DataClass implements Insertable<AppMood> {
  final DateTime date;
  final String name;
  const AppMood({required this.date, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['date'] = Variable<DateTime>(date);
    map['name'] = Variable<String>(name);
    return map;
  }

  AppMoodsCompanion toCompanion(bool nullToAbsent) {
    return AppMoodsCompanion(
      date: Value(date),
      name: Value(name),
    );
  }

  factory AppMood.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppMood(
      date: serializer.fromJson<DateTime>(json['date']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'date': serializer.toJson<DateTime>(date),
      'name': serializer.toJson<String>(name),
    };
  }

  AppMood copyWith({DateTime? date, String? name}) => AppMood(
        date: date ?? this.date,
        name: name ?? this.name,
      );
  AppMood copyWithCompanion(AppMoodsCompanion data) {
    return AppMood(
      date: data.date.present ? data.date.value : this.date,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppMood(')
          ..write('date: $date, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(date, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppMood && other.date == this.date && other.name == this.name);
}

class AppMoodsCompanion extends UpdateCompanion<AppMood> {
  final Value<DateTime> date;
  final Value<String> name;
  final Value<int> rowid;
  const AppMoodsCompanion({
    this.date = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppMoodsCompanion.insert({
    required DateTime date,
    required String name,
    this.rowid = const Value.absent(),
  })  : date = Value(date),
        name = Value(name);
  static Insertable<AppMood> custom({
    Expression<DateTime>? date,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (date != null) 'date': date,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppMoodsCompanion copyWith(
      {Value<DateTime>? date, Value<String>? name, Value<int>? rowid}) {
    return AppMoodsCompanion(
      date: date ?? this.date,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppMoodsCompanion(')
          ..write('date: $date, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppSymptomsTable extends AppSymptoms
    with TableInfo<$AppSymptomsTable, AppSymptom> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSymptomsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [date, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_symptoms';
  @override
  VerificationContext validateIntegrity(Insertable<AppSymptom> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  AppSymptom map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSymptom(
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $AppSymptomsTable createAlias(String alias) {
    return $AppSymptomsTable(attachedDatabase, alias);
  }
}

class AppSymptom extends DataClass implements Insertable<AppSymptom> {
  final DateTime date;
  final String name;
  const AppSymptom({required this.date, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['date'] = Variable<DateTime>(date);
    map['name'] = Variable<String>(name);
    return map;
  }

  AppSymptomsCompanion toCompanion(bool nullToAbsent) {
    return AppSymptomsCompanion(
      date: Value(date),
      name: Value(name),
    );
  }

  factory AppSymptom.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSymptom(
      date: serializer.fromJson<DateTime>(json['date']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'date': serializer.toJson<DateTime>(date),
      'name': serializer.toJson<String>(name),
    };
  }

  AppSymptom copyWith({DateTime? date, String? name}) => AppSymptom(
        date: date ?? this.date,
        name: name ?? this.name,
      );
  AppSymptom copyWithCompanion(AppSymptomsCompanion data) {
    return AppSymptom(
      date: data.date.present ? data.date.value : this.date,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSymptom(')
          ..write('date: $date, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(date, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSymptom &&
          other.date == this.date &&
          other.name == this.name);
}

class AppSymptomsCompanion extends UpdateCompanion<AppSymptom> {
  final Value<DateTime> date;
  final Value<String> name;
  final Value<int> rowid;
  const AppSymptomsCompanion({
    this.date = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSymptomsCompanion.insert({
    required DateTime date,
    required String name,
    this.rowid = const Value.absent(),
  })  : date = Value(date),
        name = Value(name);
  static Insertable<AppSymptom> custom({
    Expression<DateTime>? date,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (date != null) 'date': date,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSymptomsCompanion copyWith(
      {Value<DateTime>? date, Value<String>? name, Value<int>? rowid}) {
    return AppSymptomsCompanion(
      date: date ?? this.date,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSymptomsCompanion(')
          ..write('date: $date, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppUsersTable extends AppUsers with TableInfo<$AppUsersTable, AppUser> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppUsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _surnameMeta =
      const VerificationMeta('surname');
  @override
  late final GeneratedColumn<String> surname = GeneratedColumn<String>(
      'surname', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _birthdayMeta =
      const VerificationMeta('birthday');
  @override
  late final GeneratedColumn<DateTime> birthday = GeneratedColumn<DateTime>(
      'birthday', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _avgCycleLengthMeta =
      const VerificationMeta('avgCycleLength');
  @override
  late final GeneratedColumn<int> avgCycleLength = GeneratedColumn<int>(
      'avg_cycle_length', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _avgPeriodLengthMeta =
      const VerificationMeta('avgPeriodLength');
  @override
  late final GeneratedColumn<int> avgPeriodLength = GeneratedColumn<int>(
      'avg_period_length', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _lastestCycleStartMeta =
      const VerificationMeta('lastestCycleStart');
  @override
  late final GeneratedColumn<DateTime> lastestCycleStart =
      GeneratedColumn<DateTime>('lastest_cycle_start', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        surname,
        email,
        birthday,
        avgCycleLength,
        avgPeriodLength,
        lastestCycleStart
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_users';
  @override
  VerificationContext validateIntegrity(Insertable<AppUser> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('surname')) {
      context.handle(_surnameMeta,
          surname.isAcceptableOrUnknown(data['surname']!, _surnameMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('birthday')) {
      context.handle(_birthdayMeta,
          birthday.isAcceptableOrUnknown(data['birthday']!, _birthdayMeta));
    }
    if (data.containsKey('avg_cycle_length')) {
      context.handle(
          _avgCycleLengthMeta,
          avgCycleLength.isAcceptableOrUnknown(
              data['avg_cycle_length']!, _avgCycleLengthMeta));
    }
    if (data.containsKey('avg_period_length')) {
      context.handle(
          _avgPeriodLengthMeta,
          avgPeriodLength.isAcceptableOrUnknown(
              data['avg_period_length']!, _avgPeriodLengthMeta));
    }
    if (data.containsKey('lastest_cycle_start')) {
      context.handle(
          _lastestCycleStartMeta,
          lastestCycleStart.isAcceptableOrUnknown(
              data['lastest_cycle_start']!, _lastestCycleStartMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppUser map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppUser(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      surname: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}surname']),
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      birthday: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}birthday']),
      avgCycleLength: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}avg_cycle_length']),
      avgPeriodLength: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}avg_period_length']),
      lastestCycleStart: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}lastest_cycle_start']),
    );
  }

  @override
  $AppUsersTable createAlias(String alias) {
    return $AppUsersTable(attachedDatabase, alias);
  }
}

class AppUser extends DataClass implements Insertable<AppUser> {
  final String id;
  final String name;
  final String? surname;
  final String? email;
  final DateTime? birthday;
  final int? avgCycleLength;
  final int? avgPeriodLength;
  final DateTime? lastestCycleStart;
  const AppUser(
      {required this.id,
      required this.name,
      this.surname,
      this.email,
      this.birthday,
      this.avgCycleLength,
      this.avgPeriodLength,
      this.lastestCycleStart});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || surname != null) {
      map['surname'] = Variable<String>(surname);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || birthday != null) {
      map['birthday'] = Variable<DateTime>(birthday);
    }
    if (!nullToAbsent || avgCycleLength != null) {
      map['avg_cycle_length'] = Variable<int>(avgCycleLength);
    }
    if (!nullToAbsent || avgPeriodLength != null) {
      map['avg_period_length'] = Variable<int>(avgPeriodLength);
    }
    if (!nullToAbsent || lastestCycleStart != null) {
      map['lastest_cycle_start'] = Variable<DateTime>(lastestCycleStart);
    }
    return map;
  }

  AppUsersCompanion toCompanion(bool nullToAbsent) {
    return AppUsersCompanion(
      id: Value(id),
      name: Value(name),
      surname: surname == null && nullToAbsent
          ? const Value.absent()
          : Value(surname),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      birthday: birthday == null && nullToAbsent
          ? const Value.absent()
          : Value(birthday),
      avgCycleLength: avgCycleLength == null && nullToAbsent
          ? const Value.absent()
          : Value(avgCycleLength),
      avgPeriodLength: avgPeriodLength == null && nullToAbsent
          ? const Value.absent()
          : Value(avgPeriodLength),
      lastestCycleStart: lastestCycleStart == null && nullToAbsent
          ? const Value.absent()
          : Value(lastestCycleStart),
    );
  }

  factory AppUser.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppUser(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      surname: serializer.fromJson<String?>(json['surname']),
      email: serializer.fromJson<String?>(json['email']),
      birthday: serializer.fromJson<DateTime?>(json['birthday']),
      avgCycleLength: serializer.fromJson<int?>(json['avgCycleLength']),
      avgPeriodLength: serializer.fromJson<int?>(json['avgPeriodLength']),
      lastestCycleStart:
          serializer.fromJson<DateTime?>(json['lastestCycleStart']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'surname': serializer.toJson<String?>(surname),
      'email': serializer.toJson<String?>(email),
      'birthday': serializer.toJson<DateTime?>(birthday),
      'avgCycleLength': serializer.toJson<int?>(avgCycleLength),
      'avgPeriodLength': serializer.toJson<int?>(avgPeriodLength),
      'lastestCycleStart': serializer.toJson<DateTime?>(lastestCycleStart),
    };
  }

  AppUser copyWith(
          {String? id,
          String? name,
          Value<String?> surname = const Value.absent(),
          Value<String?> email = const Value.absent(),
          Value<DateTime?> birthday = const Value.absent(),
          Value<int?> avgCycleLength = const Value.absent(),
          Value<int?> avgPeriodLength = const Value.absent(),
          Value<DateTime?> lastestCycleStart = const Value.absent()}) =>
      AppUser(
        id: id ?? this.id,
        name: name ?? this.name,
        surname: surname.present ? surname.value : this.surname,
        email: email.present ? email.value : this.email,
        birthday: birthday.present ? birthday.value : this.birthday,
        avgCycleLength:
            avgCycleLength.present ? avgCycleLength.value : this.avgCycleLength,
        avgPeriodLength: avgPeriodLength.present
            ? avgPeriodLength.value
            : this.avgPeriodLength,
        lastestCycleStart: lastestCycleStart.present
            ? lastestCycleStart.value
            : this.lastestCycleStart,
      );
  AppUser copyWithCompanion(AppUsersCompanion data) {
    return AppUser(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      surname: data.surname.present ? data.surname.value : this.surname,
      email: data.email.present ? data.email.value : this.email,
      birthday: data.birthday.present ? data.birthday.value : this.birthday,
      avgCycleLength: data.avgCycleLength.present
          ? data.avgCycleLength.value
          : this.avgCycleLength,
      avgPeriodLength: data.avgPeriodLength.present
          ? data.avgPeriodLength.value
          : this.avgPeriodLength,
      lastestCycleStart: data.lastestCycleStart.present
          ? data.lastestCycleStart.value
          : this.lastestCycleStart,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppUser(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('surname: $surname, ')
          ..write('email: $email, ')
          ..write('birthday: $birthday, ')
          ..write('avgCycleLength: $avgCycleLength, ')
          ..write('avgPeriodLength: $avgPeriodLength, ')
          ..write('lastestCycleStart: $lastestCycleStart')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, surname, email, birthday,
      avgCycleLength, avgPeriodLength, lastestCycleStart);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppUser &&
          other.id == this.id &&
          other.name == this.name &&
          other.surname == this.surname &&
          other.email == this.email &&
          other.birthday == this.birthday &&
          other.avgCycleLength == this.avgCycleLength &&
          other.avgPeriodLength == this.avgPeriodLength &&
          other.lastestCycleStart == this.lastestCycleStart);
}

class AppUsersCompanion extends UpdateCompanion<AppUser> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> surname;
  final Value<String?> email;
  final Value<DateTime?> birthday;
  final Value<int?> avgCycleLength;
  final Value<int?> avgPeriodLength;
  final Value<DateTime?> lastestCycleStart;
  final Value<int> rowid;
  const AppUsersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.surname = const Value.absent(),
    this.email = const Value.absent(),
    this.birthday = const Value.absent(),
    this.avgCycleLength = const Value.absent(),
    this.avgPeriodLength = const Value.absent(),
    this.lastestCycleStart = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppUsersCompanion.insert({
    required String id,
    required String name,
    this.surname = const Value.absent(),
    this.email = const Value.absent(),
    this.birthday = const Value.absent(),
    this.avgCycleLength = const Value.absent(),
    this.avgPeriodLength = const Value.absent(),
    this.lastestCycleStart = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<AppUser> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? surname,
    Expression<String>? email,
    Expression<DateTime>? birthday,
    Expression<int>? avgCycleLength,
    Expression<int>? avgPeriodLength,
    Expression<DateTime>? lastestCycleStart,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (surname != null) 'surname': surname,
      if (email != null) 'email': email,
      if (birthday != null) 'birthday': birthday,
      if (avgCycleLength != null) 'avg_cycle_length': avgCycleLength,
      if (avgPeriodLength != null) 'avg_period_length': avgPeriodLength,
      if (lastestCycleStart != null) 'lastest_cycle_start': lastestCycleStart,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppUsersCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? surname,
      Value<String?>? email,
      Value<DateTime?>? birthday,
      Value<int?>? avgCycleLength,
      Value<int?>? avgPeriodLength,
      Value<DateTime?>? lastestCycleStart,
      Value<int>? rowid}) {
    return AppUsersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      email: email ?? this.email,
      birthday: birthday ?? this.birthday,
      avgCycleLength: avgCycleLength ?? this.avgCycleLength,
      avgPeriodLength: avgPeriodLength ?? this.avgPeriodLength,
      lastestCycleStart: lastestCycleStart ?? this.lastestCycleStart,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (surname.present) {
      map['surname'] = Variable<String>(surname.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (birthday.present) {
      map['birthday'] = Variable<DateTime>(birthday.value);
    }
    if (avgCycleLength.present) {
      map['avg_cycle_length'] = Variable<int>(avgCycleLength.value);
    }
    if (avgPeriodLength.present) {
      map['avg_period_length'] = Variable<int>(avgPeriodLength.value);
    }
    if (lastestCycleStart.present) {
      map['lastest_cycle_start'] = Variable<DateTime>(lastestCycleStart.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppUsersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('surname: $surname, ')
          ..write('email: $email, ')
          ..write('birthday: $birthday, ')
          ..write('avgCycleLength: $avgCycleLength, ')
          ..write('avgPeriodLength: $avgPeriodLength, ')
          ..write('lastestCycleStart: $lastestCycleStart, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppNotesTable extends AppNotes with TableInfo<$AppNotesTable, AppNote> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppNotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, userId, title, content, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_notes';
  @override
  VerificationContext validateIntegrity(Insertable<AppNote> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppNote map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppNote(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $AppNotesTable createAlias(String alias) {
    return $AppNotesTable(attachedDatabase, alias);
  }
}

class AppNote extends DataClass implements Insertable<AppNote> {
  final int id;
  final String userId;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  const AppNote(
      {required this.id,
      required this.userId,
      required this.title,
      required this.content,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['title'] = Variable<String>(title);
    map['content'] = Variable<String>(content);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AppNotesCompanion toCompanion(bool nullToAbsent) {
    return AppNotesCompanion(
      id: Value(id),
      userId: Value(userId),
      title: Value(title),
      content: Value(content),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory AppNote.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppNote(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      title: serializer.fromJson<String>(json['title']),
      content: serializer.fromJson<String>(json['content']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'title': serializer.toJson<String>(title),
      'content': serializer.toJson<String>(content),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AppNote copyWith(
          {int? id,
          String? userId,
          String? title,
          String? content,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      AppNote(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        title: title ?? this.title,
        content: content ?? this.content,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  AppNote copyWithCompanion(AppNotesCompanion data) {
    return AppNote(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      title: data.title.present ? data.title.value : this.title,
      content: data.content.present ? data.content.value : this.content,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppNote(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userId, title, content, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppNote &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.title == this.title &&
          other.content == this.content &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class AppNotesCompanion extends UpdateCompanion<AppNote> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> title;
  final Value<String> content;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const AppNotesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  AppNotesCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String title,
    required String content,
    required DateTime createdAt,
    required DateTime updatedAt,
  })  : userId = Value(userId),
        title = Value(title),
        content = Value(content),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<AppNote> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? title,
    Expression<String>? content,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  AppNotesCompanion copyWith(
      {Value<int>? id,
      Value<String>? userId,
      Value<String>? title,
      Value<String>? content,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return AppNotesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      content: content ?? this.content,
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
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
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
    return (StringBuffer('AppNotesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $AppCyclesTable extends AppCycles
    with TableInfo<$AppCyclesTable, AppCycle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppCyclesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'start_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _periodEndDateMeta =
      const VerificationMeta('periodEndDate');
  @override
  late final GeneratedColumn<DateTime> periodEndDate =
      GeneratedColumn<DateTime>('period_end_date', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
      'end_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, startDate, periodEndDate, endDate, userId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_cycles';
  @override
  VerificationContext validateIntegrity(Insertable<AppCycle> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('period_end_date')) {
      context.handle(
          _periodEndDateMeta,
          periodEndDate.isAcceptableOrUnknown(
              data['period_end_date']!, _periodEndDateMeta));
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppCycle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppCycle(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_date'])!,
      periodEndDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}period_end_date']),
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_date']),
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
    );
  }

  @override
  $AppCyclesTable createAlias(String alias) {
    return $AppCyclesTable(attachedDatabase, alias);
  }
}

class AppCycle extends DataClass implements Insertable<AppCycle> {
  final int id;
  final DateTime startDate;
  final DateTime? periodEndDate;
  final DateTime? endDate;
  final String userId;
  const AppCycle(
      {required this.id,
      required this.startDate,
      this.periodEndDate,
      this.endDate,
      required this.userId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['start_date'] = Variable<DateTime>(startDate);
    if (!nullToAbsent || periodEndDate != null) {
      map['period_end_date'] = Variable<DateTime>(periodEndDate);
    }
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    map['user_id'] = Variable<String>(userId);
    return map;
  }

  AppCyclesCompanion toCompanion(bool nullToAbsent) {
    return AppCyclesCompanion(
      id: Value(id),
      startDate: Value(startDate),
      periodEndDate: periodEndDate == null && nullToAbsent
          ? const Value.absent()
          : Value(periodEndDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      userId: Value(userId),
    );
  }

  factory AppCycle.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppCycle(
      id: serializer.fromJson<int>(json['id']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      periodEndDate: serializer.fromJson<DateTime?>(json['periodEndDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      userId: serializer.fromJson<String>(json['userId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'startDate': serializer.toJson<DateTime>(startDate),
      'periodEndDate': serializer.toJson<DateTime?>(periodEndDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'userId': serializer.toJson<String>(userId),
    };
  }

  AppCycle copyWith(
          {int? id,
          DateTime? startDate,
          Value<DateTime?> periodEndDate = const Value.absent(),
          Value<DateTime?> endDate = const Value.absent(),
          String? userId}) =>
      AppCycle(
        id: id ?? this.id,
        startDate: startDate ?? this.startDate,
        periodEndDate:
            periodEndDate.present ? periodEndDate.value : this.periodEndDate,
        endDate: endDate.present ? endDate.value : this.endDate,
        userId: userId ?? this.userId,
      );
  AppCycle copyWithCompanion(AppCyclesCompanion data) {
    return AppCycle(
      id: data.id.present ? data.id.value : this.id,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      periodEndDate: data.periodEndDate.present
          ? data.periodEndDate.value
          : this.periodEndDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      userId: data.userId.present ? data.userId.value : this.userId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppCycle(')
          ..write('id: $id, ')
          ..write('startDate: $startDate, ')
          ..write('periodEndDate: $periodEndDate, ')
          ..write('endDate: $endDate, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, startDate, periodEndDate, endDate, userId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppCycle &&
          other.id == this.id &&
          other.startDate == this.startDate &&
          other.periodEndDate == this.periodEndDate &&
          other.endDate == this.endDate &&
          other.userId == this.userId);
}

class AppCyclesCompanion extends UpdateCompanion<AppCycle> {
  final Value<int> id;
  final Value<DateTime> startDate;
  final Value<DateTime?> periodEndDate;
  final Value<DateTime?> endDate;
  final Value<String> userId;
  const AppCyclesCompanion({
    this.id = const Value.absent(),
    this.startDate = const Value.absent(),
    this.periodEndDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.userId = const Value.absent(),
  });
  AppCyclesCompanion.insert({
    this.id = const Value.absent(),
    required DateTime startDate,
    this.periodEndDate = const Value.absent(),
    this.endDate = const Value.absent(),
    required String userId,
  })  : startDate = Value(startDate),
        userId = Value(userId);
  static Insertable<AppCycle> custom({
    Expression<int>? id,
    Expression<DateTime>? startDate,
    Expression<DateTime>? periodEndDate,
    Expression<DateTime>? endDate,
    Expression<String>? userId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (startDate != null) 'start_date': startDate,
      if (periodEndDate != null) 'period_end_date': periodEndDate,
      if (endDate != null) 'end_date': endDate,
      if (userId != null) 'user_id': userId,
    });
  }

  AppCyclesCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? startDate,
      Value<DateTime?>? periodEndDate,
      Value<DateTime?>? endDate,
      Value<String>? userId}) {
    return AppCyclesCompanion(
      id: id ?? this.id,
      startDate: startDate ?? this.startDate,
      periodEndDate: periodEndDate ?? this.periodEndDate,
      endDate: endDate ?? this.endDate,
      userId: userId ?? this.userId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (periodEndDate.present) {
      map['period_end_date'] = Variable<DateTime>(periodEndDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppCyclesCompanion(')
          ..write('id: $id, ')
          ..write('startDate: $startDate, ')
          ..write('periodEndDate: $periodEndDate, ')
          ..write('endDate: $endDate, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AppUserSettingsTable appUserSettings =
      $AppUserSettingsTable(this);
  late final $AppDaysTable appDays = $AppDaysTable(this);
  late final $AppPeriodDaysTable appPeriodDays = $AppPeriodDaysTable(this);
  late final $AppMoodsTable appMoods = $AppMoodsTable(this);
  late final $AppSymptomsTable appSymptoms = $AppSymptomsTable(this);
  late final $AppUsersTable appUsers = $AppUsersTable(this);
  late final $AppNotesTable appNotes = $AppNotesTable(this);
  late final $AppCyclesTable appCycles = $AppCyclesTable(this);
  late final AppUserSettingsDao appUserSettingsDao =
      AppUserSettingsDao(this as AppDatabase);
  late final AppDaysDao appDaysDao = AppDaysDao(this as AppDatabase);
  late final AppPeriodDaysDao appPeriodDaysDao =
      AppPeriodDaysDao(this as AppDatabase);
  late final AppMoodsDao appMoodsDao = AppMoodsDao(this as AppDatabase);
  late final AppSymptomsDao appSymptomsDao =
      AppSymptomsDao(this as AppDatabase);
  late final AppUsersDao appUsersDao = AppUsersDao(this as AppDatabase);
  late final AppNotesDao appNotesDao = AppNotesDao(this as AppDatabase);
  late final AppCyclesDao appCyclesDao = AppCyclesDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        appUserSettings,
        appDays,
        appPeriodDays,
        appMoods,
        appSymptoms,
        appUsers,
        appNotes,
        appCycles
      ];
}

typedef $$AppUserSettingsTableCreateCompanionBuilder = AppUserSettingsCompanion
    Function({
  required String key,
  required String value,
  required String userId,
  Value<int> rowid,
});
typedef $$AppUserSettingsTableUpdateCompanionBuilder = AppUserSettingsCompanion
    Function({
  Value<String> key,
  Value<String> value,
  Value<String> userId,
  Value<int> rowid,
});

class $$AppUserSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppUserSettingsTable> {
  $$AppUserSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));
}

class $$AppUserSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppUserSettingsTable> {
  $$AppUserSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));
}

class $$AppUserSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppUserSettingsTable> {
  $$AppUserSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);
}

class $$AppUserSettingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AppUserSettingsTable,
    AppUserSetting,
    $$AppUserSettingsTableFilterComposer,
    $$AppUserSettingsTableOrderingComposer,
    $$AppUserSettingsTableAnnotationComposer,
    $$AppUserSettingsTableCreateCompanionBuilder,
    $$AppUserSettingsTableUpdateCompanionBuilder,
    (
      AppUserSetting,
      BaseReferences<_$AppDatabase, $AppUserSettingsTable, AppUserSetting>
    ),
    AppUserSetting,
    PrefetchHooks Function()> {
  $$AppUserSettingsTableTableManager(
      _$AppDatabase db, $AppUserSettingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppUserSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppUserSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppUserSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AppUserSettingsCompanion(
            key: key,
            value: value,
            userId: userId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String key,
            required String value,
            required String userId,
            Value<int> rowid = const Value.absent(),
          }) =>
              AppUserSettingsCompanion.insert(
            key: key,
            value: value,
            userId: userId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AppUserSettingsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AppUserSettingsTable,
    AppUserSetting,
    $$AppUserSettingsTableFilterComposer,
    $$AppUserSettingsTableOrderingComposer,
    $$AppUserSettingsTableAnnotationComposer,
    $$AppUserSettingsTableCreateCompanionBuilder,
    $$AppUserSettingsTableUpdateCompanionBuilder,
    (
      AppUserSetting,
      BaseReferences<_$AppDatabase, $AppUserSettingsTable, AppUserSetting>
    ),
    AppUserSetting,
    PrefetchHooks Function()>;
typedef $$AppDaysTableCreateCompanionBuilder = AppDaysCompanion Function({
  required DateTime date,
  Value<bool> isPeriodDay,
  Value<String?> note,
  Value<String?> symptomList,
  Value<String?> moodList,
  required String userId,
  Value<int> rowid,
});
typedef $$AppDaysTableUpdateCompanionBuilder = AppDaysCompanion Function({
  Value<DateTime> date,
  Value<bool> isPeriodDay,
  Value<String?> note,
  Value<String?> symptomList,
  Value<String?> moodList,
  Value<String> userId,
  Value<int> rowid,
});

class $$AppDaysTableFilterComposer
    extends Composer<_$AppDatabase, $AppDaysTable> {
  $$AppDaysTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isPeriodDay => $composableBuilder(
      column: $table.isPeriodDay, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get symptomList => $composableBuilder(
      column: $table.symptomList, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get moodList => $composableBuilder(
      column: $table.moodList, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));
}

class $$AppDaysTableOrderingComposer
    extends Composer<_$AppDatabase, $AppDaysTable> {
  $$AppDaysTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isPeriodDay => $composableBuilder(
      column: $table.isPeriodDay, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get symptomList => $composableBuilder(
      column: $table.symptomList, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get moodList => $composableBuilder(
      column: $table.moodList, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));
}

class $$AppDaysTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppDaysTable> {
  $$AppDaysTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<bool> get isPeriodDay => $composableBuilder(
      column: $table.isPeriodDay, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get symptomList => $composableBuilder(
      column: $table.symptomList, builder: (column) => column);

  GeneratedColumn<String> get moodList =>
      $composableBuilder(column: $table.moodList, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);
}

class $$AppDaysTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AppDaysTable,
    AppDay,
    $$AppDaysTableFilterComposer,
    $$AppDaysTableOrderingComposer,
    $$AppDaysTableAnnotationComposer,
    $$AppDaysTableCreateCompanionBuilder,
    $$AppDaysTableUpdateCompanionBuilder,
    (AppDay, BaseReferences<_$AppDatabase, $AppDaysTable, AppDay>),
    AppDay,
    PrefetchHooks Function()> {
  $$AppDaysTableTableManager(_$AppDatabase db, $AppDaysTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppDaysTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppDaysTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppDaysTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<DateTime> date = const Value.absent(),
            Value<bool> isPeriodDay = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<String?> symptomList = const Value.absent(),
            Value<String?> moodList = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AppDaysCompanion(
            date: date,
            isPeriodDay: isPeriodDay,
            note: note,
            symptomList: symptomList,
            moodList: moodList,
            userId: userId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required DateTime date,
            Value<bool> isPeriodDay = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<String?> symptomList = const Value.absent(),
            Value<String?> moodList = const Value.absent(),
            required String userId,
            Value<int> rowid = const Value.absent(),
          }) =>
              AppDaysCompanion.insert(
            date: date,
            isPeriodDay: isPeriodDay,
            note: note,
            symptomList: symptomList,
            moodList: moodList,
            userId: userId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AppDaysTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AppDaysTable,
    AppDay,
    $$AppDaysTableFilterComposer,
    $$AppDaysTableOrderingComposer,
    $$AppDaysTableAnnotationComposer,
    $$AppDaysTableCreateCompanionBuilder,
    $$AppDaysTableUpdateCompanionBuilder,
    (AppDay, BaseReferences<_$AppDatabase, $AppDaysTable, AppDay>),
    AppDay,
    PrefetchHooks Function()>;
typedef $$AppPeriodDaysTableCreateCompanionBuilder = AppPeriodDaysCompanion
    Function({
  required DateTime date,
  Value<int?> flowWeight,
  Value<bool> isPeriodStartDay,
  Value<bool> isPeriodEndDay,
  required String userId,
  Value<int> rowid,
});
typedef $$AppPeriodDaysTableUpdateCompanionBuilder = AppPeriodDaysCompanion
    Function({
  Value<DateTime> date,
  Value<int?> flowWeight,
  Value<bool> isPeriodStartDay,
  Value<bool> isPeriodEndDay,
  Value<String> userId,
  Value<int> rowid,
});

class $$AppPeriodDaysTableFilterComposer
    extends Composer<_$AppDatabase, $AppPeriodDaysTable> {
  $$AppPeriodDaysTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get flowWeight => $composableBuilder(
      column: $table.flowWeight, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isPeriodStartDay => $composableBuilder(
      column: $table.isPeriodStartDay,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isPeriodEndDay => $composableBuilder(
      column: $table.isPeriodEndDay,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));
}

class $$AppPeriodDaysTableOrderingComposer
    extends Composer<_$AppDatabase, $AppPeriodDaysTable> {
  $$AppPeriodDaysTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get flowWeight => $composableBuilder(
      column: $table.flowWeight, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isPeriodStartDay => $composableBuilder(
      column: $table.isPeriodStartDay,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isPeriodEndDay => $composableBuilder(
      column: $table.isPeriodEndDay,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));
}

class $$AppPeriodDaysTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppPeriodDaysTable> {
  $$AppPeriodDaysTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get flowWeight => $composableBuilder(
      column: $table.flowWeight, builder: (column) => column);

  GeneratedColumn<bool> get isPeriodStartDay => $composableBuilder(
      column: $table.isPeriodStartDay, builder: (column) => column);

  GeneratedColumn<bool> get isPeriodEndDay => $composableBuilder(
      column: $table.isPeriodEndDay, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);
}

class $$AppPeriodDaysTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AppPeriodDaysTable,
    AppPeriodDay,
    $$AppPeriodDaysTableFilterComposer,
    $$AppPeriodDaysTableOrderingComposer,
    $$AppPeriodDaysTableAnnotationComposer,
    $$AppPeriodDaysTableCreateCompanionBuilder,
    $$AppPeriodDaysTableUpdateCompanionBuilder,
    (
      AppPeriodDay,
      BaseReferences<_$AppDatabase, $AppPeriodDaysTable, AppPeriodDay>
    ),
    AppPeriodDay,
    PrefetchHooks Function()> {
  $$AppPeriodDaysTableTableManager(_$AppDatabase db, $AppPeriodDaysTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppPeriodDaysTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppPeriodDaysTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppPeriodDaysTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<DateTime> date = const Value.absent(),
            Value<int?> flowWeight = const Value.absent(),
            Value<bool> isPeriodStartDay = const Value.absent(),
            Value<bool> isPeriodEndDay = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AppPeriodDaysCompanion(
            date: date,
            flowWeight: flowWeight,
            isPeriodStartDay: isPeriodStartDay,
            isPeriodEndDay: isPeriodEndDay,
            userId: userId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required DateTime date,
            Value<int?> flowWeight = const Value.absent(),
            Value<bool> isPeriodStartDay = const Value.absent(),
            Value<bool> isPeriodEndDay = const Value.absent(),
            required String userId,
            Value<int> rowid = const Value.absent(),
          }) =>
              AppPeriodDaysCompanion.insert(
            date: date,
            flowWeight: flowWeight,
            isPeriodStartDay: isPeriodStartDay,
            isPeriodEndDay: isPeriodEndDay,
            userId: userId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AppPeriodDaysTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AppPeriodDaysTable,
    AppPeriodDay,
    $$AppPeriodDaysTableFilterComposer,
    $$AppPeriodDaysTableOrderingComposer,
    $$AppPeriodDaysTableAnnotationComposer,
    $$AppPeriodDaysTableCreateCompanionBuilder,
    $$AppPeriodDaysTableUpdateCompanionBuilder,
    (
      AppPeriodDay,
      BaseReferences<_$AppDatabase, $AppPeriodDaysTable, AppPeriodDay>
    ),
    AppPeriodDay,
    PrefetchHooks Function()>;
typedef $$AppMoodsTableCreateCompanionBuilder = AppMoodsCompanion Function({
  required DateTime date,
  required String name,
  Value<int> rowid,
});
typedef $$AppMoodsTableUpdateCompanionBuilder = AppMoodsCompanion Function({
  Value<DateTime> date,
  Value<String> name,
  Value<int> rowid,
});

class $$AppMoodsTableFilterComposer
    extends Composer<_$AppDatabase, $AppMoodsTable> {
  $$AppMoodsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));
}

class $$AppMoodsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppMoodsTable> {
  $$AppMoodsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));
}

class $$AppMoodsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppMoodsTable> {
  $$AppMoodsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);
}

class $$AppMoodsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AppMoodsTable,
    AppMood,
    $$AppMoodsTableFilterComposer,
    $$AppMoodsTableOrderingComposer,
    $$AppMoodsTableAnnotationComposer,
    $$AppMoodsTableCreateCompanionBuilder,
    $$AppMoodsTableUpdateCompanionBuilder,
    (AppMood, BaseReferences<_$AppDatabase, $AppMoodsTable, AppMood>),
    AppMood,
    PrefetchHooks Function()> {
  $$AppMoodsTableTableManager(_$AppDatabase db, $AppMoodsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppMoodsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppMoodsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppMoodsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<DateTime> date = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AppMoodsCompanion(
            date: date,
            name: name,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required DateTime date,
            required String name,
            Value<int> rowid = const Value.absent(),
          }) =>
              AppMoodsCompanion.insert(
            date: date,
            name: name,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AppMoodsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AppMoodsTable,
    AppMood,
    $$AppMoodsTableFilterComposer,
    $$AppMoodsTableOrderingComposer,
    $$AppMoodsTableAnnotationComposer,
    $$AppMoodsTableCreateCompanionBuilder,
    $$AppMoodsTableUpdateCompanionBuilder,
    (AppMood, BaseReferences<_$AppDatabase, $AppMoodsTable, AppMood>),
    AppMood,
    PrefetchHooks Function()>;
typedef $$AppSymptomsTableCreateCompanionBuilder = AppSymptomsCompanion
    Function({
  required DateTime date,
  required String name,
  Value<int> rowid,
});
typedef $$AppSymptomsTableUpdateCompanionBuilder = AppSymptomsCompanion
    Function({
  Value<DateTime> date,
  Value<String> name,
  Value<int> rowid,
});

class $$AppSymptomsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSymptomsTable> {
  $$AppSymptomsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));
}

class $$AppSymptomsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSymptomsTable> {
  $$AppSymptomsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));
}

class $$AppSymptomsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSymptomsTable> {
  $$AppSymptomsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);
}

class $$AppSymptomsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AppSymptomsTable,
    AppSymptom,
    $$AppSymptomsTableFilterComposer,
    $$AppSymptomsTableOrderingComposer,
    $$AppSymptomsTableAnnotationComposer,
    $$AppSymptomsTableCreateCompanionBuilder,
    $$AppSymptomsTableUpdateCompanionBuilder,
    (AppSymptom, BaseReferences<_$AppDatabase, $AppSymptomsTable, AppSymptom>),
    AppSymptom,
    PrefetchHooks Function()> {
  $$AppSymptomsTableTableManager(_$AppDatabase db, $AppSymptomsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSymptomsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSymptomsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSymptomsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<DateTime> date = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AppSymptomsCompanion(
            date: date,
            name: name,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required DateTime date,
            required String name,
            Value<int> rowid = const Value.absent(),
          }) =>
              AppSymptomsCompanion.insert(
            date: date,
            name: name,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AppSymptomsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AppSymptomsTable,
    AppSymptom,
    $$AppSymptomsTableFilterComposer,
    $$AppSymptomsTableOrderingComposer,
    $$AppSymptomsTableAnnotationComposer,
    $$AppSymptomsTableCreateCompanionBuilder,
    $$AppSymptomsTableUpdateCompanionBuilder,
    (AppSymptom, BaseReferences<_$AppDatabase, $AppSymptomsTable, AppSymptom>),
    AppSymptom,
    PrefetchHooks Function()>;
typedef $$AppUsersTableCreateCompanionBuilder = AppUsersCompanion Function({
  required String id,
  required String name,
  Value<String?> surname,
  Value<String?> email,
  Value<DateTime?> birthday,
  Value<int?> avgCycleLength,
  Value<int?> avgPeriodLength,
  Value<DateTime?> lastestCycleStart,
  Value<int> rowid,
});
typedef $$AppUsersTableUpdateCompanionBuilder = AppUsersCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> surname,
  Value<String?> email,
  Value<DateTime?> birthday,
  Value<int?> avgCycleLength,
  Value<int?> avgPeriodLength,
  Value<DateTime?> lastestCycleStart,
  Value<int> rowid,
});

class $$AppUsersTableFilterComposer
    extends Composer<_$AppDatabase, $AppUsersTable> {
  $$AppUsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get surname => $composableBuilder(
      column: $table.surname, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get birthday => $composableBuilder(
      column: $table.birthday, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get avgCycleLength => $composableBuilder(
      column: $table.avgCycleLength,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get avgPeriodLength => $composableBuilder(
      column: $table.avgPeriodLength,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastestCycleStart => $composableBuilder(
      column: $table.lastestCycleStart,
      builder: (column) => ColumnFilters(column));
}

class $$AppUsersTableOrderingComposer
    extends Composer<_$AppDatabase, $AppUsersTable> {
  $$AppUsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get surname => $composableBuilder(
      column: $table.surname, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get birthday => $composableBuilder(
      column: $table.birthday, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get avgCycleLength => $composableBuilder(
      column: $table.avgCycleLength,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get avgPeriodLength => $composableBuilder(
      column: $table.avgPeriodLength,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastestCycleStart => $composableBuilder(
      column: $table.lastestCycleStart,
      builder: (column) => ColumnOrderings(column));
}

class $$AppUsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppUsersTable> {
  $$AppUsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get surname =>
      $composableBuilder(column: $table.surname, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<DateTime> get birthday =>
      $composableBuilder(column: $table.birthday, builder: (column) => column);

  GeneratedColumn<int> get avgCycleLength => $composableBuilder(
      column: $table.avgCycleLength, builder: (column) => column);

  GeneratedColumn<int> get avgPeriodLength => $composableBuilder(
      column: $table.avgPeriodLength, builder: (column) => column);

  GeneratedColumn<DateTime> get lastestCycleStart => $composableBuilder(
      column: $table.lastestCycleStart, builder: (column) => column);
}

class $$AppUsersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AppUsersTable,
    AppUser,
    $$AppUsersTableFilterComposer,
    $$AppUsersTableOrderingComposer,
    $$AppUsersTableAnnotationComposer,
    $$AppUsersTableCreateCompanionBuilder,
    $$AppUsersTableUpdateCompanionBuilder,
    (AppUser, BaseReferences<_$AppDatabase, $AppUsersTable, AppUser>),
    AppUser,
    PrefetchHooks Function()> {
  $$AppUsersTableTableManager(_$AppDatabase db, $AppUsersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppUsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppUsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppUsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> surname = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<DateTime?> birthday = const Value.absent(),
            Value<int?> avgCycleLength = const Value.absent(),
            Value<int?> avgPeriodLength = const Value.absent(),
            Value<DateTime?> lastestCycleStart = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AppUsersCompanion(
            id: id,
            name: name,
            surname: surname,
            email: email,
            birthday: birthday,
            avgCycleLength: avgCycleLength,
            avgPeriodLength: avgPeriodLength,
            lastestCycleStart: lastestCycleStart,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String?> surname = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<DateTime?> birthday = const Value.absent(),
            Value<int?> avgCycleLength = const Value.absent(),
            Value<int?> avgPeriodLength = const Value.absent(),
            Value<DateTime?> lastestCycleStart = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AppUsersCompanion.insert(
            id: id,
            name: name,
            surname: surname,
            email: email,
            birthday: birthday,
            avgCycleLength: avgCycleLength,
            avgPeriodLength: avgPeriodLength,
            lastestCycleStart: lastestCycleStart,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AppUsersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AppUsersTable,
    AppUser,
    $$AppUsersTableFilterComposer,
    $$AppUsersTableOrderingComposer,
    $$AppUsersTableAnnotationComposer,
    $$AppUsersTableCreateCompanionBuilder,
    $$AppUsersTableUpdateCompanionBuilder,
    (AppUser, BaseReferences<_$AppDatabase, $AppUsersTable, AppUser>),
    AppUser,
    PrefetchHooks Function()>;
typedef $$AppNotesTableCreateCompanionBuilder = AppNotesCompanion Function({
  Value<int> id,
  required String userId,
  required String title,
  required String content,
  required DateTime createdAt,
  required DateTime updatedAt,
});
typedef $$AppNotesTableUpdateCompanionBuilder = AppNotesCompanion Function({
  Value<int> id,
  Value<String> userId,
  Value<String> title,
  Value<String> content,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$AppNotesTableFilterComposer
    extends Composer<_$AppDatabase, $AppNotesTable> {
  $$AppNotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$AppNotesTableOrderingComposer
    extends Composer<_$AppDatabase, $AppNotesTable> {
  $$AppNotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$AppNotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppNotesTable> {
  $$AppNotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AppNotesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AppNotesTable,
    AppNote,
    $$AppNotesTableFilterComposer,
    $$AppNotesTableOrderingComposer,
    $$AppNotesTableAnnotationComposer,
    $$AppNotesTableCreateCompanionBuilder,
    $$AppNotesTableUpdateCompanionBuilder,
    (AppNote, BaseReferences<_$AppDatabase, $AppNotesTable, AppNote>),
    AppNote,
    PrefetchHooks Function()> {
  $$AppNotesTableTableManager(_$AppDatabase db, $AppNotesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppNotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppNotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppNotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              AppNotesCompanion(
            id: id,
            userId: userId,
            title: title,
            content: content,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String userId,
            required String title,
            required String content,
            required DateTime createdAt,
            required DateTime updatedAt,
          }) =>
              AppNotesCompanion.insert(
            id: id,
            userId: userId,
            title: title,
            content: content,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AppNotesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AppNotesTable,
    AppNote,
    $$AppNotesTableFilterComposer,
    $$AppNotesTableOrderingComposer,
    $$AppNotesTableAnnotationComposer,
    $$AppNotesTableCreateCompanionBuilder,
    $$AppNotesTableUpdateCompanionBuilder,
    (AppNote, BaseReferences<_$AppDatabase, $AppNotesTable, AppNote>),
    AppNote,
    PrefetchHooks Function()>;
typedef $$AppCyclesTableCreateCompanionBuilder = AppCyclesCompanion Function({
  Value<int> id,
  required DateTime startDate,
  Value<DateTime?> periodEndDate,
  Value<DateTime?> endDate,
  required String userId,
});
typedef $$AppCyclesTableUpdateCompanionBuilder = AppCyclesCompanion Function({
  Value<int> id,
  Value<DateTime> startDate,
  Value<DateTime?> periodEndDate,
  Value<DateTime?> endDate,
  Value<String> userId,
});

class $$AppCyclesTableFilterComposer
    extends Composer<_$AppDatabase, $AppCyclesTable> {
  $$AppCyclesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get periodEndDate => $composableBuilder(
      column: $table.periodEndDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));
}

class $$AppCyclesTableOrderingComposer
    extends Composer<_$AppDatabase, $AppCyclesTable> {
  $$AppCyclesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get periodEndDate => $composableBuilder(
      column: $table.periodEndDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));
}

class $$AppCyclesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppCyclesTable> {
  $$AppCyclesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get periodEndDate => $composableBuilder(
      column: $table.periodEndDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);
}

class $$AppCyclesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AppCyclesTable,
    AppCycle,
    $$AppCyclesTableFilterComposer,
    $$AppCyclesTableOrderingComposer,
    $$AppCyclesTableAnnotationComposer,
    $$AppCyclesTableCreateCompanionBuilder,
    $$AppCyclesTableUpdateCompanionBuilder,
    (AppCycle, BaseReferences<_$AppDatabase, $AppCyclesTable, AppCycle>),
    AppCycle,
    PrefetchHooks Function()> {
  $$AppCyclesTableTableManager(_$AppDatabase db, $AppCyclesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppCyclesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppCyclesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppCyclesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> startDate = const Value.absent(),
            Value<DateTime?> periodEndDate = const Value.absent(),
            Value<DateTime?> endDate = const Value.absent(),
            Value<String> userId = const Value.absent(),
          }) =>
              AppCyclesCompanion(
            id: id,
            startDate: startDate,
            periodEndDate: periodEndDate,
            endDate: endDate,
            userId: userId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required DateTime startDate,
            Value<DateTime?> periodEndDate = const Value.absent(),
            Value<DateTime?> endDate = const Value.absent(),
            required String userId,
          }) =>
              AppCyclesCompanion.insert(
            id: id,
            startDate: startDate,
            periodEndDate: periodEndDate,
            endDate: endDate,
            userId: userId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AppCyclesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AppCyclesTable,
    AppCycle,
    $$AppCyclesTableFilterComposer,
    $$AppCyclesTableOrderingComposer,
    $$AppCyclesTableAnnotationComposer,
    $$AppCyclesTableCreateCompanionBuilder,
    $$AppCyclesTableUpdateCompanionBuilder,
    (AppCycle, BaseReferences<_$AppDatabase, $AppCyclesTable, AppCycle>),
    AppCycle,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AppUserSettingsTableTableManager get appUserSettings =>
      $$AppUserSettingsTableTableManager(_db, _db.appUserSettings);
  $$AppDaysTableTableManager get appDays =>
      $$AppDaysTableTableManager(_db, _db.appDays);
  $$AppPeriodDaysTableTableManager get appPeriodDays =>
      $$AppPeriodDaysTableTableManager(_db, _db.appPeriodDays);
  $$AppMoodsTableTableManager get appMoods =>
      $$AppMoodsTableTableManager(_db, _db.appMoods);
  $$AppSymptomsTableTableManager get appSymptoms =>
      $$AppSymptomsTableTableManager(_db, _db.appSymptoms);
  $$AppUsersTableTableManager get appUsers =>
      $$AppUsersTableTableManager(_db, _db.appUsers);
  $$AppNotesTableTableManager get appNotes =>
      $$AppNotesTableTableManager(_db, _db.appNotes);
  $$AppCyclesTableTableManager get appCycles =>
      $$AppCyclesTableTableManager(_db, _db.appCycles);
}
