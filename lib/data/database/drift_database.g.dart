// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database.dart';

// ignore_for_file: type=lint
class $UserSettingsTableTable extends UserSettingsTable
    with TableInfo<$UserSettingsTableTable, UserSettingsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserSettingsTableTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'user_settings_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<UserSettingsTableData> instance,
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
  UserSettingsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserSettingsTableData(
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
    );
  }

  @override
  $UserSettingsTableTable createAlias(String alias) {
    return $UserSettingsTableTable(attachedDatabase, alias);
  }
}

class UserSettingsTableData extends DataClass
    implements Insertable<UserSettingsTableData> {
  final String key;
  final String value;
  final String userId;
  const UserSettingsTableData(
      {required this.key, required this.value, required this.userId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['user_id'] = Variable<String>(userId);
    return map;
  }

  UserSettingsTableCompanion toCompanion(bool nullToAbsent) {
    return UserSettingsTableCompanion(
      key: Value(key),
      value: Value(value),
      userId: Value(userId),
    );
  }

  factory UserSettingsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserSettingsTableData(
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

  UserSettingsTableData copyWith(
          {String? key, String? value, String? userId}) =>
      UserSettingsTableData(
        key: key ?? this.key,
        value: value ?? this.value,
        userId: userId ?? this.userId,
      );
  UserSettingsTableData copyWithCompanion(UserSettingsTableCompanion data) {
    return UserSettingsTableData(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      userId: data.userId.present ? data.userId.value : this.userId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserSettingsTableData(')
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
      (other is UserSettingsTableData &&
          other.key == this.key &&
          other.value == this.value &&
          other.userId == this.userId);
}

class UserSettingsTableCompanion
    extends UpdateCompanion<UserSettingsTableData> {
  final Value<String> key;
  final Value<String> value;
  final Value<String> userId;
  final Value<int> rowid;
  const UserSettingsTableCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.userId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserSettingsTableCompanion.insert({
    required String key,
    required String value,
    required String userId,
    this.rowid = const Value.absent(),
  })  : key = Value(key),
        value = Value(value),
        userId = Value(userId);
  static Insertable<UserSettingsTableData> custom({
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

  UserSettingsTableCompanion copyWith(
      {Value<String>? key,
      Value<String>? value,
      Value<String>? userId,
      Value<int>? rowid}) {
    return UserSettingsTableCompanion(
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
    return (StringBuffer('UserSettingsTableCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('userId: $userId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DaysTable extends Days with TableInfo<$DaysTable, Day> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DaysTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'days';
  @override
  VerificationContext validateIntegrity(Insertable<Day> instance,
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
  Day map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Day(
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
  $DaysTable createAlias(String alias) {
    return $DaysTable(attachedDatabase, alias);
  }
}

class Day extends DataClass implements Insertable<Day> {
  final String date;
  final bool isPeriodDay;
  final String? note;
  final String? symptomList;
  final String? moodList;
  final String userId;
  const Day(
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

  DaysCompanion toCompanion(bool nullToAbsent) {
    return DaysCompanion(
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

  factory Day.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Day(
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

  Day copyWith(
          {String? date,
          bool? isPeriodDay,
          Value<String?> note = const Value.absent(),
          Value<String?> symptomList = const Value.absent(),
          Value<String?> moodList = const Value.absent(),
          String? userId}) =>
      Day(
        date: date ?? this.date,
        isPeriodDay: isPeriodDay ?? this.isPeriodDay,
        note: note.present ? note.value : this.note,
        symptomList: symptomList.present ? symptomList.value : this.symptomList,
        moodList: moodList.present ? moodList.value : this.moodList,
        userId: userId ?? this.userId,
      );
  Day copyWithCompanion(DaysCompanion data) {
    return Day(
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
    return (StringBuffer('Day(')
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
      (other is Day &&
          other.date == this.date &&
          other.isPeriodDay == this.isPeriodDay &&
          other.note == this.note &&
          other.symptomList == this.symptomList &&
          other.moodList == this.moodList &&
          other.userId == this.userId);
}

class DaysCompanion extends UpdateCompanion<Day> {
  final Value<String> date;
  final Value<bool> isPeriodDay;
  final Value<String?> note;
  final Value<String?> symptomList;
  final Value<String?> moodList;
  final Value<String> userId;
  final Value<int> rowid;
  const DaysCompanion({
    this.date = const Value.absent(),
    this.isPeriodDay = const Value.absent(),
    this.note = const Value.absent(),
    this.symptomList = const Value.absent(),
    this.moodList = const Value.absent(),
    this.userId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DaysCompanion.insert({
    required String date,
    this.isPeriodDay = const Value.absent(),
    this.note = const Value.absent(),
    this.symptomList = const Value.absent(),
    this.moodList = const Value.absent(),
    required String userId,
    this.rowid = const Value.absent(),
  })  : date = Value(date),
        userId = Value(userId);
  static Insertable<Day> custom({
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

  DaysCompanion copyWith(
      {Value<String>? date,
      Value<bool>? isPeriodDay,
      Value<String?>? note,
      Value<String?>? symptomList,
      Value<String?>? moodList,
      Value<String>? userId,
      Value<int>? rowid}) {
    return DaysCompanion(
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
    return (StringBuffer('DaysCompanion(')
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

class $PeriodDaysTable extends PeriodDays
    with TableInfo<$PeriodDaysTable, PeriodDay> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PeriodDaysTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'period_days';
  @override
  VerificationContext validateIntegrity(Insertable<PeriodDay> instance,
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
  PeriodDay map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PeriodDay(
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
  $PeriodDaysTable createAlias(String alias) {
    return $PeriodDaysTable(attachedDatabase, alias);
  }
}

class PeriodDay extends DataClass implements Insertable<PeriodDay> {
  final String date;
  final int? flowWeight;
  final bool isPeriodStartDay;
  final bool isPeriodEndDay;
  final String userId;
  const PeriodDay(
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

  PeriodDaysCompanion toCompanion(bool nullToAbsent) {
    return PeriodDaysCompanion(
      date: Value(date),
      flowWeight: flowWeight == null && nullToAbsent
          ? const Value.absent()
          : Value(flowWeight),
      isPeriodStartDay: Value(isPeriodStartDay),
      isPeriodEndDay: Value(isPeriodEndDay),
      userId: Value(userId),
    );
  }

  factory PeriodDay.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PeriodDay(
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

  PeriodDay copyWith(
          {String? date,
          Value<int?> flowWeight = const Value.absent(),
          bool? isPeriodStartDay,
          bool? isPeriodEndDay,
          String? userId}) =>
      PeriodDay(
        date: date ?? this.date,
        flowWeight: flowWeight.present ? flowWeight.value : this.flowWeight,
        isPeriodStartDay: isPeriodStartDay ?? this.isPeriodStartDay,
        isPeriodEndDay: isPeriodEndDay ?? this.isPeriodEndDay,
        userId: userId ?? this.userId,
      );
  PeriodDay copyWithCompanion(PeriodDaysCompanion data) {
    return PeriodDay(
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
    return (StringBuffer('PeriodDay(')
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
      (other is PeriodDay &&
          other.date == this.date &&
          other.flowWeight == this.flowWeight &&
          other.isPeriodStartDay == this.isPeriodStartDay &&
          other.isPeriodEndDay == this.isPeriodEndDay &&
          other.userId == this.userId);
}

class PeriodDaysCompanion extends UpdateCompanion<PeriodDay> {
  final Value<String> date;
  final Value<int?> flowWeight;
  final Value<bool> isPeriodStartDay;
  final Value<bool> isPeriodEndDay;
  final Value<String> userId;
  final Value<int> rowid;
  const PeriodDaysCompanion({
    this.date = const Value.absent(),
    this.flowWeight = const Value.absent(),
    this.isPeriodStartDay = const Value.absent(),
    this.isPeriodEndDay = const Value.absent(),
    this.userId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PeriodDaysCompanion.insert({
    required String date,
    this.flowWeight = const Value.absent(),
    this.isPeriodStartDay = const Value.absent(),
    this.isPeriodEndDay = const Value.absent(),
    required String userId,
    this.rowid = const Value.absent(),
  })  : date = Value(date),
        userId = Value(userId);
  static Insertable<PeriodDay> custom({
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

  PeriodDaysCompanion copyWith(
      {Value<String>? date,
      Value<int?>? flowWeight,
      Value<bool>? isPeriodStartDay,
      Value<bool>? isPeriodEndDay,
      Value<String>? userId,
      Value<int>? rowid}) {
    return PeriodDaysCompanion(
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
    return (StringBuffer('PeriodDaysCompanion(')
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

class $CyclesTable extends Cycles with TableInfo<$CyclesTable, Cycle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CyclesTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'cycles';
  @override
  VerificationContext validateIntegrity(Insertable<Cycle> instance,
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
  Cycle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Cycle(
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
  $CyclesTable createAlias(String alias) {
    return $CyclesTable(attachedDatabase, alias);
  }
}

class Cycle extends DataClass implements Insertable<Cycle> {
  final int id;
  final String startDate;
  final String? periodEndDate;
  final String? endDate;
  final String userId;
  const Cycle(
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

  CyclesCompanion toCompanion(bool nullToAbsent) {
    return CyclesCompanion(
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

  factory Cycle.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Cycle(
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

  Cycle copyWith(
          {int? id,
          String? startDate,
          Value<String?> periodEndDate = const Value.absent(),
          Value<String?> endDate = const Value.absent(),
          String? userId}) =>
      Cycle(
        id: id ?? this.id,
        startDate: startDate ?? this.startDate,
        periodEndDate:
            periodEndDate.present ? periodEndDate.value : this.periodEndDate,
        endDate: endDate.present ? endDate.value : this.endDate,
        userId: userId ?? this.userId,
      );
  Cycle copyWithCompanion(CyclesCompanion data) {
    return Cycle(
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
    return (StringBuffer('Cycle(')
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
      (other is Cycle &&
          other.id == this.id &&
          other.startDate == this.startDate &&
          other.periodEndDate == this.periodEndDate &&
          other.endDate == this.endDate &&
          other.userId == this.userId);
}

class CyclesCompanion extends UpdateCompanion<Cycle> {
  final Value<int> id;
  final Value<String> startDate;
  final Value<String?> periodEndDate;
  final Value<String?> endDate;
  final Value<String> userId;
  const CyclesCompanion({
    this.id = const Value.absent(),
    this.startDate = const Value.absent(),
    this.periodEndDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.userId = const Value.absent(),
  });
  CyclesCompanion.insert({
    this.id = const Value.absent(),
    required String startDate,
    this.periodEndDate = const Value.absent(),
    this.endDate = const Value.absent(),
    required String userId,
  })  : startDate = Value(startDate),
        userId = Value(userId);
  static Insertable<Cycle> custom({
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

  CyclesCompanion copyWith(
      {Value<int>? id,
      Value<String>? startDate,
      Value<String?>? periodEndDate,
      Value<String?>? endDate,
      Value<String>? userId}) {
    return CyclesCompanion(
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
    return (StringBuffer('CyclesCompanion(')
          ..write('id: $id, ')
          ..write('startDate: $startDate, ')
          ..write('periodEndDate: $periodEndDate, ')
          ..write('endDate: $endDate, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }
}

class $MoodsTable extends Moods with TableInfo<$MoodsTable, Mood> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MoodsTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'moods';
  @override
  VerificationContext validateIntegrity(Insertable<Mood> instance,
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
  Mood map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Mood(
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $MoodsTable createAlias(String alias) {
    return $MoodsTable(attachedDatabase, alias);
  }
}

class Mood extends DataClass implements Insertable<Mood> {
  final String date;
  final String name;
  const Mood({required this.date, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['date'] = Variable<String>(date);
    map['name'] = Variable<String>(name);
    return map;
  }

  MoodsCompanion toCompanion(bool nullToAbsent) {
    return MoodsCompanion(
      date: Value(date),
      name: Value(name),
    );
  }

  factory Mood.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Mood(
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

  Mood copyWith({String? date, String? name}) => Mood(
        date: date ?? this.date,
        name: name ?? this.name,
      );
  Mood copyWithCompanion(MoodsCompanion data) {
    return Mood(
      date: data.date.present ? data.date.value : this.date,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Mood(')
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
      (other is Mood && other.date == this.date && other.name == this.name);
}

class MoodsCompanion extends UpdateCompanion<Mood> {
  final Value<String> date;
  final Value<String> name;
  final Value<int> rowid;
  const MoodsCompanion({
    this.date = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MoodsCompanion.insert({
    required String date,
    required String name,
    this.rowid = const Value.absent(),
  })  : date = Value(date),
        name = Value(name);
  static Insertable<Mood> custom({
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

  MoodsCompanion copyWith(
      {Value<String>? date, Value<String>? name, Value<int>? rowid}) {
    return MoodsCompanion(
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
    return (StringBuffer('MoodsCompanion(')
          ..write('date: $date, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SymptomsTable extends Symptoms with TableInfo<$SymptomsTable, Symptom> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SymptomsTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'symptoms';
  @override
  VerificationContext validateIntegrity(Insertable<Symptom> instance,
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
  Symptom map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Symptom(
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $SymptomsTable createAlias(String alias) {
    return $SymptomsTable(attachedDatabase, alias);
  }
}

class Symptom extends DataClass implements Insertable<Symptom> {
  final String date;
  final String name;
  const Symptom({required this.date, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['date'] = Variable<String>(date);
    map['name'] = Variable<String>(name);
    return map;
  }

  SymptomsCompanion toCompanion(bool nullToAbsent) {
    return SymptomsCompanion(
      date: Value(date),
      name: Value(name),
    );
  }

  factory Symptom.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Symptom(
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

  Symptom copyWith({String? date, String? name}) => Symptom(
        date: date ?? this.date,
        name: name ?? this.name,
      );
  Symptom copyWithCompanion(SymptomsCompanion data) {
    return Symptom(
      date: data.date.present ? data.date.value : this.date,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Symptom(')
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
      (other is Symptom && other.date == this.date && other.name == this.name);
}

class SymptomsCompanion extends UpdateCompanion<Symptom> {
  final Value<String> date;
  final Value<String> name;
  final Value<int> rowid;
  const SymptomsCompanion({
    this.date = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SymptomsCompanion.insert({
    required String date,
    required String name,
    this.rowid = const Value.absent(),
  })  : date = Value(date),
        name = Value(name);
  static Insertable<Symptom> custom({
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

  SymptomsCompanion copyWith(
      {Value<String>? date, Value<String>? name, Value<int>? rowid}) {
    return SymptomsCompanion(
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
    return (StringBuffer('SymptomsCompanion(')
          ..write('date: $date, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NotesTable extends Notes with TableInfo<$NotesTable, Note> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotesTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'notes';
  @override
  VerificationContext validateIntegrity(Insertable<Note> instance,
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
  Note map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Note(
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
  $NotesTable createAlias(String alias) {
    return $NotesTable(attachedDatabase, alias);
  }
}

class Note extends DataClass implements Insertable<Note> {
  final int id;
  final String title;
  final String content;
  final String createdAt;
  final String updatedAt;
  const Note(
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

  NotesCompanion toCompanion(bool nullToAbsent) {
    return NotesCompanion(
      id: Value(id),
      title: Value(title),
      content: Value(content),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Note.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Note(
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

  Note copyWith(
          {int? id,
          String? title,
          String? content,
          String? createdAt,
          String? updatedAt}) =>
      Note(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Note copyWithCompanion(NotesCompanion data) {
    return Note(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      content: data.content.present ? data.content.value : this.content,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Note(')
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
      (other is Note &&
          other.id == this.id &&
          other.title == this.title &&
          other.content == this.content &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class NotesCompanion extends UpdateCompanion<Note> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> content;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  const NotesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  NotesCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String content,
    required String createdAt,
    required String updatedAt,
  })  : title = Value(title),
        content = Value(content),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<Note> custom({
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

  NotesCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? content,
      Value<String>? createdAt,
      Value<String>? updatedAt}) {
    return NotesCompanion(
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
    return (StringBuffer('NotesCompanion(')
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
  late final $UserSettingsTableTable userSettingsTable =
      $UserSettingsTableTable(this);
  late final $DaysTable days = $DaysTable(this);
  late final $PeriodDaysTable periodDays = $PeriodDaysTable(this);
  late final $CyclesTable cycles = $CyclesTable(this);
  late final $MoodsTable moods = $MoodsTable(this);
  late final $SymptomsTable symptoms = $SymptomsTable(this);
  late final $NotesTable notes = $NotesTable(this);
  late final UserSettingsTableDao userSettingsTableDao =
      UserSettingsTableDao(this as AppDatabase);
  late final DaysDao daysDao = DaysDao(this as AppDatabase);
  late final PeriodDaysDao periodDaysDao = PeriodDaysDao(this as AppDatabase);
  late final CyclesDao cyclesDao = CyclesDao(this as AppDatabase);
  late final MoodsDao moodsDao = MoodsDao(this as AppDatabase);
  late final SymptomsDao symptomsDao = SymptomsDao(this as AppDatabase);
  late final NotesDao notesDao = NotesDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [userSettingsTable, days, periodDays, cycles, moods, symptoms, notes];
}

typedef $$UserSettingsTableTableCreateCompanionBuilder
    = UserSettingsTableCompanion Function({
  required String key,
  required String value,
  required String userId,
  Value<int> rowid,
});
typedef $$UserSettingsTableTableUpdateCompanionBuilder
    = UserSettingsTableCompanion Function({
  Value<String> key,
  Value<String> value,
  Value<String> userId,
  Value<int> rowid,
});

class $$UserSettingsTableTableFilterComposer
    extends Composer<_$AppDatabase, $UserSettingsTableTable> {
  $$UserSettingsTableTableFilterComposer({
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

class $$UserSettingsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UserSettingsTableTable> {
  $$UserSettingsTableTableOrderingComposer({
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

class $$UserSettingsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserSettingsTableTable> {
  $$UserSettingsTableTableAnnotationComposer({
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

class $$UserSettingsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserSettingsTableTable,
    UserSettingsTableData,
    $$UserSettingsTableTableFilterComposer,
    $$UserSettingsTableTableOrderingComposer,
    $$UserSettingsTableTableAnnotationComposer,
    $$UserSettingsTableTableCreateCompanionBuilder,
    $$UserSettingsTableTableUpdateCompanionBuilder,
    (
      UserSettingsTableData,
      BaseReferences<_$AppDatabase, $UserSettingsTableTable,
          UserSettingsTableData>
    ),
    UserSettingsTableData,
    PrefetchHooks Function()> {
  $$UserSettingsTableTableTableManager(
      _$AppDatabase db, $UserSettingsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserSettingsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserSettingsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserSettingsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UserSettingsTableCompanion(
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
              UserSettingsTableCompanion.insert(
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

typedef $$UserSettingsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UserSettingsTableTable,
    UserSettingsTableData,
    $$UserSettingsTableTableFilterComposer,
    $$UserSettingsTableTableOrderingComposer,
    $$UserSettingsTableTableAnnotationComposer,
    $$UserSettingsTableTableCreateCompanionBuilder,
    $$UserSettingsTableTableUpdateCompanionBuilder,
    (
      UserSettingsTableData,
      BaseReferences<_$AppDatabase, $UserSettingsTableTable,
          UserSettingsTableData>
    ),
    UserSettingsTableData,
    PrefetchHooks Function()>;
typedef $$DaysTableCreateCompanionBuilder = DaysCompanion Function({
  required String date,
  Value<bool> isPeriodDay,
  Value<String?> note,
  Value<String?> symptomList,
  Value<String?> moodList,
  required String userId,
  Value<int> rowid,
});
typedef $$DaysTableUpdateCompanionBuilder = DaysCompanion Function({
  Value<String> date,
  Value<bool> isPeriodDay,
  Value<String?> note,
  Value<String?> symptomList,
  Value<String?> moodList,
  Value<String> userId,
  Value<int> rowid,
});

class $$DaysTableFilterComposer extends Composer<_$AppDatabase, $DaysTable> {
  $$DaysTableFilterComposer({
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

class $$DaysTableOrderingComposer extends Composer<_$AppDatabase, $DaysTable> {
  $$DaysTableOrderingComposer({
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

class $$DaysTableAnnotationComposer
    extends Composer<_$AppDatabase, $DaysTable> {
  $$DaysTableAnnotationComposer({
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

class $$DaysTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DaysTable,
    Day,
    $$DaysTableFilterComposer,
    $$DaysTableOrderingComposer,
    $$DaysTableAnnotationComposer,
    $$DaysTableCreateCompanionBuilder,
    $$DaysTableUpdateCompanionBuilder,
    (Day, BaseReferences<_$AppDatabase, $DaysTable, Day>),
    Day,
    PrefetchHooks Function()> {
  $$DaysTableTableManager(_$AppDatabase db, $DaysTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DaysTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DaysTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DaysTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> date = const Value.absent(),
            Value<bool> isPeriodDay = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<String?> symptomList = const Value.absent(),
            Value<String?> moodList = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DaysCompanion(
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
              DaysCompanion.insert(
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

typedef $$DaysTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DaysTable,
    Day,
    $$DaysTableFilterComposer,
    $$DaysTableOrderingComposer,
    $$DaysTableAnnotationComposer,
    $$DaysTableCreateCompanionBuilder,
    $$DaysTableUpdateCompanionBuilder,
    (Day, BaseReferences<_$AppDatabase, $DaysTable, Day>),
    Day,
    PrefetchHooks Function()>;
typedef $$PeriodDaysTableCreateCompanionBuilder = PeriodDaysCompanion Function({
  required String date,
  Value<int?> flowWeight,
  Value<bool> isPeriodStartDay,
  Value<bool> isPeriodEndDay,
  required String userId,
  Value<int> rowid,
});
typedef $$PeriodDaysTableUpdateCompanionBuilder = PeriodDaysCompanion Function({
  Value<String> date,
  Value<int?> flowWeight,
  Value<bool> isPeriodStartDay,
  Value<bool> isPeriodEndDay,
  Value<String> userId,
  Value<int> rowid,
});

class $$PeriodDaysTableFilterComposer
    extends Composer<_$AppDatabase, $PeriodDaysTable> {
  $$PeriodDaysTableFilterComposer({
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

class $$PeriodDaysTableOrderingComposer
    extends Composer<_$AppDatabase, $PeriodDaysTable> {
  $$PeriodDaysTableOrderingComposer({
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

class $$PeriodDaysTableAnnotationComposer
    extends Composer<_$AppDatabase, $PeriodDaysTable> {
  $$PeriodDaysTableAnnotationComposer({
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

class $$PeriodDaysTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PeriodDaysTable,
    PeriodDay,
    $$PeriodDaysTableFilterComposer,
    $$PeriodDaysTableOrderingComposer,
    $$PeriodDaysTableAnnotationComposer,
    $$PeriodDaysTableCreateCompanionBuilder,
    $$PeriodDaysTableUpdateCompanionBuilder,
    (PeriodDay, BaseReferences<_$AppDatabase, $PeriodDaysTable, PeriodDay>),
    PeriodDay,
    PrefetchHooks Function()> {
  $$PeriodDaysTableTableManager(_$AppDatabase db, $PeriodDaysTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PeriodDaysTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PeriodDaysTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PeriodDaysTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> date = const Value.absent(),
            Value<int?> flowWeight = const Value.absent(),
            Value<bool> isPeriodStartDay = const Value.absent(),
            Value<bool> isPeriodEndDay = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PeriodDaysCompanion(
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
              PeriodDaysCompanion.insert(
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

typedef $$PeriodDaysTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PeriodDaysTable,
    PeriodDay,
    $$PeriodDaysTableFilterComposer,
    $$PeriodDaysTableOrderingComposer,
    $$PeriodDaysTableAnnotationComposer,
    $$PeriodDaysTableCreateCompanionBuilder,
    $$PeriodDaysTableUpdateCompanionBuilder,
    (PeriodDay, BaseReferences<_$AppDatabase, $PeriodDaysTable, PeriodDay>),
    PeriodDay,
    PrefetchHooks Function()>;
typedef $$CyclesTableCreateCompanionBuilder = CyclesCompanion Function({
  Value<int> id,
  required String startDate,
  Value<String?> periodEndDate,
  Value<String?> endDate,
  required String userId,
});
typedef $$CyclesTableUpdateCompanionBuilder = CyclesCompanion Function({
  Value<int> id,
  Value<String> startDate,
  Value<String?> periodEndDate,
  Value<String?> endDate,
  Value<String> userId,
});

class $$CyclesTableFilterComposer
    extends Composer<_$AppDatabase, $CyclesTable> {
  $$CyclesTableFilterComposer({
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

class $$CyclesTableOrderingComposer
    extends Composer<_$AppDatabase, $CyclesTable> {
  $$CyclesTableOrderingComposer({
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

class $$CyclesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CyclesTable> {
  $$CyclesTableAnnotationComposer({
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

class $$CyclesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CyclesTable,
    Cycle,
    $$CyclesTableFilterComposer,
    $$CyclesTableOrderingComposer,
    $$CyclesTableAnnotationComposer,
    $$CyclesTableCreateCompanionBuilder,
    $$CyclesTableUpdateCompanionBuilder,
    (Cycle, BaseReferences<_$AppDatabase, $CyclesTable, Cycle>),
    Cycle,
    PrefetchHooks Function()> {
  $$CyclesTableTableManager(_$AppDatabase db, $CyclesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CyclesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CyclesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CyclesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> startDate = const Value.absent(),
            Value<String?> periodEndDate = const Value.absent(),
            Value<String?> endDate = const Value.absent(),
            Value<String> userId = const Value.absent(),
          }) =>
              CyclesCompanion(
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
              CyclesCompanion.insert(
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

typedef $$CyclesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CyclesTable,
    Cycle,
    $$CyclesTableFilterComposer,
    $$CyclesTableOrderingComposer,
    $$CyclesTableAnnotationComposer,
    $$CyclesTableCreateCompanionBuilder,
    $$CyclesTableUpdateCompanionBuilder,
    (Cycle, BaseReferences<_$AppDatabase, $CyclesTable, Cycle>),
    Cycle,
    PrefetchHooks Function()>;
typedef $$MoodsTableCreateCompanionBuilder = MoodsCompanion Function({
  required String date,
  required String name,
  Value<int> rowid,
});
typedef $$MoodsTableUpdateCompanionBuilder = MoodsCompanion Function({
  Value<String> date,
  Value<String> name,
  Value<int> rowid,
});

class $$MoodsTableFilterComposer extends Composer<_$AppDatabase, $MoodsTable> {
  $$MoodsTableFilterComposer({
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

class $$MoodsTableOrderingComposer
    extends Composer<_$AppDatabase, $MoodsTable> {
  $$MoodsTableOrderingComposer({
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

class $$MoodsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MoodsTable> {
  $$MoodsTableAnnotationComposer({
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

class $$MoodsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MoodsTable,
    Mood,
    $$MoodsTableFilterComposer,
    $$MoodsTableOrderingComposer,
    $$MoodsTableAnnotationComposer,
    $$MoodsTableCreateCompanionBuilder,
    $$MoodsTableUpdateCompanionBuilder,
    (Mood, BaseReferences<_$AppDatabase, $MoodsTable, Mood>),
    Mood,
    PrefetchHooks Function()> {
  $$MoodsTableTableManager(_$AppDatabase db, $MoodsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MoodsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MoodsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MoodsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> date = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MoodsCompanion(
            date: date,
            name: name,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String date,
            required String name,
            Value<int> rowid = const Value.absent(),
          }) =>
              MoodsCompanion.insert(
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

typedef $$MoodsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MoodsTable,
    Mood,
    $$MoodsTableFilterComposer,
    $$MoodsTableOrderingComposer,
    $$MoodsTableAnnotationComposer,
    $$MoodsTableCreateCompanionBuilder,
    $$MoodsTableUpdateCompanionBuilder,
    (Mood, BaseReferences<_$AppDatabase, $MoodsTable, Mood>),
    Mood,
    PrefetchHooks Function()>;
typedef $$SymptomsTableCreateCompanionBuilder = SymptomsCompanion Function({
  required String date,
  required String name,
  Value<int> rowid,
});
typedef $$SymptomsTableUpdateCompanionBuilder = SymptomsCompanion Function({
  Value<String> date,
  Value<String> name,
  Value<int> rowid,
});

class $$SymptomsTableFilterComposer
    extends Composer<_$AppDatabase, $SymptomsTable> {
  $$SymptomsTableFilterComposer({
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

class $$SymptomsTableOrderingComposer
    extends Composer<_$AppDatabase, $SymptomsTable> {
  $$SymptomsTableOrderingComposer({
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

class $$SymptomsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SymptomsTable> {
  $$SymptomsTableAnnotationComposer({
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

class $$SymptomsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SymptomsTable,
    Symptom,
    $$SymptomsTableFilterComposer,
    $$SymptomsTableOrderingComposer,
    $$SymptomsTableAnnotationComposer,
    $$SymptomsTableCreateCompanionBuilder,
    $$SymptomsTableUpdateCompanionBuilder,
    (Symptom, BaseReferences<_$AppDatabase, $SymptomsTable, Symptom>),
    Symptom,
    PrefetchHooks Function()> {
  $$SymptomsTableTableManager(_$AppDatabase db, $SymptomsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SymptomsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SymptomsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SymptomsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> date = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SymptomsCompanion(
            date: date,
            name: name,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String date,
            required String name,
            Value<int> rowid = const Value.absent(),
          }) =>
              SymptomsCompanion.insert(
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

typedef $$SymptomsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SymptomsTable,
    Symptom,
    $$SymptomsTableFilterComposer,
    $$SymptomsTableOrderingComposer,
    $$SymptomsTableAnnotationComposer,
    $$SymptomsTableCreateCompanionBuilder,
    $$SymptomsTableUpdateCompanionBuilder,
    (Symptom, BaseReferences<_$AppDatabase, $SymptomsTable, Symptom>),
    Symptom,
    PrefetchHooks Function()>;
typedef $$NotesTableCreateCompanionBuilder = NotesCompanion Function({
  Value<int> id,
  required String title,
  required String content,
  required String createdAt,
  required String updatedAt,
});
typedef $$NotesTableUpdateCompanionBuilder = NotesCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<String> content,
  Value<String> createdAt,
  Value<String> updatedAt,
});

class $$NotesTableFilterComposer extends Composer<_$AppDatabase, $NotesTable> {
  $$NotesTableFilterComposer({
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

class $$NotesTableOrderingComposer
    extends Composer<_$AppDatabase, $NotesTable> {
  $$NotesTableOrderingComposer({
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

class $$NotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotesTable> {
  $$NotesTableAnnotationComposer({
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

class $$NotesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $NotesTable,
    Note,
    $$NotesTableFilterComposer,
    $$NotesTableOrderingComposer,
    $$NotesTableAnnotationComposer,
    $$NotesTableCreateCompanionBuilder,
    $$NotesTableUpdateCompanionBuilder,
    (Note, BaseReferences<_$AppDatabase, $NotesTable, Note>),
    Note,
    PrefetchHooks Function()> {
  $$NotesTableTableManager(_$AppDatabase db, $NotesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
            Value<String> updatedAt = const Value.absent(),
          }) =>
              NotesCompanion(
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
              NotesCompanion.insert(
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

typedef $$NotesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $NotesTable,
    Note,
    $$NotesTableFilterComposer,
    $$NotesTableOrderingComposer,
    $$NotesTableAnnotationComposer,
    $$NotesTableCreateCompanionBuilder,
    $$NotesTableUpdateCompanionBuilder,
    (Note, BaseReferences<_$AppDatabase, $NotesTable, Note>),
    Note,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UserSettingsTableTableTableManager get userSettingsTable =>
      $$UserSettingsTableTableTableManager(_db, _db.userSettingsTable);
  $$DaysTableTableManager get days => $$DaysTableTableManager(_db, _db.days);
  $$PeriodDaysTableTableManager get periodDays =>
      $$PeriodDaysTableTableManager(_db, _db.periodDays);
  $$CyclesTableTableManager get cycles =>
      $$CyclesTableTableManager(_db, _db.cycles);
  $$MoodsTableTableManager get moods =>
      $$MoodsTableTableManager(_db, _db.moods);
  $$SymptomsTableTableManager get symptoms =>
      $$SymptomsTableTableManager(_db, _db.symptoms);
  $$NotesTableTableManager get notes =>
      $$NotesTableTableManager(_db, _db.notes);
}
