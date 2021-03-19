import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app/sign_in/form_submit_button.dart';
import 'package:flutter_app/services/auth_base.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInForm extends StatefulWidget {
  EmailSignInForm({@required this.auth});
  final AuthBase auth;
  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  String get _email => _emailController.text;
  String get _password => _passwordController.text;
  EmailSignInFormType _formType = EmailSignInFormType.signIn;

  void _submit() async {
    try {
      if (_formType == EmailSignInFormType.signIn) {
        await widget.auth.signInWithEmail(_email, _password);
      } else {
        await widget.auth.createUserWithEmailAndPassword(_email, _password);
      }
      Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
    }
  }

  void _emailEditingComplete(){
    FocusScope.of(context).requestFocus(_passwordFocusNode);
  }

  void _toggleFormType() {
    setState(() {
      _formType = _formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren() {
    final primaryText =
        _formType == EmailSignInFormType.signIn ? 'Sign in' : 'Register';
    final secondaryText = _formType == EmailSignInFormType.signIn
        ? 'Not Registered Yet?'
        : 'Already Have an Account?';
    return [
      _buildEmailTextField(),
      SizedBox(height: 8.0),
      _buildPasswordTextField(),
      SizedBox(height: 8.0),
      FormSubmitButton(
        onPressed: _submit,
        text: primaryText,
      ),
      SizedBox(height: 8.0),
      TextButton(
        child: Text(secondaryText),
        onPressed: _toggleFormType,
      ),
    ];
  }

  TextField _buildPasswordTextField() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Password',
      ),
      obscureText: true,
      obscuringCharacter: '*',
      textInputAction: TextInputAction.done,
      controller:  ,
      focusNode: _passwordFocusNode,
      onEditingComplete: _submit,
    );
  }

  TextField _buildEmailTextField() {
    return TextField(
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'email@domain.com',
      ),
      controller: _emailController,
      //autocorrect:false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete: _emailEditingComplete,
    );
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
