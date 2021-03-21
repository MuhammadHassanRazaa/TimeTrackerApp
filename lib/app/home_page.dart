import 'package:flutter/material.dart';
import 'package:flutter_app/common_widgets/alert_dialog.dart';
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

  Future<void> _confirmSignOut(BuildContext context) async {
    if (await showAlertDialog(context,
            tittle: 'Logout',
            content: 'Are you Sure that you want to Logout?',
            defaultActionText: 'Yes',
            cancelActionText: 'No') ==
        true) {
      _signOut();
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
            onPressed: () => _confirmSignOut(context),
          ),
        ],
      ),
    );
  }
}
