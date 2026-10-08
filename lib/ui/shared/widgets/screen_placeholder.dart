import 'package:flutter/material.dart';

class ScreenPlaceholder extends StatelessWidget {
  const ScreenPlaceholder({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('$title screen')),
    );
  }
}
