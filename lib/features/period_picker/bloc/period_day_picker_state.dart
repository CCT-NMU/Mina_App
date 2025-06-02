import 'package:equatable/equatable.dart';

enum PeriodDayPickerStatus { initial, loading, saving, success, failure }

class PeriodDayPickerState extends Equatable {
  final PeriodDayPickerStatus status;
  final Set<DateTime> selectedDays;
  final Set<DateTime> oldDays;
  final List<DateTime> months;
  //For tracking scrolling: a date for the first month in List<DateTime> months before List<DateTime> months is updated.

  const PeriodDayPickerState({
    this.status = PeriodDayPickerStatus.initial,
    this.selectedDays = const {},
    this.oldDays = const {},
    this.months = const [],
  });

  PeriodDayPickerState copyWith({
    PeriodDayPickerStatus? status,
    Set<DateTime>? selectedDays,
    Set<DateTime>? oldDays,
    List<DateTime>? months,
  }) {
    return PeriodDayPickerState(
      status: status ?? this.status,
      selectedDays: selectedDays ?? this.selectedDays,
      oldDays: oldDays ?? this.oldDays,
      months: months ?? this.months,
    );
  }

  @override
  List<Object?> get props => [status, selectedDays, oldDays, months];
}
