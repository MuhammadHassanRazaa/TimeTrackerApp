import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common_widgets/alert_dialog.dart';

Future<void> showExceptionAlertDialog(
  BuildContext context, {
  @required String tittle,
  @required Exception exception,
}) =>
    showAlertDialog(
      context,
      tittle: tittle,
      content: _message(exception),
      defaultActionText: 'OK',
    );

String _message(Exception exception) {
  return (exception is FirebaseException)
      ? exception.message
      : exception.toString();
}
