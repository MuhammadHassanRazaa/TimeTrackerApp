import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app/sign_in/form_submit_button.dart';
import 'package:flutter_app/app/sign_in/validator.dart';
import 'package:flutter_app/services/auth_base.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidators {
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
  bool _submitted = false;
  bool _isLoading = false;

  void _submit() async {
    setState(() {
      _submitted = true;
      _isLoading = true;
    });
    try {
      if (_formType == EmailSignInFormType.signIn) {
        await widget.auth.signInWithEmail(_email, _password);
      } else {
        await widget.auth.createUserWithEmailAndPassword(_email, _password);
      }
      Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _emailEditingComplete() {
    final newFocus = widget.emailValidator.isValid(_email.trim())
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _toggleFormType() {
    setState(() {
      _submitted = false;
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
    bool _submitEnabled = widget.emailValidator.isValid(_email.trim()) &&
        widget.passwordValidator.isValid(_password.trim()) &&
        !_isLoading;
    return [
      _buildEmailTextField(),
      SizedBox(height: 8.0),
      _buildPasswordTextField(),
      SizedBox(height: 8.0),
      FormSubmitButton(
        onPressed: _submitEnabled ? _submit : null,
        text: primaryText,
      ),
      SizedBox(height: 8.0),
      TextButton(
        child: Text(secondaryText),
        onPressed: !_isLoading ? _toggleFormType : null,
      ),
    ];
  }

  TextField _buildPasswordTextField() {
    bool showPasswordError =
        _submitted && !widget.passwordValidator.isValid(_password.trim());
    return TextField(
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: showPasswordError ? widget.invalidPasswordErrortext : null,
        enabled: !_isLoading,
      ),
      obscureText: true,
      obscuringCharacter: '*',
      textInputAction: TextInputAction.done,
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      onChanged: (password) => _updateState(),
      onEditingComplete: _submit,
    );
  }

  TextField _buildEmailTextField() {
    bool showEmailError =
        _submitted && !widget.emailValidator.isValid(_email.trim());
    return TextField(
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'email@domain.com',
        errorText: showEmailError ? widget.invalidEmailErrortext : null,
        enabled: !_isLoading,
      ),
      controller: _emailController,
      //autocorrect:false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onChanged: (email) => _updateState(),
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

  void _updateState() {
    setState(() {});
  }
}
