part of 'period_day_picker_bloc.dart';

enum PeriodDayPickerStatus { initial, loading, saving, success, failure }

class PeriodDayPickerState extends Equatable {
  final PeriodDayPickerStatus status;
  final Set<DateTime> selectedDays;
  final Set<DateTime> oldDays;
  final List<DateTime> months;
  final double? leadingEdge;
  final int? preservedScrollIndex;
  final int monthsAdded;
  //For tracking scrolling: a date for the first month in List<DateTime> months before List<DateTime> months is updated.

  const PeriodDayPickerState({
    this.status = PeriodDayPickerStatus.initial,
    this.selectedDays = const {},
    this.oldDays = const {},
    this.months = const [],
    this.leadingEdge,
    this.preservedScrollIndex,
    this.monthsAdded = 0,
  });

  PeriodDayPickerState copyWith({
    PeriodDayPickerStatus? status,
    Set<DateTime>? selectedDays,
    Set<DateTime>? oldDays,
    List<DateTime>? months,
    double? leadingEdge,
    int? preservedScrollIndex,
    int? monthsAdded,
  }) {
    return PeriodDayPickerState(
      status: status ?? this.status,
      selectedDays: selectedDays ?? this.selectedDays,
      oldDays: oldDays ?? this.oldDays,
      months: months ?? this.months,
      leadingEdge: leadingEdge ?? this.leadingEdge,
      preservedScrollIndex: preservedScrollIndex ?? this.preservedScrollIndex,
      monthsAdded: monthsAdded ?? this.monthsAdded,
    );
  }

  @override
  List<Object?> get props => [
        status,
        selectedDays,
        oldDays,
        months,
        leadingEdge,
        preservedScrollIndex,
        monthsAdded
      ];
}
