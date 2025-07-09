import 'package:mina_app/data/database/connection/shared.dart';
import 'package:mina_app/data/database/drift_database.dart';
import 'package:mina_app/data/database/user_settings_dao.dart';
import 'package:mina_app/data/repositories/user_repository.dart';
import 'package:mina_app/services/auth_service/platform/auth_service.dart';

class LocalAuthService implements AuthService {
  @override
  void getUserProfile() {
    // TODO: implement getUserProfile
  }

  @override
  void resetPassword({required String email}) {
    // TODO: implement resetPassword
  }

  @override
  void signIn({required String email, required String password}) {
    // TODO: implement signIn
  }

  @override
  void signOut() {
    // TODO: implement signOut
  }

  @override
  void signUp(
      {required String email, required String password, required String name}) {
    // TODO: implement signUp
  }

  @override
  void updateProfile({required String name, required String email}) {
    // TODO: implement updateProfile
  }
}
