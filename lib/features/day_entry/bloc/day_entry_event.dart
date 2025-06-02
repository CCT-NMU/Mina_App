//A class that contains the events for the Day entry bloc
import 'package:mina_app/data/model/day.dart';

sealed class DayEntryBlocEvent {
  const DayEntryBlocEvent() : super();
}

//Fetch a Day Entry for a specific date
class DayEntryFetch extends DayEntryBlocEvent {
  final DateTime date;
  const DayEntryFetch(this.date);
}

//Day Entry Fetched for a specific date
class DayEntryFetched extends DayEntryBlocEvent {
  const DayEntryFetched();
}

//Update a Day Entry for a specific date
class DayEntryUpdate extends DayEntryBlocEvent {
  final Day dayEntry;
  const DayEntryUpdate(this.dayEntry);
}

//Close Day Entry Page
class DayEntryClose extends DayEntryBlocEvent {
  const DayEntryClose();
}

//Delete Day Entry
class DayEntryDelete extends DayEntryBlocEvent {
  const DayEntryDelete();
}

class DayEntryReloadRequest extends DayEntryBlocEvent {
  final DateTime date;
  const DayEntryReloadRequest(this.date);
}

class FlowChanged extends DayEntryBlocEvent {
  final String? flow;
  const FlowChanged(this.flow);
}

class SymptomsChanged extends DayEntryBlocEvent {
  final List<String> symptoms;
  const SymptomsChanged(this.symptoms);
}

class MoodsChanged extends DayEntryBlocEvent {
  final List<String> moods;
  const MoodsChanged(this.moods);
}

class PeriodDaySelectedChanged extends DayEntryBlocEvent {
  final bool isPeriodDaySelected;
  PeriodDaySelectedChanged(this.isPeriodDaySelected);
}

class NotesChanged extends DayEntryBlocEvent {
  final String notes;
  NotesChanged(this.notes);
}
