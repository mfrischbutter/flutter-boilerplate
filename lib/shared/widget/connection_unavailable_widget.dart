// Flutter imports:
import 'package:flutter/material.dart';

class ConnectionUnavailableScreen extends StatelessWidget {
  const ConnectionUnavailableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('No internet connection available.'),
      ),
    );
  }
}
