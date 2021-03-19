import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBase {
  User get currentUser;
  Stream<User> authStateChanges();
  Future<User> signInAnonymously();
  Future<User> signInWithGoogle();
  Future<User> signInWithFacebook();
  Future<User> signInWithEmail(String email, String password);
  Future<User> createUserWithEmailAndPassword(String email, String password);
  Future<void> signOut();
}
