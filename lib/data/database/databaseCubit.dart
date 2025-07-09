import 'package:drift/drift.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mina_app/data/database/connection/shared.dart';
import 'package:mina_app/data/database/drift_database.dart';

class DatabaseCubit extends Cubit<AppDatabase> {
  /// Creates a [DatabaseCubit] that manages the [AppDatabase] using the default database constructor.
  DatabaseCubit() : super(constructDb());
}
