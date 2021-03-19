import 'package:flutter/material.dart';
import 'package:flutter_app/app/sign_in/email_sign_in_form.dart';
import 'package:flutter_app/services/auth_base.dart';

class EmailSignInPage extends StatelessWidget {
  EmailSignInPage({@required this.auth});
  final AuthBase auth;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
        elevation: 2.0,
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Card(
            child: EmailSignInForm(auth: auth),
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
