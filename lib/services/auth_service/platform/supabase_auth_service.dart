import 'package:mina_app/services/auth_service/platform/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthService implements AuthService {
  final _supabase = Supabase.instance.client;

  // Get current user
  User? get currentUser => _supabase.auth.currentUser;

  // Get current user ID
  String? get currentUserId => currentUser?.id;

  // Get current user ID (throws if not authenticated)
  String get requireUserId {
    final userId = currentUserId;
    if (userId == null) {
      throw Exception('No authenticated user found');
    }
    return userId;
  }

  // Check if user is logged in
  bool get isLoggedIn => currentUser != null;

  // Get current user email
  String? get currentUserEmail => currentUser?.email;

  // Get current user name from metadata
  String? get currentUserName => currentUser?.userMetadata?['name'];

  // Sign up with email, password, and name
  @override
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {'name': name}, // Store name in user metadata
      );

      if (response.user != null && response.session == null) {
        // Show a message to the user to check their email

        print('Sign up successful, but email confirmation required.');
      }
      if (response.user != null) {
        // Update user profile with name
        await _supabase.auth.updateUser(
          UserAttributes(
            data: {'name': name},
          ),
        );
      }

      return response;
    } catch (e) {
      print('Supabase sign up failed: $e');
      throw Exception('Sign up failed: ${e.toString()}');
    }
  }

  // Sign in with email and password
  @override
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response;
    } catch (e) {
      throw Exception('Sign in failed: ${e.toString()}');
    }
  }

  // Sign out
  @override
  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      throw Exception('Sign out failed: ${e.toString()}');
    }
  }

  // Reset password
  @override
  Future<void> resetPassword({required String email}) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
    } catch (e) {
      throw Exception('Password reset failed: ${e.toString()}');
    }
  }

  // Get user profile data
  @override
  Future<Map<String, dynamic>?> getUserProfile() async {
    try {
      final user = currentUser;
      if (user == null) return null;

      return {
        'id': user.id,
        'email': user.email,
        'name': user.userMetadata?['name'] ?? '',
        'created_at': user.createdAt,
      };
    } catch (e) {
      throw Exception('Failed to get user profile: ${e.toString()}');
    }
  }

  // Update user profile
  @override
  Future<void> updateProfile({
    String? name,
    String? email,
  }) async {
    try {
      final updates = <String, dynamic>{};

      if (name != null) {
        updates['name'] = name;
      }

      await _supabase.auth.updateUser(
        UserAttributes(
          email: email,
          data: updates.isNotEmpty ? updates : null,
        ),
      );
    } catch (e) {
      throw Exception('Profile update failed: ${e.toString()}');
    }
  }

  // Listen to auth state changes
  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;

  // Singleton instance for easy access
  static final SupabaseAuthService _instance = SupabaseAuthService._internal();
  factory SupabaseAuthService() {
    //ToDo to review if placing async method in factory is best practice?
    //How to make Auth session availiable to app?

    return _instance;
  }
  SupabaseAuthService._internal();

  // Add a named constructor for fake usage
  SupabaseAuthService.fake();
}
