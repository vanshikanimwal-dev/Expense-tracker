import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/firebase_auth_repository.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';

// 1. Provide the Repository
// This allows us to access our Auth functions anywhere in the app.
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return FirebaseAuthRepository();
});

// 2. Provide the Auth State
// This listens to the Stream we created in the Repository.
// The UI will "watch" this to decide whether to show the Login or Home screen.
final authStateChangesProvider = StreamProvider<AppUser?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.onAuthStateChanged;
});