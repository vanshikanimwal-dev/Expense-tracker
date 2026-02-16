import '../entities/app_user.dart';

abstract class AuthRepository {
  // Streams allow us to listen to auth changes in real-time
  Stream<AppUser?> get onAuthStateChanged;

  Future<AppUser?> signInWithEmail(String email, String password);
  Future<AppUser?> signUpWithEmail(String email, String password);
  Future<void> signOut();
}