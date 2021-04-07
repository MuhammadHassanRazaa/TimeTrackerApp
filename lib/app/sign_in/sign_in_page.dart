import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app/sign_in/email_sign_in_page.dart';
import 'package:flutter_app/app/sign_in/sign_in_bloc.dart';
import 'package:flutter_app/app/sign_in/sign_in_button.dart';
import 'package:flutter_app/app/sign_in/social_sign_in_button.dart';
import 'package:flutter_app/common_widgets/exception_alert_dialog.dart';
import 'package:flutter_app/services/auth_base.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key key, @required this.bloc}) : super(key: key);
  final SignInBloc bloc;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_,isLoading,__) => Provider<SignInBloc>(
          create: (_) => SignInBloc(auth: auth, isLoading: isLoading),
          child: Consumer<SignInBloc>(
            builder: (_, bloc, __) => SignInPage(bloc: bloc),
          ),
        ),
      ),
    );
  }

  void _showSignInError(BuildContext context, Exception exception) {
    if (exception is FirebaseException &&
        exception.code == 'ERROR_ABORTED_BY_USER') return;
    showExceptionAlertDialog(
      context,
      tittle: 'Sign in Failed',
      exception: exception,
    );
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      await bloc.signInAnonymously();
    } on Exception catch (e) {
      _showSignInError(context, e);
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      await bloc.signInWithGoogle();
    } on Exception catch (e) {
      _showSignInError(context, e);
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      await bloc.signInWithFacebook();
    } on Exception catch (e) {
      _showSignInError(context, e);
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => EmailSignInPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<ValueNotifier<bool>>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 2.0,
      ),
      body: _buildContainer(context, isLoading.value),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContainer(BuildContext context, bool isLoading) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                child: _buildHeader(isLoading),
                height: 50.0,
              ),
              SizedBox(height: 48.0),
              SocialSignInButton(
                assetName: 'images/google-logo.png',
                text: 'Sign In with Google',
                color: Colors.white,
                textColor: Colors.black87,
                onPressed: isLoading ? null : () => _signInWithGoogle(context),
              ),
              SizedBox(height: 8.0),
              SocialSignInButton(
                assetName: 'images/facebook-logo.png',
                text: 'Sign In with Facebook',
                color: Color(0xFF334D92),
                textColor: Colors.white,
                onPressed:
                    isLoading ? null : () => _signInWithFacebook(context),
              ),
              SizedBox(height: 8.0),
              SignInButton(
                text: 'Sign In with Email',
                color: Colors.teal[700],
                textColor: Colors.white,
                onPressed: isLoading ? null : () => _signInWithEmail(context),
              ),
              SizedBox(height: 8.0),
              Text(
                'OR',
                style: TextStyle(fontSize: 14.0, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.0),
              SignInButton(
                text: 'Go Anonymous',
                color: Colors.lime[300],
                textColor: Colors.black,
                onPressed: () => _signInAnonymously(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isLoading) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Text(
        'Sign In',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.w500,
        ),
      );
    }
  }
}
