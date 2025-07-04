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
      'Date': dateString,
      'IsPeriodDay': isPeriodDay,
      'Note': note,
      'symptomList': symptomList?.toString(),
      'moodList': moodList?.toString(),
    };
  }

  factory Day.fromMap(Map<String, dynamic> map) {
    return Day(
      date: DateTime.parse(map['date']),
      isPeriodDay: map['isPeriodDay'] ?? false,
      note: map['note'] ?? '',
      symptomList: SymptomList.fromString(map['symptomList'] ?? ''),
      moodList: MoodList.fromString(map['moodList'] ?? ''),
    );
  }
}
