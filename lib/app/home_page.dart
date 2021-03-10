import 'package:flutter/material.dart';
import 'package:flutter_app/services/auth_base.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key key, @required this.onSignOut, @required this.auth})
      : super(key: key);

  final AuthBase auth;
  final VoidCallback onSignOut;

  Future<void> _signOut() async {
    try {
      await auth.signOut();
      onSignOut();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Logout',
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
            onPressed: _signOut,
          ),
        ],
      ),
    );
  }
}
