abstract class AuthService {
  void signUp(
      {required String email, required String password, required String name});

  void signIn({required String email, required String password});

  void signOut();

  void resetPassword({required String email});

  void getUserProfile();

  void updateProfile({required String name, required String email});
}
