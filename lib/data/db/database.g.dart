// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $CalendarsTable extends Calendars
    with TableInfo<$CalendarsTable, CalendarRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CalendarsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorIdMeta = const VerificationMeta(
    'colorId',
  );
  @override
  late final GeneratedColumn<int> colorId = GeneratedColumn<int>(
    'color_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDefaultMeta = const VerificationMeta(
    'isDefault',
  );
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
    'is_default',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_default" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isVisibleMeta = const VerificationMeta(
    'isVisible',
  );
  @override
  late final GeneratedColumn<bool> isVisible = GeneratedColumn<bool>(
    'is_visible',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_visible" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _displayOrderMeta = const VerificationMeta(
    'displayOrder',
  );
  @override
  late final GeneratedColumn<int> displayOrder = GeneratedColumn<int>(
    'display_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    colorId,
    isDefault,
    isVisible,
    displayOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'calendars';
  @override
  VerificationContext validateIntegrity(
    Insertable<CalendarRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('color_id')) {
      context.handle(
        _colorIdMeta,
        colorId.isAcceptableOrUnknown(data['color_id']!, _colorIdMeta),
      );
    } else if (isInserting) {
      context.missing(_colorIdMeta);
    }
    if (data.containsKey('is_default')) {
      context.handle(
        _isDefaultMeta,
        isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta),
      );
    }
    if (data.containsKey('is_visible')) {
      context.handle(
        _isVisibleMeta,
        isVisible.isAcceptableOrUnknown(data['is_visible']!, _isVisibleMeta),
      );
    }
    if (data.containsKey('display_order')) {
      context.handle(
        _displayOrderMeta,
        displayOrder.isAcceptableOrUnknown(
          data['display_order']!,
          _displayOrderMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CalendarRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CalendarRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      colorId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color_id'],
      )!,
      isDefault: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_default'],
      )!,
      isVisible: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_visible'],
      )!,
      displayOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}display_order'],
      )!,
    );
  }

  @override
  $CalendarsTable createAlias(String alias) {
    return $CalendarsTable(attachedDatabase, alias);
  }
}

