import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final String title;

  const ForgotPasswordScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('$title - Em construção!')),
    );
  }
}