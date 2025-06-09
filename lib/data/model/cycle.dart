import 'package:equatable/equatable.dart';
import 'package:mina_app/common/utils.dart';

class Cycle extends Equatable {
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? periodEndDate;

  const Cycle({
    required this.startDate,
    this.endDate,
    required this.periodEndDate,
  });

  @override
  List<Object?> get props => [startDate, endDate, periodEndDate];

  Map<String, dynamic> toMap() {
    return {
      'startDate': startDate!.toIso8601String(),
      'endDate': endDate != null ? endDate!.toIso8601String() : "",
      'periodEndDate': periodEndDate!.toIso8601String(),
    };
  }

  factory Cycle.fromMap(Map<String, dynamic> map) {
    return Cycle(
      startDate: DateTime.parse(map['startDate']),
      endDate: map['endDate'] != "" ? DateTime.parse(map['endDate']) : null,
      periodEndDate: DateTime.parse(map['periodEndDate']),
    );
  }

  bool isEqual(Cycle newCycle) {
    return this.endDate!.isAtSameMomentAs(newCycle.endDate!) &&
        this.startDate!.isAtSameMomentAs(newCycle.startDate!) &&
        this.periodEndDate!.isAtSameMomentAs(newCycle.periodEndDate!);
  }

//Used only for global cycle
  isInCycle(DateTime date) {
    date = Utils().normalizedDate(date);
    return date.isAfter(startDate!) || date.isAtSameMomentAs(startDate!);
  }
}
