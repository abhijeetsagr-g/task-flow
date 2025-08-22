import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String text, Color bgColor) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      backgroundColor: bgColor,
      elevation: 10,
      duration: Duration(milliseconds: 800),
    ),
  );
}
