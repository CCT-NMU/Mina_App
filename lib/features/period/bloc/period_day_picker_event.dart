import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:mina_app/data/model/day.dart';

abstract class PeriodDayPickerEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PeriodDaysFetched extends PeriodDayPickerEvent {
  final DateTime focusedDay;
  PeriodDaysFetched(this.focusedDay);
}

class PeriodDayToggled extends PeriodDayPickerEvent {
  final DateTime day;
  PeriodDayToggled(this.day);

  @override
  List<Object> get props => [day];
}

class SavedPeriodDays extends PeriodDayPickerEvent {
  final BuildContext context;
  SavedPeriodDays(this.context);
}

class LoadMoreMonthsForward extends PeriodDayPickerEvent {}

class LoadMoreMonthsBackward extends PeriodDayPickerEvent {}
