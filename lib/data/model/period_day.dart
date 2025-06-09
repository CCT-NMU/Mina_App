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
      'Date': date.toIso8601String(),
      'FlowWeight': '${flowWeight.index}',
      'IsPeriodStartDay': isPeriodStartDay ? '1' : '0',
      'IsPeriodEndDay': isPeriodEndDay ? '1' : '0',
    };
  }

  static PeriodDay fromMap(Map<String, dynamic> map) {
    bool intToBool(int value) => value == 1;
    return PeriodDay(
        date: DateTime.parse(map['Date']),
        flowWeight: map['FlowWeight'] == null
            ? FlowWeight.values[0]
            : FlowWeight.values[map[
                'FlowWeight']], //convert database value [0,1,2,3] to enum FlowWeight
        isPeriodStartDay: map['IsPeriodStartDay'] == null
            ? false
            : intToBool(map['IsPeriodStartDay']),
        isPeriodEndDay: map['IsPeriodEndDay'] == null
            ? false
            : intToBool(map['IsPeriodEndDay']),
        note: map['Note'],
        symptomList: SymptomList.fromString(map['symptomList']),
        moodList: MoodList.fromString(map['moodlist']));
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
