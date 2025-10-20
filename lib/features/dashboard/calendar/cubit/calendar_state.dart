part of 'calendar_cubit.dart';

abstract class CalendarState extends Equatable {
  const CalendarState();

  @override
  List<Object?> get props => [];
}

class CalendarInitial extends CalendarState {}

class CalendarLoading extends CalendarState {}

class CalendarLoaded extends CalendarState {
  final Map<String, List<Day>> cachedmonths;
  final Map<String, Cycle> predictedMonths;

  const CalendarLoaded(
      {required this.cachedmonths, required this.predictedMonths});

  @override
  List<Object?> get props => [cachedmonths];
}

class CalendarDaySelected extends CalendarState {
  final DateTime selectedDay;

  const CalendarDaySelected({required this.selectedDay});

  @override
  List<Object?> get props => [selectedDay];
}

class CalendarError extends CalendarState {
  final String message;

  const CalendarError({required this.message});

  @override
  List<Object?> get props => [message];
}
