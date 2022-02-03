import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  static const String route = 'home';
  @override
  State<LoadingScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Loading screen')),
    );
  }
}
