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
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
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
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
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
  final String date;
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
    map['date'] = Variable<String>(date);
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
      date: serializer.fromJson<String>(json['date']),
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
      'date': serializer.toJson<String>(date),
      'isPeriodDay': serializer.toJson<bool>(isPeriodDay),
      'note': serializer.toJson<String?>(note),
      'symptomList': serializer.toJson<String?>(symptomList),
      'moodList': serializer.toJson<String?>(moodList),
      'userId': serializer.toJson<String>(userId),
    };
  }

  AppDay copyWith(
          {String? date,
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
  final Value<String> date;
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
    required String date,
    this.isPeriodDay = const Value.absent(),
    this.note = const Value.absent(),
    this.symptomList = const Value.absent(),
    this.moodList = const Value.absent(),
    required String userId,
    this.rowid = const Value.absent(),
  })  : date = Value(date),
        userId = Value(userId);
  static Insertable<AppDay> custom({
    Expression<String>? date,
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
      {Value<String>? date,
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
      map['date'] = Variable<String>(date.value);
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
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
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
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
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
  final String date;
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
    map['date'] = Variable<String>(date);
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
      date: serializer.fromJson<String>(json['date']),
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
      'date': serializer.toJson<String>(date),
      'flowWeight': serializer.toJson<int?>(flowWeight),
      'isPeriodStartDay': serializer.toJson<bool>(isPeriodStartDay),
      'isPeriodEndDay': serializer.toJson<bool>(isPeriodEndDay),
      'userId': serializer.toJson<String>(userId),
    };
  }

  AppPeriodDay copyWith(
          {String? date,
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
  final Value<String> date;
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
    required String date,
    this.flowWeight = const Value.absent(),
    this.isPeriodStartDay = const Value.absent(),
    this.isPeriodEndDay = const Value.absent(),
    required String userId,
    this.rowid = const Value.absent(),
  })  : date = Value(date),
        userId = Value(userId);
  static Insertable<AppPeriodDay> custom({
    Expression<String>? date,
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
      {Value<String>? date,
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
      map['date'] = Variable<String>(date.value);
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
  late final GeneratedColumn<String> startDate = GeneratedColumn<String>(
      'start_date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _periodEndDateMeta =
      const VerificationMeta('periodEndDate');
  @override
  late final GeneratedColumn<String> periodEndDate = GeneratedColumn<String>(
      'period_end_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<String> endDate = GeneratedColumn<String>(
      'end_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
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
          .read(DriftSqlType.string, data['${effectivePrefix}start_date'])!,
      periodEndDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}period_end_date']),
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}end_date']),
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
  final String startDate;
  final String? periodEndDate;
  final String? endDate;
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
    map['start_date'] = Variable<String>(startDate);
    if (!nullToAbsent || periodEndDate != null) {
      map['period_end_date'] = Variable<String>(periodEndDate);
    }
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<String>(endDate);
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
      startDate: serializer.fromJson<String>(json['startDate']),
      periodEndDate: serializer.fromJson<String?>(json['periodEndDate']),
      endDate: serializer.fromJson<String?>(json['endDate']),
      userId: serializer.fromJson<String>(json['userId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'startDate': serializer.toJson<String>(startDate),
      'periodEndDate': serializer.toJson<String?>(periodEndDate),
      'endDate': serializer.toJson<String?>(endDate),
      'userId': serializer.toJson<String>(userId),
    };
  }

  AppCycle copyWith(
          {int? id,
          String? startDate,
          Value<String?> periodEndDate = const Value.absent(),
          Value<String?> endDate = const Value.absent(),
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
  final Value<String> startDate;
  final Value<String?> periodEndDate;
  final Value<String?> endDate;
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
    required String startDate,
    this.periodEndDate = const Value.absent(),
    this.endDate = const Value.absent(),
    required String userId,
  })  : startDate = Value(startDate),
        userId = Value(userId);
  static Insertable<AppCycle> custom({
    Expression<int>? id,
    Expression<String>? startDate,
    Expression<String>? periodEndDate,
    Expression<String>? endDate,
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
      Value<String>? startDate,
      Value<String?>? periodEndDate,
      Value<String?>? endDate,
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
      map['start_date'] = Variable<String>(startDate.value);
    }
    if (periodEndDate.present) {
      map['period_end_date'] = Variable<String>(periodEndDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<String>(endDate.value);
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

class $AppMoodsTable extends AppMoods with TableInfo<$AppMoodsTable, AppMood> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppMoodsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
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
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
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
  final String date;
  final String name;
  const AppMood({required this.date, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['date'] = Variable<String>(date);
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
      date: serializer.fromJson<String>(json['date']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'date': serializer.toJson<String>(date),
      'name': serializer.toJson<String>(name),
    };
  }

  AppMood copyWith({String? date, String? name}) => AppMood(
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
  final Value<String> date;
  final Value<String> name;
  final Value<int> rowid;
  const AppMoodsCompanion({
    this.date = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppMoodsCompanion.insert({
    required String date,
    required String name,
    this.rowid = const Value.absent(),
  })  : date = Value(date),
        name = Value(name);
  static Insertable<AppMood> custom({
    Expression<String>? date,
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
      {Value<String>? date, Value<String>? name, Value<int>? rowid}) {
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
      map['date'] = Variable<String>(date.value);
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
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
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
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
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
  final String date;
  final String name;
  const AppSymptom({required this.date, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['date'] = Variable<String>(date);
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
      date: serializer.fromJson<String>(json['date']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'date': serializer.toJson<String>(date),
      'name': serializer.toJson<String>(name),
    };
  }

  AppSymptom copyWith({String? date, String? name}) => AppSymptom(
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
  final Value<String> date;
  final Value<String> name;
  final Value<int> rowid;
  const AppSymptomsCompanion({
    this.date = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSymptomsCompanion.insert({
    required String date,
    required String name,
    this.rowid = const Value.absent(),
  })  : date = Value(date),
        name = Value(name);
  static Insertable<AppSymptom> custom({
    Expression<String>? date,
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
      {Value<String>? date, Value<String>? name, Value<int>? rowid}) {
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
      map['date'] = Variable<String>(date.value);
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
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, content, createdAt, updatedAt];
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
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $AppNotesTable createAlias(String alias) {
    return $AppNotesTable(attachedDatabase, alias);
  }
}

class AppNote extends DataClass implements Insertable<AppNote> {
  final int id;
  final String title;
  final String content;
  final String createdAt;
  final String updatedAt;
  const AppNote(
      {required this.id,
      required this.title,
      required this.content,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['content'] = Variable<String>(content);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    return map;
  }

  AppNotesCompanion toCompanion(bool nullToAbsent) {
    return AppNotesCompanion(
      id: Value(id),
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
      title: serializer.fromJson<String>(json['title']),
      content: serializer.fromJson<String>(json['content']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'content': serializer.toJson<String>(content),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
    };
  }

  AppNote copyWith(
          {int? id,
          String? title,
          String? content,
          String? createdAt,
          String? updatedAt}) =>
      AppNote(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  AppNote copyWithCompanion(AppNotesCompanion data) {
    return AppNote(
      id: data.id.present ? data.id.value : this.id,
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
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, content, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppNote &&
          other.id == this.id &&
          other.title == this.title &&
          other.content == this.content &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class AppNotesCompanion extends UpdateCompanion<AppNote> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> content;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  const AppNotesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  AppNotesCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String content,
    required String createdAt,
    required String updatedAt,
  })  : title = Value(title),
        content = Value(content),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<AppNote> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? content,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  AppNotesCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? content,
      Value<String>? createdAt,
      Value<String>? updatedAt}) {
    return AppNotesCompanion(
      id: id ?? this.id,
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
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppNotesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
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
  late final $AppCyclesTable appCycles = $AppCyclesTable(this);
  late final $AppMoodsTable appMoods = $AppMoodsTable(this);
  late final $AppSymptomsTable appSymptoms = $AppSymptomsTable(this);
  late final $AppNotesTable appNotes = $AppNotesTable(this);
  late final AppUserSettingsDao appUserSettingsDao =
      AppUserSettingsDao(this as AppDatabase);
  late final AppDaysDao appDaysDao = AppDaysDao(this as AppDatabase);
  late final AppPeriodDaysDao appPeriodDaysDao =
      AppPeriodDaysDao(this as AppDatabase);
  late final AppCyclesDao appCyclesDao = AppCyclesDao(this as AppDatabase);
  late final AppMoodsDao appMoodsDao = AppMoodsDao(this as AppDatabase);
  late final AppSymptomsDao appSymptomsDao =
      AppSymptomsDao(this as AppDatabase);
  late final AppNotesDao appNotesDao = AppNotesDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        appUserSettings,
        appDays,
        appPeriodDays,
        appCycles,
        appMoods,
        appSymptoms,
        appNotes
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
  required String date,
  Value<bool> isPeriodDay,
  Value<String?> note,
  Value<String?> symptomList,
  Value<String?> moodList,
  required String userId,
  Value<int> rowid,
});
typedef $$AppDaysTableUpdateCompanionBuilder = AppDaysCompanion Function({
  Value<String> date,
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
  ColumnFilters<String> get date => $composableBuilder(
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
  ColumnOrderings<String> get date => $composableBuilder(
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
  GeneratedColumn<String> get date =>
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
            Value<String> date = const Value.absent(),
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
            required String date,
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
  required String date,
  Value<int?> flowWeight,
  Value<bool> isPeriodStartDay,
  Value<bool> isPeriodEndDay,
  required String userId,
  Value<int> rowid,
});
typedef $$AppPeriodDaysTableUpdateCompanionBuilder = AppPeriodDaysCompanion
    Function({
  Value<String> date,
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
  ColumnFilters<String> get date => $composableBuilder(
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
  ColumnOrderings<String> get date => $composableBuilder(
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
  GeneratedColumn<String> get date =>
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
            Value<String> date = const Value.absent(),
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
            required String date,
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
typedef $$AppCyclesTableCreateCompanionBuilder = AppCyclesCompanion Function({
  Value<int> id,
  required String startDate,
  Value<String?> periodEndDate,
  Value<String?> endDate,
  required String userId,
});
typedef $$AppCyclesTableUpdateCompanionBuilder = AppCyclesCompanion Function({
  Value<int> id,
  Value<String> startDate,
  Value<String?> periodEndDate,
  Value<String?> endDate,
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

  ColumnFilters<String> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get periodEndDate => $composableBuilder(
      column: $table.periodEndDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get endDate => $composableBuilder(
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

  ColumnOrderings<String> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get periodEndDate => $composableBuilder(
      column: $table.periodEndDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get endDate => $composableBuilder(
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

  GeneratedColumn<String> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<String> get periodEndDate => $composableBuilder(
      column: $table.periodEndDate, builder: (column) => column);

  GeneratedColumn<String> get endDate =>
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
            Value<String> startDate = const Value.absent(),
            Value<String?> periodEndDate = const Value.absent(),
            Value<String?> endDate = const Value.absent(),
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
            required String startDate,
            Value<String?> periodEndDate = const Value.absent(),
            Value<String?> endDate = const Value.absent(),
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
typedef $$AppMoodsTableCreateCompanionBuilder = AppMoodsCompanion Function({
  required String date,
  required String name,
  Value<int> rowid,
});
typedef $$AppMoodsTableUpdateCompanionBuilder = AppMoodsCompanion Function({
  Value<String> date,
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
  ColumnFilters<String> get date => $composableBuilder(
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
  ColumnOrderings<String> get date => $composableBuilder(
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
  GeneratedColumn<String> get date =>
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
            Value<String> date = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AppMoodsCompanion(
            date: date,
            name: name,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String date,
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
  required String date,
  required String name,
  Value<int> rowid,
});
typedef $$AppSymptomsTableUpdateCompanionBuilder = AppSymptomsCompanion
    Function({
  Value<String> date,
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
  ColumnFilters<String> get date => $composableBuilder(
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
  ColumnOrderings<String> get date => $composableBuilder(
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
  GeneratedColumn<String> get date =>
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
            Value<String> date = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AppSymptomsCompanion(
            date: date,
            name: name,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String date,
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
typedef $$AppNotesTableCreateCompanionBuilder = AppNotesCompanion Function({
  Value<int> id,
  required String title,
  required String content,
  required String createdAt,
  required String updatedAt,
});
typedef $$AppNotesTableUpdateCompanionBuilder = AppNotesCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<String> content,
  Value<String> createdAt,
  Value<String> updatedAt,
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

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get updatedAt => $composableBuilder(
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

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get updatedAt => $composableBuilder(
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

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
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
            Value<String> title = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
            Value<String> updatedAt = const Value.absent(),
          }) =>
              AppNotesCompanion(
            id: id,
            title: title,
            content: content,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            required String content,
            required String createdAt,
            required String updatedAt,
          }) =>
              AppNotesCompanion.insert(
            id: id,
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

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AppUserSettingsTableTableManager get appUserSettings =>
      $$AppUserSettingsTableTableManager(_db, _db.appUserSettings);
  $$AppDaysTableTableManager get appDays =>
      $$AppDaysTableTableManager(_db, _db.appDays);
  $$AppPeriodDaysTableTableManager get appPeriodDays =>
      $$AppPeriodDaysTableTableManager(_db, _db.appPeriodDays);
  $$AppCyclesTableTableManager get appCycles =>
      $$AppCyclesTableTableManager(_db, _db.appCycles);
  $$AppMoodsTableTableManager get appMoods =>
      $$AppMoodsTableTableManager(_db, _db.appMoods);
  $$AppSymptomsTableTableManager get appSymptoms =>
      $$AppSymptomsTableTableManager(_db, _db.appSymptoms);
  $$AppNotesTableTableManager get appNotes =>
      $$AppNotesTableTableManager(_db, _db.appNotes);
}
