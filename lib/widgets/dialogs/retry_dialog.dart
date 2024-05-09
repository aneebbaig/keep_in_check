import 'package:flutter/material.dart';

class RetryDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onRetry;

  const RetryDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: onRetry,
          child: const Text('Retry'),
        ),
      ],
    );
  }
}
