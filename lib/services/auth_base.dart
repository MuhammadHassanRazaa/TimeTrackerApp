import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBase {
  User get currentUser;
  Future<User> signInAnonymously();
  Future<void> signOut();
}