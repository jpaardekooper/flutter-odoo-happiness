import 'package:flutter/material.dart';

SnackbarErrorMsg(BuildContext context, String errMsg, Color color) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 1),
      backgroundColor: color,
      content: Text(
        errMsg,
        // Provider.of<Auth>(context, listen: false).errorMessage,
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}
