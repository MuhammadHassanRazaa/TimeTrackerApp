import 'package:flutter_app/app/sign_in/validator.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInModel with EmailAndPasswordValidators {
  EmailSignInModel({
    this.email = '',
    this.password = '',
    this.formType = EmailSignInFormType.signIn,
    this.isLoading = false,
    this.submitted = false,
  });

  final String email;
  final String password;
  final EmailSignInFormType formType;
  final bool isLoading;
  final bool submitted;

  String get primaryButtonText {
    return formType == EmailSignInFormType.signIn ? 'Sign in' : 'Register';
  }

  String get passwordErrorText {
    bool showPasswordError = submitted && !passwordValidator.isValid(password);
    return showPasswordError ? invalidPasswordErrortext : null;
  }

  String get emailErrorText {
    bool showEmailError = submitted && !emailValidator.isValid(email);
    return showEmailError ? invalidEmailErrortext : null;
  }

  String get secondaryButtonText {
    return formType == EmailSignInFormType.signIn
        ? 'Not Registered Yet?'
        : 'Already Have an Account?';
  }

  bool get canSubmit {
    return emailValidator.isValid(email) &&
        passwordValidator.isValid(password) &&
        !isLoading;
  }

  EmailSignInModel copyWith({
    String email,
    String password,
    EmailSignInFormType formType,
    bool isLoading,
    bool submitted,
  }) {
    return EmailSignInModel(
      email: email ?? this.email,
      password: password ?? this.password,
      formType: formType ?? this.formType,
      isLoading: isLoading ?? this.isLoading,
      submitted: submitted ?? this.submitted,
    );
  }
}
