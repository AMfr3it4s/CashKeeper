import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class SnackbarHelper {
  static void showAwesomeSnackbar(
    BuildContext context, {
    required String title,
    required String message,
    required ContentType contentType,
    int durationInSeconds = 3, required int duration,
  }) {
    // Cria o SnackBar com o AwesomeSnackbarContent
    final snackBar = SnackBar(
      duration: Duration(seconds: durationInSeconds),
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: contentType,
      ),
    );

    // Exibe o SnackBar
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
