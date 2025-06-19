import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'dart:async';
import 'package:mina_app/services/auth_service.dart';

class FakeAuthService extends AuthService {
  FakeAuthService() : super.fake();

  final supabase.User _fakeUser = supabase.User(
    id: 'fake-user-id',
    appMetadata: const {},
    userMetadata: const {'name': 'Test User'},
    aud: 'authenticated',
    createdAt: DateTime.now().toIso8601String(),
    email: 'test@example.com',
    phone: '',
    confirmedAt: DateTime.now().toIso8601String(),
    lastSignInAt: DateTime.now().toIso8601String(),
    role: 'authenticated',
    updatedAt: DateTime.now().toIso8601String(),
  );

  @override
  supabase.User? get currentUser => _fakeUser;
  @override
  String? get currentUserId => _fakeUser.id;
  @override
  bool get isLoggedIn => true;
  @override
  String? get currentUserEmail => _fakeUser.email;
  @override
  String? get currentUserName => _fakeUser.userMetadata?['name'];
  @override
  Future<Map<String, dynamic>?> getUserProfile() async {
    return {
      'id': _fakeUser.id,
      'email': _fakeUser.email,
      'name': _fakeUser.userMetadata?['name'] ?? '',
      'created_at': _fakeUser.createdAt,
    };
  }

  @override
  Stream<supabase.AuthState> get authStateChanges => Stream.value(
        supabase.AuthState(
          supabase.AuthChangeEvent.signedIn,
          supabase.Session(
            accessToken: 'fake-token',
            tokenType: 'bearer',
            user: _fakeUser,
            expiresIn: 3600,
            refreshToken: 'fake-refresh',
            providerToken: null,
            providerRefreshToken: null,
          ),
        ),
      );
}
