import 'package:drift/drift.dart';
import 'package:mina_app/data/database/drift_database.dart';
part 'symptom_doa.g.dart';

@DriftAccessor(tables: [Symptoms])
class SymptomsDao extends DatabaseAccessor<AppDatabase>
    with _$SymptomsDaoMixin {
  SymptomsDao(AppDatabase db) : super(db);

  Future<int> insertSymptom(SymptomsCompanion symptom) =>
      into(symptoms).insert(symptom);
  Future<List<Symptom>> getAllSymptoms() => select(symptoms).get();
}
