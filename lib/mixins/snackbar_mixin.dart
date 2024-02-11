import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

mixin SnackbarMixin {
  void showErrorSnackbar(BuildContext context,
      {required String title, required String message}) {
    Flushbar(
      title: title,
      message: message,
      duration: Duration(seconds: 3),
      backgroundColor: Colors.red,
      margin: const EdgeInsets.all(10),
      borderRadius: BorderRadius.circular(10),
      isDismissible: true,
    ).show(context);
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text(message),
    //     backgroundColor: Colors.red,
    //     duration: Duration(seconds: 3),
    //   ),
    // );
  }

  void showSuccessSnackbar(BuildContext context,
      {String? title, required String message, Color? color}) {
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text(message),
    //     backgroundColor: Colors.green,
    //     duration: const Duration(seconds: 3),

    //   ),
    // );
    Flushbar(
      messageText: Center(
        child: Text(message),
      ),
      title: title,
      barBlur: 0.5,
      // title: title,
      // message: message,
      padding: const EdgeInsets.all(5),
      duration: const Duration(seconds: 2),
      backgroundColor: color!,
      margin: const EdgeInsets.only(left: 130, right: 130, top: 50, bottom: 50),
      borderRadius: BorderRadius.circular(20),
      isDismissible: true,
    ).show(context);
  }
}
