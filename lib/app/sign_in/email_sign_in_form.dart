import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app/sign_in/form_submit_button.dart';
import 'package:flutter_app/common_widgets/custom_raised_button.dart';

class EmailSignInForm extends StatelessWidget {
  void _submit(){

  }
  List<Widget> _buildChildren() {
    return [
      TextField(
        decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'email@domain.com',
        ),
      ),
      SizedBox(height: 8.0),
      TextField(
        decoration: InputDecoration(
          labelText: 'Password',
        ),
        obscureText: true,
        obscuringCharacter: '*',
      ),
      SizedBox(height: 8.0),
      FormSubmitButton(
        onPressed: _submit,
        text: 'Sign In',
      ),
      SizedBox(height: 8.0),
      TextButton(
        child: Text('Not Register Yet?'),
        onPressed: () {},
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(),
      ),
    );
  }
}
