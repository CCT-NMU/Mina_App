part of 'period_day_picker_bloc.dart';

abstract class PeriodDayPickerEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PeriodDaysFetched extends PeriodDayPickerEvent {
  final DateTime focusedDay;
  PeriodDaysFetched(this.focusedDay);
}

class PeriodStartToday extends PeriodDaysFetched {
  PeriodStartToday(DateTime focusedDay) : super(focusedDay);
}

class PeriodEndsToday extends PeriodDaysFetched {
  PeriodEndsToday(DateTime focusedDay) : super(focusedDay);
}

class PeriodPickerStatusChanged extends PeriodDayPickerEvent {
  final PeriodDayPickerStatus status;
  PeriodPickerStatusChanged(this.status);
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

class ScrollToIndex extends PeriodDayPickerEvent {
  final int index;
  final double leadingEdge;
  ScrollToIndex(this.index, this.leadingEdge);
}

class LoadMoreMonthsForward extends PeriodDayPickerEvent {
  final int preservedIndex;
  final double leadingEdge;
  LoadMoreMonthsForward(this.preservedIndex, this.leadingEdge);
}

class LoadMoreMonthsBackward extends PeriodDayPickerEvent {
  final int preservedIndex;
  final double leadingEdge;
  LoadMoreMonthsBackward(this.preservedIndex, this.leadingEdge);
}