class CalendarRow extends DataClass implements Insertable<CalendarRow> {
  final String id;
  final String title;
  final int colorId;
  final bool isDefault;
  final bool isVisible;
  final int displayOrder;
  const CalendarRow({
    required this.id,
    required this.title,
    required this.colorId,
    required this.isDefault,
    required this.isVisible,
    required this.displayOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['color_id'] = Variable<int>(colorId);
    map['is_default'] = Variable<bool>(isDefault);
    map['is_visible'] = Variable<bool>(isVisible);
    map['display_order'] = Variable<int>(displayOrder);
    return map;
  }

  CalendarsCompanion toCompanion(bool nullToAbsent) {
    return CalendarsCompanion(
      id: Value(id),
      title: Value(title),
      colorId: Value(colorId),
      isDefault: Value(isDefault),
      isVisible: Value(isVisible),
      displayOrder: Value(displayOrder),
    );
  }

  factory CalendarRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CalendarRow(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      colorId: serializer.fromJson<int>(json['colorId']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
      isVisible: serializer.fromJson<bool>(json['isVisible']),
      displayOrder: serializer.fromJson<int>(json['displayOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'colorId': serializer.toJson<int>(colorId),
      'isDefault': serializer.toJson<bool>(isDefault),
      'isVisible': serializer.toJson<bool>(isVisible),
      'displayOrder': serializer.toJson<int>(displayOrder),
    };
  }

  CalendarRow copyWith({
    String? id,
    String? title,
    int? colorId,
    bool? isDefault,
    bool? isVisible,
    int? displayOrder,
  }) => CalendarRow(
    id: id ?? this.id,
    title: title ?? this.title,
    colorId: colorId ?? this.colorId,
    isDefault: isDefault ?? this.isDefault,
    isVisible: isVisible ?? this.isVisible,
    displayOrder: displayOrder ?? this.displayOrder,
  );
  CalendarRow copyWithCompanion(CalendarsCompanion data) {
    return CalendarRow(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      colorId: data.colorId.present ? data.colorId.value : this.colorId,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
      isVisible: data.isVisible.present ? data.isVisible.value : this.isVisible,
      displayOrder: data.displayOrder.present
          ? data.displayOrder.value
          : this.displayOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CalendarRow(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('colorId: $colorId, ')
          ..write('isDefault: $isDefault, ')
          ..write('isVisible: $isVisible, ')
          ..write('displayOrder: $displayOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, colorId, isDefault, isVisible, displayOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CalendarRow &&
          other.id == this.id &&
          other.title == this.title &&
          other.colorId == this.colorId &&
          other.isDefault == this.isDefault &&
          other.isVisible == this.isVisible &&
          other.displayOrder == this.displayOrder);
}

class CalendarsCompanion extends UpdateCompanion<CalendarRow> {
  final Value<String> id;
  final Value<String> title;
  final Value<int> colorId;
  final Value<bool> isDefault;
  final Value<bool> isVisible;
  final Value<int> displayOrder;
  final Value<int> rowid;
  const CalendarsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.colorId = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.isVisible = const Value.absent(),
    this.displayOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CalendarsCompanion.insert({
    required String id,
    required String title,
    required int colorId,
    this.isDefault = const Value.absent(),
    this.isVisible = const Value.absent(),
    this.displayOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       colorId = Value(colorId);
  static Insertable<CalendarRow> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<int>? colorId,
    Expression<bool>? isDefault,
    Expression<bool>? isVisible,
    Expression<int>? displayOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (colorId != null) 'color_id': colorId,
      if (isDefault != null) 'is_default': isDefault,
      if (isVisible != null) 'is_visible': isVisible,
      if (displayOrder != null) 'display_order': displayOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CalendarsCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<int>? colorId,
    Value<bool>? isDefault,
    Value<bool>? isVisible,
    Value<int>? displayOrder,
    Value<int>? rowid,
  }) {
    return CalendarsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      colorId: colorId ?? this.colorId,
      isDefault: isDefault ?? this.isDefault,
      isVisible: isVisible ?? this.isVisible,
      displayOrder: displayOrder ?? this.displayOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (colorId.present) {
      map['color_id'] = Variable<int>(colorId.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    if (isVisible.present) {
      map['is_visible'] = Variable<bool>(isVisible.value);
    }
    if (displayOrder.present) {
      map['display_order'] = Variable<int>(displayOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CalendarsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('colorId: $colorId, ')
          ..write('isDefault: $isDefault, ')
          ..write('isVisible: $isVisible, ')
          ..write('displayOrder: $displayOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EventsTable extends Events with TableInfo<$EventsTable, EventRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _calendarIdMeta = const VerificationMeta(
    'calendarId',
  );
  @override
  late final GeneratedColumn<String> calendarId = GeneratedColumn<String>(
    'calendar_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES calendars (id)',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _allDayMeta = const VerificationMeta('allDay');
  @override
  late final GeneratedColumn<bool> allDay = GeneratedColumn<bool>(
    'all_day',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("all_day" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _startMeta = const VerificationMeta('start');
  @override
  late final GeneratedColumn<DateTime> start = GeneratedColumn<DateTime>(
    'start',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endMeta = const VerificationMeta('end');
  @override
  late final GeneratedColumn<DateTime> end = GeneratedColumn<DateTime>(
    'end',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorIdMeta = const VerificationMeta(
    'colorId',
  );
  @override
  late final GeneratedColumn<int> colorId = GeneratedColumn<int>(
    'color_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
    'url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recFreqMeta = const VerificationMeta(
    'recFreq',
  );
  @override
  late final GeneratedColumn<int> recFreq = GeneratedColumn<int>(
    'rec_freq',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _recIntervalMeta = const VerificationMeta(
    'recInterval',
  );
  @override
  late final GeneratedColumn<int> recInterval = GeneratedColumn<int>(
    'rec_interval',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _recEndKindMeta = const VerificationMeta(
    'recEndKind',
  );
  @override
  late final GeneratedColumn<int> recEndKind = GeneratedColumn<int>(
    'rec_end_kind',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _recUntilMeta = const VerificationMeta(
    'recUntil',
  );
  @override
  late final GeneratedColumn<DateTime> recUntil = GeneratedColumn<DateTime>(
    'rec_until',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recCountMeta = const VerificationMeta(
    'recCount',
  );
  @override
  late final GeneratedColumn<int> recCount = GeneratedColumn<int>(
    'rec_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _alertMinutesMeta = const VerificationMeta(
    'alertMinutes',
  );
  @override
  late final GeneratedColumn<int> alertMinutes = GeneratedColumn<int>(
    'alert_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    calendarId,
    title,
    allDay,
    start,
    end,
    colorId,
    location,
    url,
    notes,
    recFreq,
    recInterval,
    recEndKind,
    recUntil,
    recCount,
    alertMinutes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'events';
  @override
  VerificationContext validateIntegrity(
    Insertable<EventRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('calendar_id')) {
      context.handle(
        _calendarIdMeta,
        calendarId.isAcceptableOrUnknown(data['calendar_id']!, _calendarIdMeta),
      );
    } else if (isInserting) {
      context.missing(_calendarIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('all_day')) {
      context.handle(
        _allDayMeta,
        allDay.isAcceptableOrUnknown(data['all_day']!, _allDayMeta),
      );
    }
    if (data.containsKey('start')) {
      context.handle(
        _startMeta,
        start.isAcceptableOrUnknown(data['start']!, _startMeta),
      );
    } else if (isInserting) {
      context.missing(_startMeta);
    }
    if (data.containsKey('end')) {
      context.handle(
        _endMeta,
        end.isAcceptableOrUnknown(data['end']!, _endMeta),
      );
    } else if (isInserting) {
      context.missing(_endMeta);
    }
    if (data.containsKey('color_id')) {
      context.handle(
        _colorIdMeta,
        colorId.isAcceptableOrUnknown(data['color_id']!, _colorIdMeta),
      );
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    }
    if (data.containsKey('url')) {
      context.handle(
        _urlMeta,
        url.isAcceptableOrUnknown(data['url']!, _urlMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('rec_freq')) {
      context.handle(
        _recFreqMeta,
        recFreq.isAcceptableOrUnknown(data['rec_freq']!, _recFreqMeta),
      );
    }
    if (data.containsKey('rec_interval')) {
      context.handle(
        _recIntervalMeta,
        recInterval.isAcceptableOrUnknown(
          data['rec_interval']!,
          _recIntervalMeta,
        ),
      );
    }
    if (data.containsKey('rec_end_kind')) {
      context.handle(
        _recEndKindMeta,
        recEndKind.isAcceptableOrUnknown(
          data['rec_end_kind']!,
          _recEndKindMeta,
        ),
      );
    }
    if (data.containsKey('rec_until')) {
      context.handle(
        _recUntilMeta,
        recUntil.isAcceptableOrUnknown(data['rec_until']!, _recUntilMeta),
      );
    }
    if (data.containsKey('rec_count')) {
      context.handle(
        _recCountMeta,
        recCount.isAcceptableOrUnknown(data['rec_count']!, _recCountMeta),
      );
    }
    if (data.containsKey('alert_minutes')) {
      context.handle(
        _alertMinutesMeta,
        alertMinutes.isAcceptableOrUnknown(
          data['alert_minutes']!,
          _alertMinutesMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EventRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EventRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      calendarId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}calendar_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      allDay: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}all_day'],
      )!,
      start: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start'],
      )!,
      end: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end'],
      )!,
      colorId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color_id'],
      ),
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      ),
      url: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}url'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      recFreq: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rec_freq'],
      )!,
      recInterval: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rec_interval'],
      )!,
      recEndKind: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rec_end_kind'],
      )!,
      recUntil: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}rec_until'],
      ),
      recCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rec_count'],
      ),
      alertMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}alert_minutes'],
      ),
    );
  }

  @override
  $EventsTable createAlias(String alias) {
    return $EventsTable(attachedDatabase, alias);
  }
}

class EventRow extends DataClass implements Insertable<EventRow> {
  final String id;
  final String calendarId;
  final String title;
  final bool allDay;
  final DateTime start;
  final DateTime end;
  final int? colorId;
  final String? location;
  final String? url;
  final String? notes;
  final int recFreq;
  final int recInterval;
  final int recEndKind;
  final DateTime? recUntil;
  final int? recCount;
  final int? alertMinutes;
  const EventRow({
    required this.id,
    required this.calendarId,
    required this.title,
    required this.allDay,
    required this.start,
    required this.end,
    this.colorId,
    this.location,
    this.url,
    this.notes,
    required this.recFreq,
    required this.recInterval,
    required this.recEndKind,
    this.recUntil,
    this.recCount,
    this.alertMinutes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['calendar_id'] = Variable<String>(calendarId);
    map['title'] = Variable<String>(title);
    map['all_day'] = Variable<bool>(allDay);
    map['start'] = Variable<DateTime>(start);
    map['end'] = Variable<DateTime>(end);
    if (!nullToAbsent || colorId != null) {
      map['color_id'] = Variable<int>(colorId);
    }
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    if (!nullToAbsent || url != null) {
      map['url'] = Variable<String>(url);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['rec_freq'] = Variable<int>(recFreq);
    map['rec_interval'] = Variable<int>(recInterval);
    map['rec_end_kind'] = Variable<int>(recEndKind);
    if (!nullToAbsent || recUntil != null) {
      map['rec_until'] = Variable<DateTime>(recUntil);
    }
    if (!nullToAbsent || recCount != null) {
      map['rec_count'] = Variable<int>(recCount);
    }
    if (!nullToAbsent || alertMinutes != null) {
      map['alert_minutes'] = Variable<int>(alertMinutes);
    }
    return map;
  }

  EventsCompanion toCompanion(bool nullToAbsent) {
    return EventsCompanion(
      id: Value(id),
      calendarId: Value(calendarId),
      title: Value(title),
      allDay: Value(allDay),
      start: Value(start),
      end: Value(end),
      colorId: colorId == null && nullToAbsent
          ? const Value.absent()
          : Value(colorId),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
      url: url == null && nullToAbsent ? const Value.absent() : Value(url),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      recFreq: Value(recFreq),
      recInterval: Value(recInterval),
      recEndKind: Value(recEndKind),
      recUntil: recUntil == null && nullToAbsent
          ? const Value.absent()
          : Value(recUntil),
      recCount: recCount == null && nullToAbsent
          ? const Value.absent()
          : Value(recCount),
      alertMinutes: alertMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(alertMinutes),
    );
  }

  factory EventRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EventRow(
      id: serializer.fromJson<String>(json['id']),
      calendarId: serializer.fromJson<String>(json['calendarId']),
      title: serializer.fromJson<String>(json['title']),
      allDay: serializer.fromJson<bool>(json['allDay']),
      start: serializer.fromJson<DateTime>(json['start']),
      end: serializer.fromJson<DateTime>(json['end']),
      colorId: serializer.fromJson<int?>(json['colorId']),
      location: serializer.fromJson<String?>(json['location']),
      url: serializer.fromJson<String?>(json['url']),
      notes: serializer.fromJson<String?>(json['notes']),
      recFreq: serializer.fromJson<int>(json['recFreq']),
      recInterval: serializer.fromJson<int>(json['recInterval']),
      recEndKind: serializer.fromJson<int>(json['recEndKind']),
      recUntil: serializer.fromJson<DateTime?>(json['recUntil']),
      recCount: serializer.fromJson<int?>(json['recCount']),
      alertMinutes: serializer.fromJson<int?>(json['alertMinutes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'calendarId': serializer.toJson<String>(calendarId),
      'title': serializer.toJson<String>(title),
      'allDay': serializer.toJson<bool>(allDay),
      'start': serializer.toJson<DateTime>(start),
      'end': serializer.toJson<DateTime>(end),
      'colorId': serializer.toJson<int?>(colorId),
      'location': serializer.toJson<String?>(location),
      'url': serializer.toJson<String?>(url),
      'notes': serializer.toJson<String?>(notes),
      'recFreq': serializer.toJson<int>(recFreq),
      'recInterval': serializer.toJson<int>(recInterval),
      'recEndKind': serializer.toJson<int>(recEndKind),
      'recUntil': serializer.toJson<DateTime?>(recUntil),
      'recCount': serializer.toJson<int?>(recCount),
      'alertMinutes': serializer.toJson<int?>(alertMinutes),
    };
  }

  EventRow copyWith({
    String? id,
    String? calendarId,
    String? title,
    bool? allDay,
    DateTime? start,
    DateTime? end,
    Value<int?> colorId = const Value.absent(),
    Value<String?> location = const Value.absent(),
    Value<String?> url = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    int? recFreq,
    int? recInterval,
    int? recEndKind,
    Value<DateTime?> recUntil = const Value.absent(),
    Value<int?> recCount = const Value.absent(),
    Value<int?> alertMinutes = const Value.absent(),
  }) => EventRow(
    id: id ?? this.id,
    calendarId: calendarId ?? this.calendarId,
    title: title ?? this.title,
    allDay: allDay ?? this.allDay,
    start: start ?? this.start,
    end: end ?? this.end,
    colorId: colorId.present ? colorId.value : this.colorId,
    location: location.present ? location.value : this.location,
    url: url.present ? url.value : this.url,
    notes: notes.present ? notes.value : this.notes,
    recFreq: recFreq ?? this.recFreq,
    recInterval: recInterval ?? this.recInterval,
    recEndKind: recEndKind ?? this.recEndKind,
    recUntil: recUntil.present ? recUntil.value : this.recUntil,
    recCount: recCount.present ? recCount.value : this.recCount,
    alertMinutes: alertMinutes.present ? alertMinutes.value : this.alertMinutes,
  );
  EventRow copyWithCompanion(EventsCompanion data) {
    return EventRow(
      id: data.id.present ? data.id.value : this.id,
      calendarId: data.calendarId.present
          ? data.calendarId.value
          : this.calendarId,
      title: data.title.present ? data.title.value : this.title,
      allDay: data.allDay.present ? data.allDay.value : this.allDay,
      start: data.start.present ? data.start.value : this.start,
      end: data.end.present ? data.end.value : this.end,
      colorId: data.colorId.present ? data.colorId.value : this.colorId,
      location: data.location.present ? data.location.value : this.location,
      url: data.url.present ? data.url.value : this.url,
      notes: data.notes.present ? data.notes.value : this.notes,
      recFreq: data.recFreq.present ? data.recFreq.value : this.recFreq,
      recInterval: data.recInterval.present
          ? data.recInterval.value
          : this.recInterval,
      recEndKind: data.recEndKind.present
          ? data.recEndKind.value
          : this.recEndKind,
      recUntil: data.recUntil.present ? data.recUntil.value : this.recUntil,
      recCount: data.recCount.present ? data.recCount.value : this.recCount,
      alertMinutes: data.alertMinutes.present
          ? data.alertMinutes.value
          : this.alertMinutes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EventRow(')
          ..write('id: $id, ')
          ..write('calendarId: $calendarId, ')
          ..write('title: $title, ')
          ..write('allDay: $allDay, ')
          ..write('start: $start, ')
          ..write('end: $end, ')
          ..write('colorId: $colorId, ')
          ..write('location: $location, ')
          ..write('url: $url, ')
          ..write('notes: $notes, ')
          ..write('recFreq: $recFreq, ')
          ..write('recInterval: $recInterval, ')
          ..write('recEndKind: $recEndKind, ')
          ..write('recUntil: $recUntil, ')
          ..write('recCount: $recCount, ')
          ..write('alertMinutes: $alertMinutes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    calendarId,
    title,
    allDay,
    start,
    end,
    colorId,
    location,
    url,
    notes,
    recFreq,
    recInterval,
    recEndKind,
    recUntil,
    recCount,
    alertMinutes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EventRow &&
          other.id == this.id &&
          other.calendarId == this.calendarId &&
          other.title == this.title &&
          other.allDay == this.allDay &&
          other.start == this.start &&
          other.end == this.end &&
          other.colorId == this.colorId &&
          other.location == this.location &&
          other.url == this.url &&
          other.notes == this.notes &&
          other.recFreq == this.recFreq &&
          other.recInterval == this.recInterval &&
          other.recEndKind == this.recEndKind &&
          other.recUntil == this.recUntil &&
          other.recCount == this.recCount &&
          other.alertMinutes == this.alertMinutes);
}

class EventsCompanion extends UpdateCompanion<EventRow> {
  final Value<String> id;
  final Value<String> calendarId;
  final Value<String> title;
  final Value<bool> allDay;
  final Value<DateTime> start;
  final Value<DateTime> end;
  final Value<int?> colorId;
  final Value<String?> location;
  final Value<String?> url;
  final Value<String?> notes;
  final Value<int> recFreq;
  final Value<int> recInterval;
  final Value<int> recEndKind;
  final Value<DateTime?> recUntil;
  final Value<int?> recCount;
  final Value<int?> alertMinutes;
  final Value<int> rowid;
  const EventsCompanion({
    this.id = const Value.absent(),
    this.calendarId = const Value.absent(),
    this.title = const Value.absent(),
    this.allDay = const Value.absent(),
    this.start = const Value.absent(),
    this.end = const Value.absent(),
    this.colorId = const Value.absent(),
    this.location = const Value.absent(),
    this.url = const Value.absent(),
    this.notes = const Value.absent(),
    this.recFreq = const Value.absent(),
    this.recInterval = const Value.absent(),
    this.recEndKind = const Value.absent(),
    this.recUntil = const Value.absent(),
    this.recCount = const Value.absent(),
    this.alertMinutes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EventsCompanion.insert({
    required String id,
    required String calendarId,
    required String title,
    this.allDay = const Value.absent(),
    required DateTime start,
    required DateTime end,
    this.colorId = const Value.absent(),
    this.location = const Value.absent(),
    this.url = const Value.absent(),
    this.notes = const Value.absent(),
    this.recFreq = const Value.absent(),
    this.recInterval = const Value.absent(),
    this.recEndKind = const Value.absent(),
    this.recUntil = const Value.absent(),
    this.recCount = const Value.absent(),
    this.alertMinutes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       calendarId = Value(calendarId),
       title = Value(title),
       start = Value(start),
       end = Value(end);
  static Insertable<EventRow> custom({
    Expression<String>? id,
    Expression<String>? calendarId,
    Expression<String>? title,
    Expression<bool>? allDay,
    Expression<DateTime>? start,
    Expression<DateTime>? end,
    Expression<int>? colorId,
    Expression<String>? location,
    Expression<String>? url,
    Expression<String>? notes,
    Expression<int>? recFreq,
    Expression<int>? recInterval,
    Expression<int>? recEndKind,
    Expression<DateTime>? recUntil,
    Expression<int>? recCount,
    Expression<int>? alertMinutes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (calendarId != null) 'calendar_id': calendarId,
      if (title != null) 'title': title,
      if (allDay != null) 'all_day': allDay,
      if (start != null) 'start': start,
      if (end != null) 'end': end,
      if (colorId != null) 'color_id': colorId,
      if (location != null) 'location': location,
      if (url != null) 'url': url,
      if (notes != null) 'notes': notes,
      if (recFreq != null) 'rec_freq': recFreq,
      if (recInterval != null) 'rec_interval': recInterval,
      if (recEndKind != null) 'rec_end_kind': recEndKind,
      if (recUntil != null) 'rec_until': recUntil,
      if (recCount != null) 'rec_count': recCount,
      if (alertMinutes != null) 'alert_minutes': alertMinutes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EventsCompanion copyWith({
    Value<String>? id,
    Value<String>? calendarId,
    Value<String>? title,
    Value<bool>? allDay,
    Value<DateTime>? start,
    Value<DateTime>? end,
    Value<int?>? colorId,
    Value<String?>? location,
    Value<String?>? url,
    Value<String?>? notes,
    Value<int>? recFreq,
    Value<int>? recInterval,
    Value<int>? recEndKind,
    Value<DateTime?>? recUntil,
    Value<int?>? recCount,
    Value<int?>? alertMinutes,
    Value<int>? rowid,
  }) {
    return EventsCompanion(
      id: id ?? this.id,
      calendarId: calendarId ?? this.calendarId,
      title: title ?? this.title,
      allDay: allDay ?? this.allDay,
      start: start ?? this.start,
      end: end ?? this.end,
      colorId: colorId ?? this.colorId,
      location: location ?? this.location,
      url: url ?? this.url,
      notes: notes ?? this.notes,
      recFreq: recFreq ?? this.recFreq,
      recInterval: recInterval ?? this.recInterval,
      recEndKind: recEndKind ?? this.recEndKind,
      recUntil: recUntil ?? this.recUntil,
      recCount: recCount ?? this.recCount,
      alertMinutes: alertMinutes ?? this.alertMinutes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (calendarId.present) {
      map['calendar_id'] = Variable<String>(calendarId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (allDay.present) {
      map['all_day'] = Variable<bool>(allDay.value);
    }
    if (start.present) {
      map['start'] = Variable<DateTime>(start.value);
    }
    if (end.present) {
      map['end'] = Variable<DateTime>(end.value);
    }
    if (colorId.present) {
      map['color_id'] = Variable<int>(colorId.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (recFreq.present) {
      map['rec_freq'] = Variable<int>(recFreq.value);
    }
    if (recInterval.present) {
      map['rec_interval'] = Variable<int>(recInterval.value);
    }
    if (recEndKind.present) {
      map['rec_end_kind'] = Variable<int>(recEndKind.value);
    }
    if (recUntil.present) {
      map['rec_until'] = Variable<DateTime>(recUntil.value);
    }
    if (recCount.present) {
      map['rec_count'] = Variable<int>(recCount.value);
    }
    if (alertMinutes.present) {
      map['alert_minutes'] = Variable<int>(alertMinutes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventsCompanion(')
          ..write('id: $id, ')
          ..write('calendarId: $calendarId, ')
          ..write('title: $title, ')
          ..write('allDay: $allDay, ')
          ..write('start: $start, ')
          ..write('end: $end, ')
          ..write('colorId: $colorId, ')
          ..write('location: $location, ')
          ..write('url: $url, ')
          ..write('notes: $notes, ')
          ..write('recFreq: $recFreq, ')
          ..write('recInterval: $recInterval, ')
          ..write('recEndKind: $recEndKind, ')
          ..write('recUntil: $recUntil, ')
          ..write('recCount: $recCount, ')
          ..write('alertMinutes: $alertMinutes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTableTable extends AppSettingsTable
    with TableInfo<$AppSettingsTableTable, SettingsRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('app'),
  );
  static const VerificationMeta _themeModeMeta = const VerificationMeta(
    'themeMode',
  );
  @override
  late final GeneratedColumn<int> themeMode = GeneratedColumn<int>(
    'theme_mode',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _weekStartMeta = const VerificationMeta(
    'weekStart',
  );
  @override
  late final GeneratedColumn<int> weekStart = GeneratedColumn<int>(
    'week_start',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(DateTime.monday),
  );
  static const VerificationMeta _use24hMeta = const VerificationMeta('use24h');
  @override
  late final GeneratedColumn<bool> use24h = GeneratedColumn<bool>(
    'use24h',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("use24h" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _defaultAlertTimedMeta = const VerificationMeta(
    'defaultAlertTimed',
  );
  @override
  late final GeneratedColumn<int> defaultAlertTimed = GeneratedColumn<int>(
    'default_alert_timed',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _defaultAlertAllDayMeta =
      const VerificationMeta('defaultAlertAllDay');
  @override
  late final GeneratedColumn<int> defaultAlertAllDay = GeneratedColumn<int>(
    'default_alert_all_day',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _digestMorningOnMeta = const VerificationMeta(
    'digestMorningOn',
  );
  @override
  late final GeneratedColumn<bool> digestMorningOn = GeneratedColumn<bool>(
    'digest_morning_on',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("digest_morning_on" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _digestMorningMinMeta = const VerificationMeta(
    'digestMorningMin',
  );
  @override
  late final GeneratedColumn<int> digestMorningMin = GeneratedColumn<int>(
    'digest_morning_min',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(8 * 60),
  );
  static const VerificationMeta _digestEveningOnMeta = const VerificationMeta(
    'digestEveningOn',
  );
  @override
  late final GeneratedColumn<bool> digestEveningOn = GeneratedColumn<bool>(
    'digest_evening_on',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("digest_evening_on" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _digestEveningMinMeta = const VerificationMeta(
    'digestEveningMin',
  );
  @override
  late final GeneratedColumn<int> digestEveningMin = GeneratedColumn<int>(
    'digest_evening_min',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(20 * 60),
  );
  static const VerificationMeta _badgeTypeMeta = const VerificationMeta(
    'badgeType',
  );
  @override
  late final GeneratedColumn<int> badgeType = GeneratedColumn<int>(
    'badge_type',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isProMeta = const VerificationMeta('isPro');
  @override
  late final GeneratedColumn<bool> isPro = GeneratedColumn<bool>(
    'is_pro',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_pro" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _showWeekNumbersMeta = const VerificationMeta(
    'showWeekNumbers',
  );
  @override
  late final GeneratedColumn<bool> showWeekNumbers = GeneratedColumn<bool>(
    'show_week_numbers',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("show_week_numbers" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _accentIdMeta = const VerificationMeta(
    'accentId',
  );
  @override
  late final GeneratedColumn<int> accentId = GeneratedColumn<int>(
    'accent_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    themeMode,
    weekStart,
    use24h,
    defaultAlertTimed,
    defaultAlertAllDay,
    digestMorningOn,
    digestMorningMin,
    digestEveningOn,
    digestEveningMin,
    badgeType,
    isPro,
    showWeekNumbers,
    accentId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<SettingsRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('theme_mode')) {
      context.handle(
        _themeModeMeta,
        themeMode.isAcceptableOrUnknown(data['theme_mode']!, _themeModeMeta),
      );
    }
    if (data.containsKey('week_start')) {
      context.handle(
        _weekStartMeta,
        weekStart.isAcceptableOrUnknown(data['week_start']!, _weekStartMeta),
      );
    }
    if (data.containsKey('use24h')) {
      context.handle(
        _use24hMeta,
        use24h.isAcceptableOrUnknown(data['use24h']!, _use24hMeta),
      );
    }
    if (data.containsKey('default_alert_timed')) {
      context.handle(
        _defaultAlertTimedMeta,
        defaultAlertTimed.isAcceptableOrUnknown(
          data['default_alert_timed']!,
          _defaultAlertTimedMeta,
        ),
      );
    }
    if (data.containsKey('default_alert_all_day')) {
      context.handle(
        _defaultAlertAllDayMeta,
        defaultAlertAllDay.isAcceptableOrUnknown(
          data['default_alert_all_day']!,
          _defaultAlertAllDayMeta,
        ),
      );
    }
    if (data.containsKey('digest_morning_on')) {
      context.handle(
        _digestMorningOnMeta,
        digestMorningOn.isAcceptableOrUnknown(
          data['digest_morning_on']!,
          _digestMorningOnMeta,
        ),
      );
    }
    if (data.containsKey('digest_morning_min')) {
      context.handle(
        _digestMorningMinMeta,
        digestMorningMin.isAcceptableOrUnknown(
          data['digest_morning_min']!,
          _digestMorningMinMeta,
        ),
      );
    }
    if (data.containsKey('digest_evening_on')) {
      context.handle(
        _digestEveningOnMeta,
        digestEveningOn.isAcceptableOrUnknown(
          data['digest_evening_on']!,
          _digestEveningOnMeta,
        ),
      );
    }
    if (data.containsKey('digest_evening_min')) {
      context.handle(
        _digestEveningMinMeta,
        digestEveningMin.isAcceptableOrUnknown(
          data['digest_evening_min']!,
          _digestEveningMinMeta,
        ),
      );
    }
    if (data.containsKey('badge_type')) {
      context.handle(
        _badgeTypeMeta,
        badgeType.isAcceptableOrUnknown(data['badge_type']!, _badgeTypeMeta),
      );
    }
    if (data.containsKey('is_pro')) {
      context.handle(
        _isProMeta,
        isPro.isAcceptableOrUnknown(data['is_pro']!, _isProMeta),
      );
    }
    if (data.containsKey('show_week_numbers')) {
      context.handle(
        _showWeekNumbersMeta,
        showWeekNumbers.isAcceptableOrUnknown(
          data['show_week_numbers']!,
          _showWeekNumbersMeta,
        ),
      );
    }
    if (data.containsKey('accent_id')) {
      context.handle(
        _accentIdMeta,
        accentId.isAcceptableOrUnknown(data['accent_id']!, _accentIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SettingsRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SettingsRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      themeMode: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}theme_mode'],
      )!,
      weekStart: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}week_start'],
      )!,
      use24h: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}use24h'],
      )!,
      defaultAlertTimed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}default_alert_timed'],
      ),
      defaultAlertAllDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}default_alert_all_day'],
      ),
      digestMorningOn: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}digest_morning_on'],
      )!,
      digestMorningMin: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}digest_morning_min'],
      )!,
      digestEveningOn: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}digest_evening_on'],
      )!,
      digestEveningMin: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}digest_evening_min'],
      )!,
      badgeType: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}badge_type'],
      )!,
      isPro: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_pro'],
      )!,
      showWeekNumbers: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}show_week_numbers'],
      )!,
      accentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}accent_id'],
      )!,
    );
  }

  @override
  $AppSettingsTableTable createAlias(String alias) {
    return $AppSettingsTableTable(attachedDatabase, alias);
  }
}

class SettingsRow extends DataClass implements Insertable<SettingsRow> {
  final String id;
  final int themeMode;
  final int weekStart;
  final bool use24h;
  final int? defaultAlertTimed;
  final int? defaultAlertAllDay;
  final bool digestMorningOn;
  final int digestMorningMin;
  final bool digestEveningOn;
  final int digestEveningMin;
  final int badgeType;
  final bool isPro;
  final bool showWeekNumbers;
  final int accentId;
  const SettingsRow({
    required this.id,
    required this.themeMode,
    required this.weekStart,
    required this.use24h,
    this.defaultAlertTimed,
    this.defaultAlertAllDay,
    required this.digestMorningOn,
    required this.digestMorningMin,
    required this.digestEveningOn,
    required this.digestEveningMin,
    required this.badgeType,
    required this.isPro,
    required this.showWeekNumbers,
    required this.accentId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['theme_mode'] = Variable<int>(themeMode);
    map['week_start'] = Variable<int>(weekStart);
    map['use24h'] = Variable<bool>(use24h);
    if (!nullToAbsent || defaultAlertTimed != null) {
      map['default_alert_timed'] = Variable<int>(defaultAlertTimed);
    }
    if (!nullToAbsent || defaultAlertAllDay != null) {
      map['default_alert_all_day'] = Variable<int>(defaultAlertAllDay);
    }
    map['digest_morning_on'] = Variable<bool>(digestMorningOn);
    map['digest_morning_min'] = Variable<int>(digestMorningMin);
    map['digest_evening_on'] = Variable<bool>(digestEveningOn);
    map['digest_evening_min'] = Variable<int>(digestEveningMin);
    map['badge_type'] = Variable<int>(badgeType);
    map['is_pro'] = Variable<bool>(isPro);
    map['show_week_numbers'] = Variable<bool>(showWeekNumbers);
    map['accent_id'] = Variable<int>(accentId);
    return map;
  }

  AppSettingsTableCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsTableCompanion(
      id: Value(id),
      themeMode: Value(themeMode),
      weekStart: Value(weekStart),
      use24h: Value(use24h),
      defaultAlertTimed: defaultAlertTimed == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultAlertTimed),
      defaultAlertAllDay: defaultAlertAllDay == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultAlertAllDay),
      digestMorningOn: Value(digestMorningOn),
      digestMorningMin: Value(digestMorningMin),
      digestEveningOn: Value(digestEveningOn),
      digestEveningMin: Value(digestEveningMin),
      badgeType: Value(badgeType),
      isPro: Value(isPro),
      showWeekNumbers: Value(showWeekNumbers),
      accentId: Value(accentId),
    );
  }

  factory SettingsRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SettingsRow(
      id: serializer.fromJson<String>(json['id']),
      themeMode: serializer.fromJson<int>(json['themeMode']),
      weekStart: serializer.fromJson<int>(json['weekStart']),
      use24h: serializer.fromJson<bool>(json['use24h']),
      defaultAlertTimed: serializer.fromJson<int?>(json['defaultAlertTimed']),
      defaultAlertAllDay: serializer.fromJson<int?>(json['defaultAlertAllDay']),
      digestMorningOn: serializer.fromJson<bool>(json['digestMorningOn']),
      digestMorningMin: serializer.fromJson<int>(json['digestMorningMin']),
      digestEveningOn: serializer.fromJson<bool>(json['digestEveningOn']),
      digestEveningMin: serializer.fromJson<int>(json['digestEveningMin']),
      badgeType: serializer.fromJson<int>(json['badgeType']),
      isPro: serializer.fromJson<bool>(json['isPro']),
      showWeekNumbers: serializer.fromJson<bool>(json['showWeekNumbers']),
      accentId: serializer.fromJson<int>(json['accentId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'themeMode': serializer.toJson<int>(themeMode),
      'weekStart': serializer.toJson<int>(weekStart),
      'use24h': serializer.toJson<bool>(use24h),
      'defaultAlertTimed': serializer.toJson<int?>(defaultAlertTimed),
      'defaultAlertAllDay': serializer.toJson<int?>(defaultAlertAllDay),
      'digestMorningOn': serializer.toJson<bool>(digestMorningOn),
      'digestMorningMin': serializer.toJson<int>(digestMorningMin),
      'digestEveningOn': serializer.toJson<bool>(digestEveningOn),
      'digestEveningMin': serializer.toJson<int>(digestEveningMin),
      'badgeType': serializer.toJson<int>(badgeType),
      'isPro': serializer.toJson<bool>(isPro),
      'showWeekNumbers': serializer.toJson<bool>(showWeekNumbers),
      'accentId': serializer.toJson<int>(accentId),
    };
  }

  SettingsRow copyWith({
    String? id,
    int? themeMode,
    int? weekStart,
    bool? use24h,
    Value<int?> defaultAlertTimed = const Value.absent(),
    Value<int?> defaultAlertAllDay = const Value.absent(),
    bool? digestMorningOn,
    int? digestMorningMin,
    bool? digestEveningOn,
    int? digestEveningMin,
    int? badgeType,
    bool? isPro,
    bool? showWeekNumbers,
    int? accentId,
  }) => SettingsRow(
    id: id ?? this.id,
    themeMode: themeMode ?? this.themeMode,
    weekStart: weekStart ?? this.weekStart,
    use24h: use24h ?? this.use24h,
    defaultAlertTimed: defaultAlertTimed.present
        ? defaultAlertTimed.value
        : this.defaultAlertTimed,
    defaultAlertAllDay: defaultAlertAllDay.present
        ? defaultAlertAllDay.value
        : this.defaultAlertAllDay,
    digestMorningOn: digestMorningOn ?? this.digestMorningOn,
    digestMorningMin: digestMorningMin ?? this.digestMorningMin,
    digestEveningOn: digestEveningOn ?? this.digestEveningOn,
    digestEveningMin: digestEveningMin ?? this.digestEveningMin,
    badgeType: badgeType ?? this.badgeType,
    isPro: isPro ?? this.isPro,
    showWeekNumbers: showWeekNumbers ?? this.showWeekNumbers,
    accentId: accentId ?? this.accentId,
  );
  SettingsRow copyWithCompanion(AppSettingsTableCompanion data) {
    return SettingsRow(
      id: data.id.present ? data.id.value : this.id,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      weekStart: data.weekStart.present ? data.weekStart.value : this.weekStart,
      use24h: data.use24h.present ? data.use24h.value : this.use24h,
      defaultAlertTimed: data.defaultAlertTimed.present
          ? data.defaultAlertTimed.value
          : this.defaultAlertTimed,
      defaultAlertAllDay: data.defaultAlertAllDay.present
          ? data.defaultAlertAllDay.value
          : this.defaultAlertAllDay,
      digestMorningOn: data.digestMorningOn.present
          ? data.digestMorningOn.value
          : this.digestMorningOn,
      digestMorningMin: data.digestMorningMin.present
          ? data.digestMorningMin.value
          : this.digestMorningMin,
      digestEveningOn: data.digestEveningOn.present
          ? data.digestEveningOn.value
          : this.digestEveningOn,
      digestEveningMin: data.digestEveningMin.present
          ? data.digestEveningMin.value
          : this.digestEveningMin,
      badgeType: data.badgeType.present ? data.badgeType.value : this.badgeType,
      isPro: data.isPro.present ? data.isPro.value : this.isPro,
      showWeekNumbers: data.showWeekNumbers.present
          ? data.showWeekNumbers.value
          : this.showWeekNumbers,
      accentId: data.accentId.present ? data.accentId.value : this.accentId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SettingsRow(')
          ..write('id: $id, ')
          ..write('themeMode: $themeMode, ')
          ..write('weekStart: $weekStart, ')
          ..write('use24h: $use24h, ')
          ..write('defaultAlertTimed: $defaultAlertTimed, ')
          ..write('defaultAlertAllDay: $defaultAlertAllDay, ')
          ..write('digestMorningOn: $digestMorningOn, ')
          ..write('digestMorningMin: $digestMorningMin, ')
          ..write('digestEveningOn: $digestEveningOn, ')
          ..write('digestEveningMin: $digestEveningMin, ')
          ..write('badgeType: $badgeType, ')
          ..write('isPro: $isPro, ')
          ..write('showWeekNumbers: $showWeekNumbers, ')
          ..write('accentId: $accentId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    themeMode,
    weekStart,
    use24h,
    defaultAlertTimed,
    defaultAlertAllDay,
    digestMorningOn,
    digestMorningMin,
    digestEveningOn,
    digestEveningMin,
    badgeType,
    isPro,
    showWeekNumbers,
    accentId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SettingsRow &&
          other.id == this.id &&
          other.themeMode == this.themeMode &&
          other.weekStart == this.weekStart &&
          other.use24h == this.use24h &&
          other.defaultAlertTimed == this.defaultAlertTimed &&
          other.defaultAlertAllDay == this.defaultAlertAllDay &&
          other.digestMorningOn == this.digestMorningOn &&
          other.digestMorningMin == this.digestMorningMin &&
          other.digestEveningOn == this.digestEveningOn &&
          other.digestEveningMin == this.digestEveningMin &&
          other.badgeType == this.badgeType &&
          other.isPro == this.isPro &&
          other.showWeekNumbers == this.showWeekNumbers &&
          other.accentId == this.accentId);
}

class AppSettingsTableCompanion extends UpdateCompanion<SettingsRow> {
  final Value<String> id;
  final Value<int> themeMode;
  final Value<int> weekStart;
  final Value<bool> use24h;
  final Value<int?> defaultAlertTimed;
  final Value<int?> defaultAlertAllDay;
  final Value<bool> digestMorningOn;
  final Value<int> digestMorningMin;
  final Value<bool> digestEveningOn;
  final Value<int> digestEveningMin;
  final Value<int> badgeType;
  final Value<bool> isPro;
  final Value<bool> showWeekNumbers;
  final Value<int> accentId;
  final Value<int> rowid;
  const AppSettingsTableCompanion({
    this.id = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.weekStart = const Value.absent(),
    this.use24h = const Value.absent(),
    this.defaultAlertTimed = const Value.absent(),
    this.defaultAlertAllDay = const Value.absent(),
    this.digestMorningOn = const Value.absent(),
    this.digestMorningMin = const Value.absent(),
    this.digestEveningOn = const Value.absent(),
    this.digestEveningMin = const Value.absent(),
    this.badgeType = const Value.absent(),
    this.isPro = const Value.absent(),
    this.showWeekNumbers = const Value.absent(),
    this.accentId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsTableCompanion.insert({
    this.id = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.weekStart = const Value.absent(),
    this.use24h = const Value.absent(),
    this.defaultAlertTimed = const Value.absent(),
    this.defaultAlertAllDay = const Value.absent(),
    this.digestMorningOn = const Value.absent(),
    this.digestMorningMin = const Value.absent(),
    this.digestEveningOn = const Value.absent(),
    this.digestEveningMin = const Value.absent(),
    this.badgeType = const Value.absent(),
    this.isPro = const Value.absent(),
    this.showWeekNumbers = const Value.absent(),
    this.accentId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  static Insertable<SettingsRow> custom({
    Expression<String>? id,
    Expression<int>? themeMode,
    Expression<int>? weekStart,
    Expression<bool>? use24h,
    Expression<int>? defaultAlertTimed,
    Expression<int>? defaultAlertAllDay,
    Expression<bool>? digestMorningOn,
    Expression<int>? digestMorningMin,
    Expression<bool>? digestEveningOn,
    Expression<int>? digestEveningMin,
    Expression<int>? badgeType,
    Expression<bool>? isPro,
    Expression<bool>? showWeekNumbers,
    Expression<int>? accentId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (themeMode != null) 'theme_mode': themeMode,
      if (weekStart != null) 'week_start': weekStart,
      if (use24h != null) 'use24h': use24h,
      if (defaultAlertTimed != null) 'default_alert_timed': defaultAlertTimed,
      if (defaultAlertAllDay != null)
        'default_alert_all_day': defaultAlertAllDay,
      if (digestMorningOn != null) 'digest_morning_on': digestMorningOn,
      if (digestMorningMin != null) 'digest_morning_min': digestMorningMin,
      if (digestEveningOn != null) 'digest_evening_on': digestEveningOn,
      if (digestEveningMin != null) 'digest_evening_min': digestEveningMin,
      if (badgeType != null) 'badge_type': badgeType,
      if (isPro != null) 'is_pro': isPro,
      if (showWeekNumbers != null) 'show_week_numbers': showWeekNumbers,
      if (accentId != null) 'accent_id': accentId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingsTableCompanion copyWith({
    Value<String>? id,
    Value<int>? themeMode,
    Value<int>? weekStart,
    Value<bool>? use24h,
    Value<int?>? defaultAlertTimed,
    Value<int?>? defaultAlertAllDay,
    Value<bool>? digestMorningOn,
    Value<int>? digestMorningMin,
    Value<bool>? digestEveningOn,
    Value<int>? digestEveningMin,
    Value<int>? badgeType,
    Value<bool>? isPro,
    Value<bool>? showWeekNumbers,
    Value<int>? accentId,
    Value<int>? rowid,
  }) {
    return AppSettingsTableCompanion(
      id: id ?? this.id,
      themeMode: themeMode ?? this.themeMode,
      weekStart: weekStart ?? this.weekStart,
      use24h: use24h ?? this.use24h,
      defaultAlertTimed: defaultAlertTimed ?? this.defaultAlertTimed,
      defaultAlertAllDay: defaultAlertAllDay ?? this.defaultAlertAllDay,
      digestMorningOn: digestMorningOn ?? this.digestMorningOn,
      digestMorningMin: digestMorningMin ?? this.digestMorningMin,
      digestEveningOn: digestEveningOn ?? this.digestEveningOn,
      digestEveningMin: digestEveningMin ?? this.digestEveningMin,
      badgeType: badgeType ?? this.badgeType,
      isPro: isPro ?? this.isPro,
      showWeekNumbers: showWeekNumbers ?? this.showWeekNumbers,
      accentId: accentId ?? this.accentId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<int>(themeMode.value);
    }
    if (weekStart.present) {
      map['week_start'] = Variable<int>(weekStart.value);
    }
    if (use24h.present) {
      map['use24h'] = Variable<bool>(use24h.value);
    }
    if (defaultAlertTimed.present) {
      map['default_alert_timed'] = Variable<int>(defaultAlertTimed.value);
    }
    if (defaultAlertAllDay.present) {
      map['default_alert_all_day'] = Variable<int>(defaultAlertAllDay.value);
    }
    if (digestMorningOn.present) {
      map['digest_morning_on'] = Variable<bool>(digestMorningOn.value);
    }
    if (digestMorningMin.present) {
      map['digest_morning_min'] = Variable<int>(digestMorningMin.value);
    }
    if (digestEveningOn.present) {
      map['digest_evening_on'] = Variable<bool>(digestEveningOn.value);
    }
    if (digestEveningMin.present) {
      map['digest_evening_min'] = Variable<int>(digestEveningMin.value);
    }
    if (badgeType.present) {
      map['badge_type'] = Variable<int>(badgeType.value);
    }
    if (isPro.present) {
      map['is_pro'] = Variable<bool>(isPro.value);
    }
    if (showWeekNumbers.present) {
      map['show_week_numbers'] = Variable<bool>(showWeekNumbers.value);
    }
    if (accentId.present) {
      map['accent_id'] = Variable<int>(accentId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsTableCompanion(')
          ..write('id: $id, ')
          ..write('themeMode: $themeMode, ')
          ..write('weekStart: $weekStart, ')
          ..write('use24h: $use24h, ')
          ..write('defaultAlertTimed: $defaultAlertTimed, ')
          ..write('defaultAlertAllDay: $defaultAlertAllDay, ')
          ..write('digestMorningOn: $digestMorningOn, ')
          ..write('digestMorningMin: $digestMorningMin, ')
          ..write('digestEveningOn: $digestEveningOn, ')
          ..write('digestEveningMin: $digestEveningMin, ')
          ..write('badgeType: $badgeType, ')
          ..write('isPro: $isPro, ')
          ..write('showWeekNumbers: $showWeekNumbers, ')
          ..write('accentId: $accentId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DeletedEventsTable extends DeletedEvents
    with TableInfo<$DeletedEventsTable, DeletedEventRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DeletedEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _calendarIdMeta = const VerificationMeta(
    'calendarId',
  );
  @override
  late final GeneratedColumn<String> calendarId = GeneratedColumn<String>(
    'calendar_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _allDayMeta = const VerificationMeta('allDay');
  @override
  late final GeneratedColumn<bool> allDay = GeneratedColumn<bool>(
    'all_day',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("all_day" IN (0, 1))',
    ),
  );
  static const VerificationMeta _startMeta = const VerificationMeta('start');
  @override
  late final GeneratedColumn<DateTime> start = GeneratedColumn<DateTime>(
    'start',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endMeta = const VerificationMeta('end');
  @override
  late final GeneratedColumn<DateTime> end = GeneratedColumn<DateTime>(
    'end',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorIdMeta = const VerificationMeta(
    'colorId',
  );
  @override
  late final GeneratedColumn<int> colorId = GeneratedColumn<int>(
    'color_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
    'url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recFreqMeta = const VerificationMeta(
    'recFreq',
  );
  @override
  late final GeneratedColumn<int> recFreq = GeneratedColumn<int>(
    'rec_freq',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _recIntervalMeta = const VerificationMeta(
    'recInterval',
  );
  @override
  late final GeneratedColumn<int> recInterval = GeneratedColumn<int>(
    'rec_interval',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _recEndKindMeta = const VerificationMeta(
    'recEndKind',
  );
  @override
  late final GeneratedColumn<int> recEndKind = GeneratedColumn<int>(
    'rec_end_kind',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _recUntilMeta = const VerificationMeta(
    'recUntil',
  );
  @override
  late final GeneratedColumn<DateTime> recUntil = GeneratedColumn<DateTime>(
    'rec_until',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recCountMeta = const VerificationMeta(
    'recCount',
  );
  @override
  late final GeneratedColumn<int> recCount = GeneratedColumn<int>(
    'rec_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _alertMinutesMeta = const VerificationMeta(
    'alertMinutes',
  );
  @override
  late final GeneratedColumn<int> alertMinutes = GeneratedColumn<int>(
    'alert_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    calendarId,
    title,
    allDay,
    start,
    end,
    colorId,
    location,
    url,
    notes,
    recFreq,
    recInterval,
    recEndKind,
    recUntil,
    recCount,
    alertMinutes,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'deleted_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<DeletedEventRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('calendar_id')) {
      context.handle(
        _calendarIdMeta,
        calendarId.isAcceptableOrUnknown(data['calendar_id']!, _calendarIdMeta),
      );
    } else if (isInserting) {
      context.missing(_calendarIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('all_day')) {
      context.handle(
        _allDayMeta,
        allDay.isAcceptableOrUnknown(data['all_day']!, _allDayMeta),
      );
    } else if (isInserting) {
      context.missing(_allDayMeta);
    }
    if (data.containsKey('start')) {
      context.handle(
        _startMeta,
        start.isAcceptableOrUnknown(data['start']!, _startMeta),
      );
    } else if (isInserting) {
      context.missing(_startMeta);
    }
    if (data.containsKey('end')) {
      context.handle(
        _endMeta,
        end.isAcceptableOrUnknown(data['end']!, _endMeta),
      );
    } else if (isInserting) {
      context.missing(_endMeta);
    }
    if (data.containsKey('color_id')) {
      context.handle(
        _colorIdMeta,
        colorId.isAcceptableOrUnknown(data['color_id']!, _colorIdMeta),
      );
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    }
    if (data.containsKey('url')) {
      context.handle(
        _urlMeta,
        url.isAcceptableOrUnknown(data['url']!, _urlMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('rec_freq')) {
      context.handle(
        _recFreqMeta,
        recFreq.isAcceptableOrUnknown(data['rec_freq']!, _recFreqMeta),
      );
    }
    if (data.containsKey('rec_interval')) {
      context.handle(
        _recIntervalMeta,
        recInterval.isAcceptableOrUnknown(
          data['rec_interval']!,
          _recIntervalMeta,
        ),
      );
    }
    if (data.containsKey('rec_end_kind')) {
      context.handle(
        _recEndKindMeta,
        recEndKind.isAcceptableOrUnknown(
          data['rec_end_kind']!,
          _recEndKindMeta,
        ),
      );
    }
    if (data.containsKey('rec_until')) {
      context.handle(
        _recUntilMeta,
        recUntil.isAcceptableOrUnknown(data['rec_until']!, _recUntilMeta),
      );
    }
    if (data.containsKey('rec_count')) {
      context.handle(
        _recCountMeta,
        recCount.isAcceptableOrUnknown(data['rec_count']!, _recCountMeta),
      );
    }
    if (data.containsKey('alert_minutes')) {
      context.handle(
        _alertMinutesMeta,
        alertMinutes.isAcceptableOrUnknown(
          data['alert_minutes']!,
          _alertMinutesMeta,
        ),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_deletedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DeletedEventRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DeletedEventRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      calendarId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}calendar_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      allDay: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}all_day'],
      )!,
      start: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start'],
      )!,
      end: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end'],
      )!,
      colorId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color_id'],
      ),
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      ),
      url: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}url'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      recFreq: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rec_freq'],
      )!,
      recInterval: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rec_interval'],
      )!,
      recEndKind: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rec_end_kind'],
      )!,
      recUntil: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}rec_until'],
      ),
      recCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rec_count'],
      ),
      alertMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}alert_minutes'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      )!,
    );
  }

  @override
  $DeletedEventsTable createAlias(String alias) {
    return $DeletedEventsTable(attachedDatabase, alias);
  }
}

class DeletedEventRow extends DataClass implements Insertable<DeletedEventRow> {
  final String id;
  final String calendarId;
  final String title;
  final bool allDay;
  final DateTime start;
  final DateTime end;
  final int? colorId;
  final String? location;
  final String? url;
  final String? notes;
  final int recFreq;
  final int recInterval;
  final int recEndKind;
  final DateTime? recUntil;
  final int? recCount;
  final int? alertMinutes;
  final DateTime deletedAt;
  const DeletedEventRow({
    required this.id,
    required this.calendarId,
    required this.title,
    required this.allDay,
    required this.start,
    required this.end,
    this.colorId,
    this.location,
    this.url,
    this.notes,
    required this.recFreq,
    required this.recInterval,
    required this.recEndKind,
    this.recUntil,
    this.recCount,
    this.alertMinutes,
    required this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['calendar_id'] = Variable<String>(calendarId);
    map['title'] = Variable<String>(title);
    map['all_day'] = Variable<bool>(allDay);
    map['start'] = Variable<DateTime>(start);
    map['end'] = Variable<DateTime>(end);
    if (!nullToAbsent || colorId != null) {
      map['color_id'] = Variable<int>(colorId);
    }
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    if (!nullToAbsent || url != null) {
      map['url'] = Variable<String>(url);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['rec_freq'] = Variable<int>(recFreq);
    map['rec_interval'] = Variable<int>(recInterval);
    map['rec_end_kind'] = Variable<int>(recEndKind);
    if (!nullToAbsent || recUntil != null) {
      map['rec_until'] = Variable<DateTime>(recUntil);
    }
    if (!nullToAbsent || recCount != null) {
      map['rec_count'] = Variable<int>(recCount);
    }
    if (!nullToAbsent || alertMinutes != null) {
      map['alert_minutes'] = Variable<int>(alertMinutes);
    }
    map['deleted_at'] = Variable<DateTime>(deletedAt);
    return map;
  }

  DeletedEventsCompanion toCompanion(bool nullToAbsent) {
    return DeletedEventsCompanion(
      id: Value(id),
      calendarId: Value(calendarId),
      title: Value(title),
      allDay: Value(allDay),
      start: Value(start),
      end: Value(end),
      colorId: colorId == null && nullToAbsent
          ? const Value.absent()
          : Value(colorId),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
      url: url == null && nullToAbsent ? const Value.absent() : Value(url),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      recFreq: Value(recFreq),
      recInterval: Value(recInterval),
      recEndKind: Value(recEndKind),
      recUntil: recUntil == null && nullToAbsent
          ? const Value.absent()
          : Value(recUntil),
      recCount: recCount == null && nullToAbsent
          ? const Value.absent()
          : Value(recCount),
      alertMinutes: alertMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(alertMinutes),
      deletedAt: Value(deletedAt),
    );
  }

  factory DeletedEventRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DeletedEventRow(
      id: serializer.fromJson<String>(json['id']),
      calendarId: serializer.fromJson<String>(json['calendarId']),
      title: serializer.fromJson<String>(json['title']),
      allDay: serializer.fromJson<bool>(json['allDay']),
      start: serializer.fromJson<DateTime>(json['start']),
      end: serializer.fromJson<DateTime>(json['end']),
      colorId: serializer.fromJson<int?>(json['colorId']),
      location: serializer.fromJson<String?>(json['location']),
      url: serializer.fromJson<String?>(json['url']),
      notes: serializer.fromJson<String?>(json['notes']),
      recFreq: serializer.fromJson<int>(json['recFreq']),
      recInterval: serializer.fromJson<int>(json['recInterval']),
      recEndKind: serializer.fromJson<int>(json['recEndKind']),
      recUntil: serializer.fromJson<DateTime?>(json['recUntil']),
      recCount: serializer.fromJson<int?>(json['recCount']),
      alertMinutes: serializer.fromJson<int?>(json['alertMinutes']),
      deletedAt: serializer.fromJson<DateTime>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'calendarId': serializer.toJson<String>(calendarId),
      'title': serializer.toJson<String>(title),
      'allDay': serializer.toJson<bool>(allDay),
      'start': serializer.toJson<DateTime>(start),
      'end': serializer.toJson<DateTime>(end),
      'colorId': serializer.toJson<int?>(colorId),
      'location': serializer.toJson<String?>(location),
      'url': serializer.toJson<String?>(url),
      'notes': serializer.toJson<String?>(notes),
      'recFreq': serializer.toJson<int>(recFreq),
      'recInterval': serializer.toJson<int>(recInterval),
      'recEndKind': serializer.toJson<int>(recEndKind),
      'recUntil': serializer.toJson<DateTime?>(recUntil),
      'recCount': serializer.toJson<int?>(recCount),
      'alertMinutes': serializer.toJson<int?>(alertMinutes),
      'deletedAt': serializer.toJson<DateTime>(deletedAt),
    };
  }

  DeletedEventRow copyWith({
    String? id,
    String? calendarId,
    String? title,
    bool? allDay,
    DateTime? start,
    DateTime? end,
    Value<int?> colorId = const Value.absent(),
    Value<String?> location = const Value.absent(),
    Value<String?> url = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    int? recFreq,
    int? recInterval,
    int? recEndKind,
    Value<DateTime?> recUntil = const Value.absent(),
    Value<int?> recCount = const Value.absent(),
    Value<int?> alertMinutes = const Value.absent(),
    DateTime? deletedAt,
  }) => DeletedEventRow(
    id: id ?? this.id,
    calendarId: calendarId ?? this.calendarId,
    title: title ?? this.title,
    allDay: allDay ?? this.allDay,
    start: start ?? this.start,
    end: end ?? this.end,
    colorId: colorId.present ? colorId.value : this.colorId,
    location: location.present ? location.value : this.location,
    url: url.present ? url.value : this.url,
    notes: notes.present ? notes.value : this.notes,
    recFreq: recFreq ?? this.recFreq,
    recInterval: recInterval ?? this.recInterval,
    recEndKind: recEndKind ?? this.recEndKind,
    recUntil: recUntil.present ? recUntil.value : this.recUntil,
    recCount: recCount.present ? recCount.value : this.recCount,
    alertMinutes: alertMinutes.present ? alertMinutes.value : this.alertMinutes,
    deletedAt: deletedAt ?? this.deletedAt,
  );
  DeletedEventRow copyWithCompanion(DeletedEventsCompanion data) {
    return DeletedEventRow(
      id: data.id.present ? data.id.value : this.id,
      calendarId: data.calendarId.present
          ? data.calendarId.value
          : this.calendarId,
      title: data.title.present ? data.title.value : this.title,
      allDay: data.allDay.present ? data.allDay.value : this.allDay,
      start: data.start.present ? data.start.value : this.start,
      end: data.end.present ? data.end.value : this.end,
      colorId: data.colorId.present ? data.colorId.value : this.colorId,
      location: data.location.present ? data.location.value : this.location,
      url: data.url.present ? data.url.value : this.url,
      notes: data.notes.present ? data.notes.value : this.notes,
      recFreq: data.recFreq.present ? data.recFreq.value : this.recFreq,
      recInterval: data.recInterval.present
          ? data.recInterval.value
          : this.recInterval,
      recEndKind: data.recEndKind.present
          ? data.recEndKind.value
          : this.recEndKind,
      recUntil: data.recUntil.present ? data.recUntil.value : this.recUntil,
      recCount: data.recCount.present ? data.recCount.value : this.recCount,
      alertMinutes: data.alertMinutes.present
          ? data.alertMinutes.value
          : this.alertMinutes,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DeletedEventRow(')
          ..write('id: $id, ')
          ..write('calendarId: $calendarId, ')
          ..write('title: $title, ')
          ..write('allDay: $allDay, ')
          ..write('start: $start, ')
          ..write('end: $end, ')
          ..write('colorId: $colorId, ')
          ..write('location: $location, ')
          ..write('url: $url, ')
          ..write('notes: $notes, ')
          ..write('recFreq: $recFreq, ')
          ..write('recInterval: $recInterval, ')
          ..write('recEndKind: $recEndKind, ')
          ..write('recUntil: $recUntil, ')
          ..write('recCount: $recCount, ')
          ..write('alertMinutes: $alertMinutes, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    calendarId,
    title,
    allDay,
    start,
    end,
    colorId,
    location,
    url,
    notes,
    recFreq,
    recInterval,
    recEndKind,
    recUntil,
    recCount,
    alertMinutes,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DeletedEventRow &&
          other.id == this.id &&
          other.calendarId == this.calendarId &&
          other.title == this.title &&
          other.allDay == this.allDay &&
          other.start == this.start &&
          other.end == this.end &&
          other.colorId == this.colorId &&
          other.location == this.location &&
          other.url == this.url &&
          other.notes == this.notes &&
          other.recFreq == this.recFreq &&
          other.recInterval == this.recInterval &&
          other.recEndKind == this.recEndKind &&
          other.recUntil == this.recUntil &&
          other.recCount == this.recCount &&
          other.alertMinutes == this.alertMinutes &&
          other.deletedAt == this.deletedAt);
}

class DeletedEventsCompanion extends UpdateCompanion<DeletedEventRow> {
  final Value<String> id;
  final Value<String> calendarId;
  final Value<String> title;
  final Value<bool> allDay;
  final Value<DateTime> start;
  final Value<DateTime> end;
  final Value<int?> colorId;
  final Value<String?> location;
  final Value<String?> url;
  final Value<String?> notes;
  final Value<int> recFreq;
  final Value<int> recInterval;
  final Value<int> recEndKind;
  final Value<DateTime?> recUntil;
  final Value<int?> recCount;
  final Value<int?> alertMinutes;
  final Value<DateTime> deletedAt;
  final Value<int> rowid;
  const DeletedEventsCompanion({
    this.id = const Value.absent(),
    this.calendarId = const Value.absent(),
    this.title = const Value.absent(),
    this.allDay = const Value.absent(),
    this.start = const Value.absent(),
    this.end = const Value.absent(),
    this.colorId = const Value.absent(),
    this.location = const Value.absent(),
    this.url = const Value.absent(),
    this.notes = const Value.absent(),
    this.recFreq = const Value.absent(),
    this.recInterval = const Value.absent(),
    this.recEndKind = const Value.absent(),
    this.recUntil = const Value.absent(),
    this.recCount = const Value.absent(),
    this.alertMinutes = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DeletedEventsCompanion.insert({
    required String id,
    required String calendarId,
    required String title,
    required bool allDay,
    required DateTime start,
    required DateTime end,
    this.colorId = const Value.absent(),
    this.location = const Value.absent(),
    this.url = const Value.absent(),
    this.notes = const Value.absent(),
    this.recFreq = const Value.absent(),
    this.recInterval = const Value.absent(),
    this.recEndKind = const Value.absent(),
    this.recUntil = const Value.absent(),
    this.recCount = const Value.absent(),
    this.alertMinutes = const Value.absent(),
    required DateTime deletedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       calendarId = Value(calendarId),
       title = Value(title),
       allDay = Value(allDay),
       start = Value(start),
       end = Value(end),
       deletedAt = Value(deletedAt);
  static Insertable<DeletedEventRow> custom({
    Expression<String>? id,
    Expression<String>? calendarId,
    Expression<String>? title,
    Expression<bool>? allDay,
    Expression<DateTime>? start,
    Expression<DateTime>? end,
    Expression<int>? colorId,
    Expression<String>? location,
    Expression<String>? url,
    Expression<String>? notes,
    Expression<int>? recFreq,
    Expression<int>? recInterval,
    Expression<int>? recEndKind,
    Expression<DateTime>? recUntil,
    Expression<int>? recCount,
    Expression<int>? alertMinutes,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (calendarId != null) 'calendar_id': calendarId,
      if (title != null) 'title': title,
      if (allDay != null) 'all_day': allDay,
      if (start != null) 'start': start,
      if (end != null) 'end': end,
      if (colorId != null) 'color_id': colorId,
      if (location != null) 'location': location,
      if (url != null) 'url': url,
      if (notes != null) 'notes': notes,
      if (recFreq != null) 'rec_freq': recFreq,
      if (recInterval != null) 'rec_interval': recInterval,
      if (recEndKind != null) 'rec_end_kind': recEndKind,
      if (recUntil != null) 'rec_until': recUntil,
      if (recCount != null) 'rec_count': recCount,
      if (alertMinutes != null) 'alert_minutes': alertMinutes,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DeletedEventsCompanion copyWith({
    Value<String>? id,
    Value<String>? calendarId,
    Value<String>? title,
    Value<bool>? allDay,
    Value<DateTime>? start,
    Value<DateTime>? end,
    Value<int?>? colorId,
    Value<String?>? location,
    Value<String?>? url,
    Value<String?>? notes,
    Value<int>? recFreq,
    Value<int>? recInterval,
    Value<int>? recEndKind,
    Value<DateTime?>? recUntil,
    Value<int?>? recCount,
    Value<int?>? alertMinutes,
    Value<DateTime>? deletedAt,
    Value<int>? rowid,
  }) {
    return DeletedEventsCompanion(
      id: id ?? this.id,
      calendarId: calendarId ?? this.calendarId,
      title: title ?? this.title,
      allDay: allDay ?? this.allDay,
      start: start ?? this.start,
      end: end ?? this.end,
      colorId: colorId ?? this.colorId,
      location: location ?? this.location,
      url: url ?? this.url,
      notes: notes ?? this.notes,
      recFreq: recFreq ?? this.recFreq,
      recInterval: recInterval ?? this.recInterval,
      recEndKind: recEndKind ?? this.recEndKind,
      recUntil: recUntil ?? this.recUntil,
      recCount: recCount ?? this.recCount,
      alertMinutes: alertMinutes ?? this.alertMinutes,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (calendarId.present) {
      map['calendar_id'] = Variable<String>(calendarId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (allDay.present) {
      map['all_day'] = Variable<bool>(allDay.value);
    }
    if (start.present) {
      map['start'] = Variable<DateTime>(start.value);
    }
    if (end.present) {
      map['end'] = Variable<DateTime>(end.value);
    }
    if (colorId.present) {
      map['color_id'] = Variable<int>(colorId.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (recFreq.present) {
      map['rec_freq'] = Variable<int>(recFreq.value);
    }
    if (recInterval.present) {
      map['rec_interval'] = Variable<int>(recInterval.value);
    }
    if (recEndKind.present) {
      map['rec_end_kind'] = Variable<int>(recEndKind.value);
    }
    if (recUntil.present) {
      map['rec_until'] = Variable<DateTime>(recUntil.value);
    }
    if (recCount.present) {
      map['rec_count'] = Variable<int>(recCount.value);
    }
    if (alertMinutes.present) {
      map['alert_minutes'] = Variable<int>(alertMinutes.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DeletedEventsCompanion(')
          ..write('id: $id, ')
          ..write('calendarId: $calendarId, ')
          ..write('title: $title, ')
          ..write('allDay: $allDay, ')
          ..write('start: $start, ')
          ..write('end: $end, ')
          ..write('colorId: $colorId, ')
          ..write('location: $location, ')
          ..write('url: $url, ')
          ..write('notes: $notes, ')
          ..write('recFreq: $recFreq, ')
          ..write('recInterval: $recInterval, ')
          ..write('recEndKind: $recEndKind, ')
          ..write('recUntil: $recUntil, ')
          ..write('recCount: $recCount, ')
          ..write('alertMinutes: $alertMinutes, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CalendarsTable calendars = $CalendarsTable(this);
  late final $EventsTable events = $EventsTable(this);
  late final $AppSettingsTableTable appSettingsTable = $AppSettingsTableTable(
    this,
  );
  late final $DeletedEventsTable deletedEvents = $DeletedEventsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    calendars,
    events,
    appSettingsTable,
    deletedEvents,
  ];
}

typedef $$CalendarsTableCreateCompanionBuilder = CalendarsCompanion Function({
  required String id,
  required String title,
  required int colorId,
  Value<bool> isDefault,
  Value<bool> isVisible,
  Value<int> displayOrder,
  Value<int> rowid,
});
typedef $$CalendarsTableUpdateCompanionBuilder = CalendarsCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<int> colorId,
  Value<bool> isDefault,
  Value<bool> isVisible,
  Value<int> displayOrder,
  Value<int> rowid,
});

final class $$CalendarsTableReferences
    extends BaseReferences<_$AppDatabase, $CalendarsTable, CalendarRow> {
  $$CalendarsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$EventsTable, List<EventRow>> _eventsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.events,
    aliasName: 'calendars__id__events__calendar_id',
  );

  $$EventsTableProcessedTableManager get eventsRefs {
    final manager = $$EventsTableTableManager(
      $_db,
      $_db.events,
    ).filter((f) => f.calendarId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_eventsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CalendarsTableFilterComposer
    extends Composer<_$AppDatabase, $CalendarsTable> {
  $$CalendarsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get colorId => $composableBuilder(
    column: $table.colorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isVisible => $composableBuilder(
    column: $table.isVisible,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> eventsRefs(
    Expression<bool> Function($$EventsTableFilterComposer f) f,
  ) {
    final $$EventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.calendarId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableFilterComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CalendarsTableOrderingComposer
    extends Composer<_$AppDatabase, $CalendarsTable> {
  $$CalendarsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get colorId => $composableBuilder(
    column: $table.colorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isVisible => $composableBuilder(
    column: $table.isVisible,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CalendarsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CalendarsTable> {
  $$CalendarsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get colorId =>
      $composableBuilder(column: $table.colorId, builder: (column) => column);

  GeneratedColumn<bool> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);

  GeneratedColumn<bool> get isVisible =>
      $composableBuilder(column: $table.isVisible, builder: (column) => column);

  GeneratedColumn<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => column,
  );

  Expression<T> eventsRefs<T extends Object>(
    Expression<T> Function($$EventsTableAnnotationComposer a) f,
  ) {
    final $$EventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.calendarId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableAnnotationComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CalendarsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CalendarsTable,
          CalendarRow,
          $$CalendarsTableFilterComposer,
          $$CalendarsTableOrderingComposer,
          $$CalendarsTableAnnotationComposer,
          $$CalendarsTableCreateCompanionBuilder,
          $$CalendarsTableUpdateCompanionBuilder,
          (CalendarRow, $$CalendarsTableReferences),
          CalendarRow,
          PrefetchHooks Function({bool eventsRefs})
        > {
  $$CalendarsTableTableManager(_$AppDatabase db, $CalendarsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CalendarsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CalendarsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CalendarsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int> colorId = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                Value<bool> isVisible = const Value.absent(),
                Value<int> displayOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CalendarsCompanion(
                id: id,
                title: title,
                colorId: colorId,
                isDefault: isDefault,
                isVisible: isVisible,
                displayOrder: displayOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required int colorId,
                Value<bool> isDefault = const Value.absent(),
                Value<bool> isVisible = const Value.absent(),
                Value<int> displayOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CalendarsCompanion.insert(
                id: id,
                title: title,
                colorId: colorId,
                isDefault: isDefault,
                isVisible: isVisible,
                displayOrder: displayOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CalendarsTable, CalendarRow>(table),
                  $$CalendarsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({eventsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (eventsRefs) db.events],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (eventsRefs)
                    await $_getPrefetchedDataByColumns<
                      CalendarRow,
                      $CalendarsTable,
                      EventRow,
                      $EventsTable
                    >(
                      currentTable: table,
                      referencedTable: $$CalendarsTableReferences
                          ._eventsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CalendarsTableReferences(db, table, p0).eventsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'calendar_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CalendarsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CalendarsTable,
      CalendarRow,
      $$CalendarsTableFilterComposer,
      $$CalendarsTableOrderingComposer,
      $$CalendarsTableAnnotationComposer,
      $$CalendarsTableCreateCompanionBuilder,
      $$CalendarsTableUpdateCompanionBuilder,
      (CalendarRow, $$CalendarsTableReferences),
      CalendarRow,
      PrefetchHooks Function({bool eventsRefs})
    >;
typedef $$EventsTableCreateCompanionBuilder = EventsCompanion Function({
  required String id,
  required String calendarId,
  required String title,
  Value<bool> allDay,
  required DateTime start,
  required DateTime end,
  Value<int?> colorId,
  Value<String?> location,
  Value<String?> url,
  Value<String?> notes,
  Value<int> recFreq,
  Value<int> recInterval,
  Value<int> recEndKind,
  Value<DateTime?> recUntil,
  Value<int?> recCount,
  Value<int?> alertMinutes,
  Value<int> rowid,
});
typedef $$EventsTableUpdateCompanionBuilder = EventsCompanion Function({
  Value<String> id,
  Value<String> calendarId,
  Value<String> title,
  Value<bool> allDay,
  Value<DateTime> start,
  Value<DateTime> end,
  Value<int?> colorId,
  Value<String?> location,
  Value<String?> url,
  Value<String?> notes,
  Value<int> recFreq,
  Value<int> recInterval,
  Value<int> recEndKind,
  Value<DateTime?> recUntil,
  Value<int?> recCount,
  Value<int?> alertMinutes,
  Value<int> rowid,
});

final class $$EventsTableReferences
    extends BaseReferences<_$AppDatabase, $EventsTable, EventRow> {
  $$EventsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CalendarsTable _calendarIdTable(_$AppDatabase db) =>
      db.calendars.createAlias('events__calendar_id__calendars__id');

  $$CalendarsTableProcessedTableManager get calendarId {
    final $_column = $_itemColumn<String>('calendar_id')!;

    final manager = $$CalendarsTableTableManager(
      $_db,
      $_db.calendars,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_calendarIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EventsTableFilterComposer
    extends Composer<_$AppDatabase, $EventsTable> {
  $$EventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get allDay => $composableBuilder(
    column: $table.allDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get start => $composableBuilder(
    column: $table.start,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get end => $composableBuilder(
    column: $table.end,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get colorId => $composableBuilder(
    column: $table.colorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get recFreq => $composableBuilder(
    column: $table.recFreq,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get recInterval => $composableBuilder(
    column: $table.recInterval,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get recEndKind => $composableBuilder(
    column: $table.recEndKind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get recUntil => $composableBuilder(
    column: $table.recUntil,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get recCount => $composableBuilder(
    column: $table.recCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get alertMinutes => $composableBuilder(
    column: $table.alertMinutes,
    builder: (column) => ColumnFilters(column),
  );

  $$CalendarsTableFilterComposer get calendarId {
    final $$CalendarsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.calendarId,
      referencedTable: $db.calendars,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CalendarsTableFilterComposer(
            $db: $db,
            $table: $db.calendars,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventsTableOrderingComposer
    extends Composer<_$AppDatabase, $EventsTable> {
  $$EventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get allDay => $composableBuilder(
    column: $table.allDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get start => $composableBuilder(
    column: $table.start,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get end => $composableBuilder(
    column: $table.end,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get colorId => $composableBuilder(
    column: $table.colorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get recFreq => $composableBuilder(
    column: $table.recFreq,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get recInterval => $composableBuilder(
    column: $table.recInterval,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get recEndKind => $composableBuilder(
    column: $table.recEndKind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get recUntil => $composableBuilder(
    column: $table.recUntil,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get recCount => $composableBuilder(
    column: $table.recCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get alertMinutes => $composableBuilder(
    column: $table.alertMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  $$CalendarsTableOrderingComposer get calendarId {
    final $$CalendarsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.calendarId,
      referencedTable: $db.calendars,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CalendarsTableOrderingComposer(
            $db: $db,
            $table: $db.calendars,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EventsTable> {
  $$EventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<bool> get allDay =>
      $composableBuilder(column: $table.allDay, builder: (column) => column);

  GeneratedColumn<DateTime> get start =>
      $composableBuilder(column: $table.start, builder: (column) => column);

  GeneratedColumn<DateTime> get end =>
      $composableBuilder(column: $table.end, builder: (column) => column);

  GeneratedColumn<int> get colorId =>
      $composableBuilder(column: $table.colorId, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get recFreq =>
      $composableBuilder(column: $table.recFreq, builder: (column) => column);

  GeneratedColumn<int> get recInterval => $composableBuilder(
    column: $table.recInterval,
    builder: (column) => column,
  );

  GeneratedColumn<int> get recEndKind => $composableBuilder(
    column: $table.recEndKind,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get recUntil =>
      $composableBuilder(column: $table.recUntil, builder: (column) => column);

  GeneratedColumn<int> get recCount =>
      $composableBuilder(column: $table.recCount, builder: (column) => column);

  GeneratedColumn<int> get alertMinutes => $composableBuilder(
    column: $table.alertMinutes,
    builder: (column) => column,
  );

  $$CalendarsTableAnnotationComposer get calendarId {
    final $$CalendarsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.calendarId,
      referencedTable: $db.calendars,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CalendarsTableAnnotationComposer(
            $db: $db,
            $table: $db.calendars,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EventsTable,
          EventRow,
          $$EventsTableFilterComposer,
          $$EventsTableOrderingComposer,
          $$EventsTableAnnotationComposer,
          $$EventsTableCreateCompanionBuilder,
          $$EventsTableUpdateCompanionBuilder,
          (EventRow, $$EventsTableReferences),
          EventRow,
          PrefetchHooks Function({bool calendarId})
        > {
  $$EventsTableTableManager(_$AppDatabase db, $EventsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> calendarId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<bool> allDay = const Value.absent(),
                Value<DateTime> start = const Value.absent(),
                Value<DateTime> end = const Value.absent(),
                Value<int?> colorId = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<String?> url = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> recFreq = const Value.absent(),
                Value<int> recInterval = const Value.absent(),
                Value<int> recEndKind = const Value.absent(),
                Value<DateTime?> recUntil = const Value.absent(),
                Value<int?> recCount = const Value.absent(),
                Value<int?> alertMinutes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EventsCompanion(
                id: id,
                calendarId: calendarId,
                title: title,
                allDay: allDay,
                start: start,
                end: end,
                colorId: colorId,
                location: location,
                url: url,
                notes: notes,
                recFreq: recFreq,
                recInterval: recInterval,
                recEndKind: recEndKind,
                recUntil: recUntil,
                recCount: recCount,
                alertMinutes: alertMinutes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String calendarId,
                required String title,
                Value<bool> allDay = const Value.absent(),
                required DateTime start,
                required DateTime end,
                Value<int?> colorId = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<String?> url = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> recFreq = const Value.absent(),
                Value<int> recInterval = const Value.absent(),
                Value<int> recEndKind = const Value.absent(),
                Value<DateTime?> recUntil = const Value.absent(),
                Value<int?> recCount = const Value.absent(),
                Value<int?> alertMinutes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EventsCompanion.insert(
                id: id,
                calendarId: calendarId,
                title: title,
                allDay: allDay,
                start: start,
                end: end,
                colorId: colorId,
                location: location,
                url: url,
                notes: notes,
                recFreq: recFreq,
                recInterval: recInterval,
                recEndKind: recEndKind,
                recUntil: recUntil,
                recCount: recCount,
                alertMinutes: alertMinutes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$EventsTable, EventRow>(table),
                  $$EventsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({calendarId = false}) {
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
                    if (calendarId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.calendarId,
                        referencedTable: $$EventsTableReferences
                            ._calendarIdTable(db),
                        referencedColumn: $$EventsTableReferences
                            ._calendarIdTable(db)
                            .id,
                      ) as T;
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

typedef $$EventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EventsTable,
      EventRow,
      $$EventsTableFilterComposer,
      $$EventsTableOrderingComposer,
      $$EventsTableAnnotationComposer,
      $$EventsTableCreateCompanionBuilder,
      $$EventsTableUpdateCompanionBuilder,
      (EventRow, $$EventsTableReferences),
      EventRow,
      PrefetchHooks Function({bool calendarId})
    >;
typedef $$AppSettingsTableTableCreateCompanionBuilder =
    AppSettingsTableCompanion Function({
      Value<String> id,
      Value<int> themeMode,
      Value<int> weekStart,
      Value<bool> use24h,
      Value<int?> defaultAlertTimed,
      Value<int?> defaultAlertAllDay,
      Value<bool> digestMorningOn,
      Value<int> digestMorningMin,
      Value<bool> digestEveningOn,
      Value<int> digestEveningMin,
      Value<int> badgeType,
      Value<bool> isPro,
      Value<bool> showWeekNumbers,
      Value<int> accentId,
      Value<int> rowid,
    });
typedef $$AppSettingsTableTableUpdateCompanionBuilder =
    AppSettingsTableCompanion Function({
      Value<String> id,
      Value<int> themeMode,
      Value<int> weekStart,
      Value<bool> use24h,
      Value<int?> defaultAlertTimed,
      Value<int?> defaultAlertAllDay,
      Value<bool> digestMorningOn,
      Value<int> digestMorningMin,
      Value<bool> digestEveningOn,
      Value<int> digestEveningMin,
      Value<int> badgeType,
      Value<bool> isPro,
      Value<bool> showWeekNumbers,
      Value<int> accentId,
      Value<int> rowid,
    });

class $$AppSettingsTableTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTableTable> {
  $$AppSettingsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weekStart => $composableBuilder(
    column: $table.weekStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get use24h => $composableBuilder(
    column: $table.use24h,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get defaultAlertTimed => $composableBuilder(
    column: $table.defaultAlertTimed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get defaultAlertAllDay => $composableBuilder(
    column: $table.defaultAlertAllDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get digestMorningOn => $composableBuilder(
    column: $table.digestMorningOn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get digestMorningMin => $composableBuilder(
    column: $table.digestMorningMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get digestEveningOn => $composableBuilder(
    column: $table.digestEveningOn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get digestEveningMin => $composableBuilder(
    column: $table.digestEveningMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get badgeType => $composableBuilder(
    column: $table.badgeType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPro => $composableBuilder(
    column: $table.isPro,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get showWeekNumbers => $composableBuilder(
    column: $table.showWeekNumbers,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get accentId => $composableBuilder(
    column: $table.accentId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTableTable> {
  $$AppSettingsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weekStart => $composableBuilder(
    column: $table.weekStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get use24h => $composableBuilder(
    column: $table.use24h,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get defaultAlertTimed => $composableBuilder(
    column: $table.defaultAlertTimed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get defaultAlertAllDay => $composableBuilder(
    column: $table.defaultAlertAllDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get digestMorningOn => $composableBuilder(
    column: $table.digestMorningOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get digestMorningMin => $composableBuilder(
    column: $table.digestMorningMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get digestEveningOn => $composableBuilder(
    column: $table.digestEveningOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get digestEveningMin => $composableBuilder(
    column: $table.digestEveningMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get badgeType => $composableBuilder(
    column: $table.badgeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPro => $composableBuilder(
    column: $table.isPro,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get showWeekNumbers => $composableBuilder(
    column: $table.showWeekNumbers,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get accentId => $composableBuilder(
    column: $table.accentId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTableTable> {
  $$AppSettingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  GeneratedColumn<int> get weekStart =>
      $composableBuilder(column: $table.weekStart, builder: (column) => column);

  GeneratedColumn<bool> get use24h =>
      $composableBuilder(column: $table.use24h, builder: (column) => column);

  GeneratedColumn<int> get defaultAlertTimed => $composableBuilder(
    column: $table.defaultAlertTimed,
    builder: (column) => column,
  );

  GeneratedColumn<int> get defaultAlertAllDay => $composableBuilder(
    column: $table.defaultAlertAllDay,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get digestMorningOn => $composableBuilder(
    column: $table.digestMorningOn,
    builder: (column) => column,
  );

  GeneratedColumn<int> get digestMorningMin => $composableBuilder(
    column: $table.digestMorningMin,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get digestEveningOn => $composableBuilder(
    column: $table.digestEveningOn,
    builder: (column) => column,
  );

  GeneratedColumn<int> get digestEveningMin => $composableBuilder(
    column: $table.digestEveningMin,
    builder: (column) => column,
  );

  GeneratedColumn<int> get badgeType =>
      $composableBuilder(column: $table.badgeType, builder: (column) => column);

  GeneratedColumn<bool> get isPro =>
      $composableBuilder(column: $table.isPro, builder: (column) => column);

  GeneratedColumn<bool> get showWeekNumbers => $composableBuilder(
    column: $table.showWeekNumbers,
    builder: (column) => column,
  );

  GeneratedColumn<int> get accentId =>
      $composableBuilder(column: $table.accentId, builder: (column) => column);
}

class $$AppSettingsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTableTable,
          SettingsRow,
          $$AppSettingsTableTableFilterComposer,
          $$AppSettingsTableTableOrderingComposer,
          $$AppSettingsTableTableAnnotationComposer,
          $$AppSettingsTableTableCreateCompanionBuilder,
          $$AppSettingsTableTableUpdateCompanionBuilder,
          (
            SettingsRow,
            BaseReferences<_$AppDatabase, $AppSettingsTableTable, SettingsRow>,
          ),
          SettingsRow,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableTableManager(
    _$AppDatabase db,
    $AppSettingsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> themeMode = const Value.absent(),
                Value<int> weekStart = const Value.absent(),
                Value<bool> use24h = const Value.absent(),
                Value<int?> defaultAlertTimed = const Value.absent(),
                Value<int?> defaultAlertAllDay = const Value.absent(),
                Value<bool> digestMorningOn = const Value.absent(),
                Value<int> digestMorningMin = const Value.absent(),
                Value<bool> digestEveningOn = const Value.absent(),
                Value<int> digestEveningMin = const Value.absent(),
                Value<int> badgeType = const Value.absent(),
                Value<bool> isPro = const Value.absent(),
                Value<bool> showWeekNumbers = const Value.absent(),
                Value<int> accentId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsTableCompanion(
                id: id,
                themeMode: themeMode,
                weekStart: weekStart,
                use24h: use24h,
                defaultAlertTimed: defaultAlertTimed,
                defaultAlertAllDay: defaultAlertAllDay,
                digestMorningOn: digestMorningOn,
                digestMorningMin: digestMorningMin,
                digestEveningOn: digestEveningOn,
                digestEveningMin: digestEveningMin,
                badgeType: badgeType,
                isPro: isPro,
                showWeekNumbers: showWeekNumbers,
                accentId: accentId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> themeMode = const Value.absent(),
                Value<int> weekStart = const Value.absent(),
                Value<bool> use24h = const Value.absent(),
                Value<int?> defaultAlertTimed = const Value.absent(),
                Value<int?> defaultAlertAllDay = const Value.absent(),
                Value<bool> digestMorningOn = const Value.absent(),
                Value<int> digestMorningMin = const Value.absent(),
                Value<bool> digestEveningOn = const Value.absent(),
                Value<int> digestEveningMin = const Value.absent(),
                Value<int> badgeType = const Value.absent(),
                Value<bool> isPro = const Value.absent(),
                Value<bool> showWeekNumbers = const Value.absent(),
                Value<int> accentId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsTableCompanion.insert(
                id: id,
                themeMode: themeMode,
                weekStart: weekStart,
                use24h: use24h,
                defaultAlertTimed: defaultAlertTimed,
                defaultAlertAllDay: defaultAlertAllDay,
                digestMorningOn: digestMorningOn,
                digestMorningMin: digestMorningMin,
                digestEveningOn: digestEveningOn,
                digestEveningMin: digestEveningMin,
                badgeType: badgeType,
                isPro: isPro,
                showWeekNumbers: showWeekNumbers,
                accentId: accentId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AppSettingsTableTable, SettingsRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $AppSettingsTableTable,
                    SettingsRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTableTable,
      SettingsRow,
      $$AppSettingsTableTableFilterComposer,
      $$AppSettingsTableTableOrderingComposer,
      $$AppSettingsTableTableAnnotationComposer,
      $$AppSettingsTableTableCreateCompanionBuilder,
      $$AppSettingsTableTableUpdateCompanionBuilder,
      (
        SettingsRow,
        BaseReferences<_$AppDatabase, $AppSettingsTableTable, SettingsRow>,
      ),
      SettingsRow,
      PrefetchHooks Function()
    >;
typedef $$DeletedEventsTableCreateCompanionBuilder =
    DeletedEventsCompanion Function({
      required String id,
      required String calendarId,
      required String title,
      required bool allDay,
      required DateTime start,
      required DateTime end,
      Value<int?> colorId,
      Value<String?> location,
      Value<String?> url,
      Value<String?> notes,
      Value<int> recFreq,
      Value<int> recInterval,
      Value<int> recEndKind,
      Value<DateTime?> recUntil,
      Value<int?> recCount,
      Value<int?> alertMinutes,
      required DateTime deletedAt,
      Value<int> rowid,
    });
typedef $$DeletedEventsTableUpdateCompanionBuilder =
    DeletedEventsCompanion Function({
      Value<String> id,
      Value<String> calendarId,
      Value<String> title,
      Value<bool> allDay,
      Value<DateTime> start,
      Value<DateTime> end,
      Value<int?> colorId,
      Value<String?> location,
      Value<String?> url,
      Value<String?> notes,
      Value<int> recFreq,
      Value<int> recInterval,
      Value<int> recEndKind,
      Value<DateTime?> recUntil,
      Value<int?> recCount,
      Value<int?> alertMinutes,
      Value<DateTime> deletedAt,
      Value<int> rowid,
    });

class $$DeletedEventsTableFilterComposer
    extends Composer<_$AppDatabase, $DeletedEventsTable> {
  $$DeletedEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get calendarId => $composableBuilder(
    column: $table.calendarId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get allDay => $composableBuilder(
    column: $table.allDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get start => $composableBuilder(
    column: $table.start,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get end => $composableBuilder(
    column: $table.end,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get colorId => $composableBuilder(
    column: $table.colorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get recFreq => $composableBuilder(
    column: $table.recFreq,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get recInterval => $composableBuilder(
    column: $table.recInterval,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get recEndKind => $composableBuilder(
    column: $table.recEndKind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get recUntil => $composableBuilder(
    column: $table.recUntil,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get recCount => $composableBuilder(
    column: $table.recCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get alertMinutes => $composableBuilder(
    column: $table.alertMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DeletedEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $DeletedEventsTable> {
  $$DeletedEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get calendarId => $composableBuilder(
    column: $table.calendarId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get allDay => $composableBuilder(
    column: $table.allDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get start => $composableBuilder(
    column: $table.start,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get end => $composableBuilder(
    column: $table.end,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get colorId => $composableBuilder(
    column: $table.colorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get recFreq => $composableBuilder(
    column: $table.recFreq,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get recInterval => $composableBuilder(
    column: $table.recInterval,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get recEndKind => $composableBuilder(
    column: $table.recEndKind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get recUntil => $composableBuilder(
    column: $table.recUntil,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get recCount => $composableBuilder(
    column: $table.recCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get alertMinutes => $composableBuilder(
    column: $table.alertMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DeletedEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DeletedEventsTable> {
  $$DeletedEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get calendarId => $composableBuilder(
    column: $table.calendarId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<bool> get allDay =>
      $composableBuilder(column: $table.allDay, builder: (column) => column);

  GeneratedColumn<DateTime> get start =>
      $composableBuilder(column: $table.start, builder: (column) => column);

  GeneratedColumn<DateTime> get end =>
      $composableBuilder(column: $table.end, builder: (column) => column);

  GeneratedColumn<int> get colorId =>
      $composableBuilder(column: $table.colorId, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get recFreq =>
      $composableBuilder(column: $table.recFreq, builder: (column) => column);

  GeneratedColumn<int> get recInterval => $composableBuilder(
    column: $table.recInterval,
    builder: (column) => column,
  );

  GeneratedColumn<int> get recEndKind => $composableBuilder(
    column: $table.recEndKind,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get recUntil =>
      $composableBuilder(column: $table.recUntil, builder: (column) => column);

  GeneratedColumn<int> get recCount =>
      $composableBuilder(column: $table.recCount, builder: (column) => column);

  GeneratedColumn<int> get alertMinutes => $composableBuilder(
    column: $table.alertMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$DeletedEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DeletedEventsTable,
          DeletedEventRow,
          $$DeletedEventsTableFilterComposer,
          $$DeletedEventsTableOrderingComposer,
          $$DeletedEventsTableAnnotationComposer,
          $$DeletedEventsTableCreateCompanionBuilder,
          $$DeletedEventsTableUpdateCompanionBuilder,
          (
            DeletedEventRow,
            BaseReferences<_$AppDatabase, $DeletedEventsTable, DeletedEventRow>,
          ),
          DeletedEventRow,
          PrefetchHooks Function()
        > {
  $$DeletedEventsTableTableManager(_$AppDatabase db, $DeletedEventsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DeletedEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DeletedEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DeletedEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> calendarId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<bool> allDay = const Value.absent(),
                Value<DateTime> start = const Value.absent(),
                Value<DateTime> end = const Value.absent(),
                Value<int?> colorId = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<String?> url = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> recFreq = const Value.absent(),
                Value<int> recInterval = const Value.absent(),
                Value<int> recEndKind = const Value.absent(),
                Value<DateTime?> recUntil = const Value.absent(),
                Value<int?> recCount = const Value.absent(),
                Value<int?> alertMinutes = const Value.absent(),
                Value<DateTime> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DeletedEventsCompanion(
                id: id,
                calendarId: calendarId,
                title: title,
                allDay: allDay,
                start: start,
                end: end,
                colorId: colorId,
                location: location,
                url: url,
                notes: notes,
                recFreq: recFreq,
                recInterval: recInterval,
                recEndKind: recEndKind,
                recUntil: recUntil,
                recCount: recCount,
                alertMinutes: alertMinutes,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String calendarId,
                required String title,
                required bool allDay,
                required DateTime start,
                required DateTime end,
                Value<int?> colorId = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<String?> url = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> recFreq = const Value.absent(),
                Value<int> recInterval = const Value.absent(),
                Value<int> recEndKind = const Value.absent(),
                Value<DateTime?> recUntil = const Value.absent(),
                Value<int?> recCount = const Value.absent(),
                Value<int?> alertMinutes = const Value.absent(),
                required DateTime deletedAt,
                Value<int> rowid = const Value.absent(),
              }) => DeletedEventsCompanion.insert(
                id: id,
                calendarId: calendarId,
                title: title,
                allDay: allDay,
                start: start,
                end: end,
                colorId: colorId,
                location: location,
                url: url,
                notes: notes,
                recFreq: recFreq,
                recInterval: recInterval,
                recEndKind: recEndKind,
                recUntil: recUntil,
                recCount: recCount,
                alertMinutes: alertMinutes,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DeletedEventsTable, DeletedEventRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $DeletedEventsTable,
                    DeletedEventRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DeletedEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DeletedEventsTable,
      DeletedEventRow,
      $$DeletedEventsTableFilterComposer,
      $$DeletedEventsTableOrderingComposer,
      $$DeletedEventsTableAnnotationComposer,
      $$DeletedEventsTableCreateCompanionBuilder,
      $$DeletedEventsTableUpdateCompanionBuilder,
      (
        DeletedEventRow,
        BaseReferences<_$AppDatabase, $DeletedEventsTable, DeletedEventRow>,
      ),
      DeletedEventRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CalendarsTableTableManager get calendars =>
      $$CalendarsTableTableManager(_db, _db.calendars);
  $$EventsTableTableManager get events =>
      $$EventsTableTableManager(_db, _db.events);
  $$AppSettingsTableTableTableManager get appSettingsTable =>
      $$AppSettingsTableTableTableManager(_db, _db.appSettingsTable);
  $$DeletedEventsTableTableManager get deletedEvents =>
      $$DeletedEventsTableTableManager(_db, _db.deletedEvents);
}
