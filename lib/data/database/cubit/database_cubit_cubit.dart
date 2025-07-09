import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'database_cubit_state.dart';

class DatabaseCubitCubit extends Cubit<DatabaseCubitState> {
  DatabaseCubitCubit() : super(DatabaseCubitInitial());
}
