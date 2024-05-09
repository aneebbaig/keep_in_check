import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityDialog extends StatelessWidget {
  final ConnectivityResult connectivityResult;

  const ConnectivityDialog({super.key, required this.connectivityResult});

  @override
  Widget build(BuildContext context) {
    return const PopScope(
      canPop: false,
      child: AlertDialog(
        title: Text('No Internet Connection'),
        content: Text(
          'You are currently offline. Please reconnect to use the app\'s full functionality.',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
