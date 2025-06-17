import 'package:equatable/equatable.dart';
import 'package:mina_app/data/model/day.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

class LoadDashboard extends DashboardEvent {
  final DateTime focusedDay;
  const LoadDashboard(this.focusedDay);
}

class RefreshDashboard extends DashboardEvent {
  final DateTime focusedDay;
  const RefreshDashboard(this.focusedDay);
}

class CalendarChanged extends DashboardEvent {
  //event to capture calendar's change to the new month
  //[day] is the
  final DateTime day;
  CalendarChanged(this.day);
  @override
  List<Object?> get props => [day];
}

class UpdateDayEntry extends DashboardEvent {
  final DateTime day;
  const UpdateDayEntry(this.day);
}

class DeleteDay extends DashboardEvent {
  final DateTime day;
  const DeleteDay(this.day);
}

class DeletePeriodDay extends DashboardEvent {
  final DateTime day;
  const DeletePeriodDay(this.day);
}
