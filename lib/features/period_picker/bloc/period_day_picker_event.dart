part of 'period_day_picker_bloc.dart';

abstract class PeriodDayPickerEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PeriodDaysFetched extends PeriodDayPickerEvent {
  final String userId;
  final DateTime focusedDay;
  PeriodDaysFetched(this.focusedDay, this.userId);
}

class PeriodStartToday extends PeriodDaysFetched {
  PeriodStartToday(super.focusedDay, super.userId);
}

class PeriodEndsToday extends PeriodDaysFetched {
  PeriodEndsToday(super.focusedDay, super.userId);
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
  String userId;
  SavedPeriodDays(this.context, this.userId);
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
