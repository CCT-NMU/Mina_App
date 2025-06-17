import 'package:equatable/equatable.dart';
import 'package:mina_app/data/model/cycle.dart';
import 'package:mina_app/data/model/day.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoadInProgress extends DashboardState {}

class DashboardFocusedDayChanged extends DashboardState {
  final DateTime day;
  DashboardFocusedDayChanged(this.day);
  @override
  List<Object?> get props => [day];
}

class DashboardLoadSuccess extends DashboardState {
  final List<Day> days;
  DashboardLoadSuccess(
      {DateTime? nextPeriodDate,
      required int averageCycleLength,
      required int averagePeriodLength,
      required double cycleRegularity,
      required List<Cycle> recentCycles,
      required this.days});

  @override
  List<Object?> get props => [days];
}

class DashboardLoadFailure extends DashboardState {
  final String error;
  DashboardLoadFailure(this.error);

  @override
  List<Object?> get props => [error];
}
