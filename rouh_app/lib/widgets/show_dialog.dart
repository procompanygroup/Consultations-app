import 'package:flutter/material.dart';
/*
void ShowMessageDialog(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          title,
          style: TextStyle(fontSize: 18),
        ),
        content: Text(
          message,
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
*/

Future ShowMessageDialog( BuildContext context, String title, String message) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            title,
            style: TextStyle(fontSize: 18),
          ),
          content: Text(
            message,
            style: const TextStyle(fontSize: 16),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('حسناً'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],

        );
      });
}