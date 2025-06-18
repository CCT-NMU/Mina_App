import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'package:mina_app/data/database/drift_database.dart';

AppDatabase constructDb() {
  return AppDatabase(DatabaseConnection.delayed(Future(() async {
    final result = await WasmDatabase.open(
      databaseName: 'mina_database',
      sqlite3Uri: Uri.parse('sqlite3.wasm'),
      driftWorkerUri: Uri.parse('drift_worker.dart.js'),
    );
    return result.resolvedExecutor;
  })));
}
