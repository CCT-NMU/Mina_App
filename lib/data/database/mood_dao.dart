import 'package:drift/drift.dart';
import 'package:mina_app/data/database/drift_database.dart';
part 'mood_dao.g.dart';

@DriftAccessor(tables: [Moods])
class MoodsDao extends DatabaseAccessor<AppDatabase> with _$MoodsDaoMixin {
  MoodsDao(AppDatabase db) : super(db);

  Future<int> insertMood(MoodsCompanion mood) => into(moods).insert(mood);
  Future<List<Mood>> getAllMoods() => select(moods).get();
}
