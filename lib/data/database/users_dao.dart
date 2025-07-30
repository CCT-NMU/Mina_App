import 'package:drift/drift.dart';
import 'package:mina_app/data/database/drift_database.dart';
import 'package:mina_app/data/model/user.dart';

part 'users_dao.g.dart';

@DriftAccessor(tables: [AppUsers])
class AppUsersDao extends DatabaseAccessor<AppDatabase>
    with _$AppUsersDaoMixin {
  AppUsersDao(AppDatabase db) : super(db);

  Future<int> insertUser(User user) {
    final companion = AppUsersCompanion(
      id: Value(user.id!),
      name: Value(user.name!),
      surname: Value(user.surname),
      email: Value(user.email!),
      birthday: Value(user.birthday),
      avgCycleLength: Value(user.avgCycleLength),
      avgPeriodLength: Value(user.avgPeriodLength),
      lastestCycleStart: user.lastestCycleStart != null
          ? Value(user.lastestCycleStart)
          : const Value.absent(),
    );
    return into(appUsers).insertOnConflictUpdate(companion);
  }

  Future<User?> getUserById(String id) async {
    final result = await (select(appUsers)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    if (result == null) return null;

    return User(
      id: result.id,
      name: result.name,
      surname: result.surname,
      email: result.email,
      birthday: result.birthday,
    );
  }

  clearUserData(String userId) {
    (delete(appUsers)..where((tbl) => tbl.id.equals(userId))).go();
  }

  deleteUser(String id) {
    return (delete(appUsers)..where((tbl) => tbl.id.equals(id))).go();
  }

  updateUser(User user) {
    final companion = AppUsersCompanion(
      id: Value(user.id!),
      name: Value(user.name!),
      surname: Value(user.surname!),
      email: Value(user.email!),
      birthday: Value(user.birthday!),
      avgCycleLength: Value(user.avgCycleLength),
      avgPeriodLength: Value(user.avgPeriodLength),
      lastestCycleStart: user.lastestCycleStart != null
          ? Value(user.lastestCycleStart!)
          : const Value.absent(),
    );
    return (update(appUsers)..where((tbl) => tbl.id.equals(user.id!)))
        .write(companion);
  }

  getAllUsers() {
    return select(appUsers).get();
  }

  deleteUserById(String id) {
    return (delete(appUsers)..where((tbl) => tbl.id.equals(id))).go();
  }
}
