import 'package:mina_app/data/database/databaseHelper.dart';

import 'day.dart';
import 'symptom_list.dart';
import 'mood_list.dart';

enum FlowWeight { none, light, medium, heavy }

class PeriodDay extends Day {
  FlowWeight flowWeight;
  bool isPeriodStartDay;
  bool isPeriodEndDay;

  PeriodDay({
    required DateTime date,
    required this.flowWeight,
    required this.isPeriodStartDay,
    required this.isPeriodEndDay,
    String? note,
    SymptomList? symptomList,
    MoodList? moodList,
  }) : super(
          date: date,
          isPeriodDay: true,
          note: note,
          symptomList: symptomList,
          moodList: moodList,
        );
  static List<FlowWeight> get flowWeightValues => FlowWeight.values;

  Map<String, dynamic> toPeriodDayMap() {
    return {
      'date': date.toIso8601String(),
      'flowWeight': '${flowWeight.index}',
      'isPeriodStartDay': isPeriodStartDay,
      'isPeriodEndDay': isPeriodEndDay,
    };
  }

  static PeriodDay fromMap(Map<String, dynamic> map) {
    return PeriodDay(
        date: DateTime.parse(map['date']),
        flowWeight: map['flowWeight'] == null
            ? FlowWeight.values[0]
            : FlowWeight.values[map['flowWeight']],
        isPeriodStartDay: map['isPeriodStartDay'] ?? false,
        isPeriodEndDay: map['isPeriodEndDay'] ?? false,
        note: map['note'] ?? '',
        symptomList: SymptomList.fromString(map['symptomList']),
        moodList: MoodList.fromString(map['moodList']));
  }

  PeriodDay copyWith({
    FlowWeight? flowWeight,
    bool? isPeriodStartDay,
    bool? isPeriodEndDay,
  }) {
    return PeriodDay(
      date: date,
      flowWeight: flowWeight ?? this.flowWeight,
      isPeriodStartDay: isPeriodStartDay ?? this.isPeriodStartDay,
      isPeriodEndDay: isPeriodEndDay ?? this.isPeriodEndDay,
      note: note,
      symptomList: symptomList,
      moodList: moodList,
    );
  }
}
