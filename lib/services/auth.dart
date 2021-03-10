import 'package:firebase_auth/firebase_auth.dart';

import 'auth_base.dart';


class Auth implements AuthBase{
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  User get currentUser => _firebaseAuth.currentUser;

  @override
  Future<User> signInAnonymously() async{
    final userCredential = await _firebaseAuth.signInAnonymously();
    return userCredential.user;
  }

  @override
  Future<void> signOut() async{
    await _firebaseAuth.signOut();
  }
}
