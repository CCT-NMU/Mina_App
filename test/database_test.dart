import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:mina_app/data/database/drift_database.dart';
import 'package:mina_app/data/database/users_dao.dart';
import 'package:drift/native.dart';
import 'package:mina_app/data/model/user.dart';

void main() {
  late AppDatabase db;
  late AppUsersDao usersDao;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    usersDao = db.appUsersDao;
  });

  tearDown(() async {
    await db.close();
  });

  test('insert, read, update, and delete AppUser', () async {
    final user = User(
      id: '7ff13560-c21c-49c5-849b-94bbf4e9fa4d',
      name: 'Alice',
      surname: 'Smith',
      email: 'alice@example.com',
      birthday: DateTime(2000, 1, 1),
      avgCycleLength: 28,
      avgPeriodLength: 5,
      lastestCycleStart: DateTime(2025, 7, 1),
    );

    // Insert
    await usersDao.insertUser(user);
    var fetched =
        await usersDao.getUserById('7ff13560-c21c-49c5-849b-94bbf4e9fa4d');
    expect(fetched, isNotNull);
    expect(fetched!.name, 'Alice');

    // Update
    final updatedUser = user.copyWith(name: 'Alicia');
    await usersDao.updateUser(updatedUser);
    fetched =
        await usersDao.getUserById('7ff13560-c21c-49c5-849b-94bbf4e9fa4d');
    expect(fetched!.name, 'Alicia');

    // Read all
    final allUsers = await usersDao.getAllUsers();
    print(allUsers);
    expect(allUsers.length, 1);

    // Delete
    await usersDao.deleteUserById('7ff13560-c21c-49c5-849b-94bbf4e9fa4d');
    fetched =
        await usersDao.getUserById('7ff13560-c21c-49c5-849b-94bbf4e9fa4d');
    expect(fetched, isNull);
  });
}
