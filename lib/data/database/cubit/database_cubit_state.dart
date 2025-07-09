part of 'database_cubit_cubit.dart';

sealed class DatabaseCubitState extends Equatable {
  const DatabaseCubitState();

  @override
  List<Object> get props => [];
}

final class DatabaseCubitInitial extends DatabaseCubitState {}
