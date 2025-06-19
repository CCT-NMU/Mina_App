import 'package:drift/drift.dart';
import 'package:mina_app/data/database/drift_database.dart';
part 'mood_dao.g.dart';

@DriftAccessor(tables: [AppMoods])
class AppMoodsDao extends DatabaseAccessor<AppDatabase>
    with _$AppMoodsDaoMixin {
  AppMoodsDao(AppDatabase db) : super(db);

  Future<int> insertMood(AppMoodsCompanion mood) => into(appMoods).insert(mood);
  Future<List<AppMood>> getAllMoods() =>
      select(appMoods).get().then((rows) => rows.cast<AppMood>());
}
