
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For Clipboard

class ErrorDialog extends StatelessWidget {

  const ErrorDialog({
    super.key,
    required this.errorCode,
    required this.errorMessage,
  });
  final String errorCode;
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Oops! Something went wrong.'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            errorMessage,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          const Text(
            'Error Code:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Text(
                errorCode,
              ),
              IconButton(
                icon: const Icon(Icons.copy, size: 20),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: errorCode));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Error code copied!')),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Please report this code to support if the issue persists.',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }

  static void show(BuildContext context, String code, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ErrorDialog(
          errorCode: code,
          errorMessage: message,
        );
      },
    );
  }
}