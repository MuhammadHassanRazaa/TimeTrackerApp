import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app/home_page.dart';
import 'package:flutter_app/app/sign_in/sign_in_page.dart';
import 'package:flutter_app/services/auth_base.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key key, @required this.auth}) : super(key: key);

  final AuthBase auth;

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  User _user;

  @override
  void initState() {
    super.initState();
    _updateUser(widget.auth.currentUser);
  }

  void _updateUser(User user) {
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return SignInPage(
        onSignIn: _updateUser,
        auth: widget.auth,
      );
    }
    return Homepage(
      onSignOut: () => _updateUser(null),
      auth: widget.auth,
    );
  }
}
