import 'dart:async';
//import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;
import 'package:supabase_flutter/supabase_flutter.dart' as supabase
    show AuthState;
import 'package:mina_app/services/auth_service/platform/supabase_auth_service.dart';

// Events
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthStarted extends AuthEvent {}

class AuthSignInRequested extends AuthEvent {
  final String email;
  final String password;

  const AuthSignInRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class AuthSignUpRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const AuthSignUpRequested({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [name, email, password];
}

class AuthSignOutRequested extends AuthEvent {}

class AuthPasswordResetRequested extends AuthEvent {
  final String email;

  const AuthPasswordResetRequested({required this.email});

  @override
  List<Object?> get props => [email];
}

class AuthUserChanged extends AuthEvent {
  final User? user;

  const AuthUserChanged(this.user);

  @override
  List<Object?> get props => [user];
}

// States
abstract class AuthState extends Equatable {
  User? user;

  AuthState({this.user});
  @override
  List<Object?> get props => [user];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User user;
  final Map<String, dynamic>? profile;

  AuthAuthenticated({
    required this.user,
    this.profile,
  }) : super(user: user);

  @override
  List<Object?> get props => [user, profile];
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthPasswordResetSent extends AuthState {
  final String email;

  AuthPasswordResetSent(this.email);

  @override
  List<Object?> get props => [email];
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SupabaseAuthService _supabaseAuthService;
  late StreamSubscription<supabase.AuthState> _authStateSubscription;
  // Connectivity connectivity = Connectivity();

  AuthBloc({SupabaseAuthService? authService})
      : _supabaseAuthService = authService ?? SupabaseAuthService(),
        super(AuthInitial()) {
    on<AuthStarted>(_onAuthStarted);
    on<AuthSignInRequested>(_onSignInRequested);
    on<AuthSignUpRequested>(_onSignUpRequested);
    on<AuthSignOutRequested>(_onSignOutRequested);
    on<AuthPasswordResetRequested>(_onPasswordResetRequested);
    on<AuthUserChanged>(_onUserChanged);

    // Listen to auth state changes
    _authStateSubscription = _supabaseAuthService.authStateChanges.listen(
      (authState) {
        add(AuthUserChanged(authState.session?.user));
      },
    );
  }

  Future<void> _onAuthStarted(
    AuthStarted event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final user = _supabaseAuthService.currentUser;
    if (user != null) {
      try {
        final profile = await _supabaseAuthService.getUserProfile();
        emit(AuthAuthenticated(user: user, profile: profile));
      } catch (e) {
        emit(AuthAuthenticated(user: user));
      }
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onSignInRequested(
    AuthSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    //final connection = await connectivity.checkConnectivity();

    emit(AuthLoading());

    try {
      //  if (connection != ConnectivityResult.none) {
      final response = await _supabaseAuthService.signIn(
        email: event.email,
        password: event.password,
      );

      if (response.user != null) {
        final profile = await _supabaseAuthService.getUserProfile();
        emit(AuthAuthenticated(
          user: response.user!,
          profile: profile,
        ));
      } else {
        emit(AuthError('Sign in failed'));
      }
      /*   } else {
        //Offline Sign in
        //Check local database if user exists
      } */
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignUpRequested(
    AuthSignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final response = await _supabaseAuthService.signUp(
        name: event.name,
        email: event.email,
        password: event.password,
      );

      if (response.user != null) {
        final profile = await _supabaseAuthService.getUserProfile();
        emit(AuthAuthenticated(
          user: response.user!,
          profile: profile,
        ));
      } else {
        emit(AuthError('Sign up failed'));
      }
    } catch (e, stack) {
      print("Sign up error: $e");
      print(stack);
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignOutRequested(
    AuthSignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      await _supabaseAuthService.signOut();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onPasswordResetRequested(
    AuthPasswordResetRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      await _supabaseAuthService.resetPassword(email: event.email);
      emit(AuthPasswordResetSent(event.email));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onUserChanged(
    AuthUserChanged event,
    Emitter<AuthState> emit,
  ) async {
    if (event.user != null) {
      try {
        final profile = await _supabaseAuthService.getUserProfile();
        emit(AuthAuthenticated(
          user: event.user!,
          profile: profile,
        ));
      } catch (e) {
        emit(AuthAuthenticated(user: event.user!));
      }
    } else {
      emit(AuthUnauthenticated());
    }
  }

  @override
  Future<void> close() {
    _authStateSubscription.cancel();
    return super.close();
  }
}
