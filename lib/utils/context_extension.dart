import 'package:flutter/material.dart';

extension ContextExtension on BuildContext{

  void showSnackBar({
    required String message,
    bool erorr = false,
  })
  {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: erorr ? Colors.red.shade800 : Colors.blue.shade500,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}