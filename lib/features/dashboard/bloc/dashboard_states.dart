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

class DashboardLoadSuccess extends DashboardState {
  final DateTime? nextPeriodDate;
  DashboardLoadSuccess({
    this.nextPeriodDate,
    required int averageCycleLength,
    required int averagePeriodLength,
    required double cycleRegularity,
    required List<Cycle> recentCycles,
  });

  @override
  List<Object?> get props => [nextPeriodDate];
}

class DashboardLoadFailure extends DashboardState {
  final String error;
  DashboardLoadFailure(this.error);

  @override
  List<Object?> get props => [error];
}
