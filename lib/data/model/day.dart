import 'package:mina_app/data/model/cycle.dart';
import 'package:mina_app/data/model/period_day.dart';
import 'package:mina_app/data/model/mood_list.dart';
import 'package:mina_app/data/model/symptom_list.dart';
import 'package:mina_app/data/model/user.dart';

class Day {
  DateTime date;

  bool isPeriodDay;
  String? note;
  SymptomList? symptomList;
  MoodList? moodList;

  Day(
      {required this.date,
      required this.isPeriodDay,
      this.note,
      this.symptomList,
      this.moodList});

  Map<String, dynamic> toMap() {
    String dateString = date.toIso8601String();

    return {
      'date': dateString,
      'is_period_day': isPeriodDay,
      'note': note,
      'symptom_list': symptomList?.toString(),
      'mood_list': moodList?.toString(),
    };
  }

  factory Day.fromMap(Map<String, dynamic> map) {
    print('Day fromMap: $map');
    return Day(
      date: DateTime.parse(map['date']),
      isPeriodDay: map['is_period_day'] ?? false,
      note: map['note'] ?? '',
      symptomList: SymptomList.fromString(map['symptom_list'] ?? ''),
      moodList: MoodList.fromString(map['mood_list'] ?? ''),
    );
  }
}
