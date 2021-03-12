import 'package:flutter/material.dart';
import 'package:flutter_app/services/auth_base.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key key, @required this.auth}) : super(key: key);

  final AuthBase auth;

  Future<void> _signOut() async {
    try {
      await auth.signOut();
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
