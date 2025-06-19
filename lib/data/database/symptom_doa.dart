import 'package:drift/drift.dart';
import 'package:mina_app/data/database/drift_database.dart';
part 'symptom_doa.g.dart';

@DriftAccessor(tables: [AppSymptoms])
class AppSymptomsDao extends DatabaseAccessor<AppDatabase>
    with _$AppSymptomsDaoMixin {
  AppSymptomsDao(AppDatabase db) : super(db);

  Future<int> insertSymptom(AppSymptomsCompanion symptom) =>
      into(appSymptoms).insert(symptom);
  Future<List<AppSymptom>> getAllSymptoms() =>
      select(appSymptoms).get().then((rows) => rows.cast<AppSymptom>());
}
