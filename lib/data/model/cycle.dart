import 'package:equatable/equatable.dart';
import 'package:mina_app/common/utils.dart';

class Cycle extends Equatable {
  final String? userId;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? periodEndDate;

  const Cycle({
    required this.userId,
    required this.startDate,
    this.endDate,
    required this.periodEndDate,
  });

  @override
  List<Object?> get props => [userId, startDate, endDate, periodEndDate];

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'start_date': startDate!.toIso8601String(),
      'end_date': endDate != null ? endDate!.toIso8601String() : null,
      'period_end_date':
          periodEndDate != null ? periodEndDate!.toIso8601String() : null,
    };
  }

  factory Cycle.fromMap(Map<String, dynamic> map) {
    return Cycle(
      userId: map['user_id'],
      startDate: DateTime.parse(map['start_date']),
      endDate: map['end_date'] != null ? DateTime.parse(map['end_date']) : null,
      periodEndDate: map['period_end_date'] != null
          ? DateTime.parse(map['period_end_date'])
          : null,
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
