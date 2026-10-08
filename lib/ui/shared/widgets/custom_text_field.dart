import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({this.label, this.hint, super.key});

  final String? label;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(labelText: label, hintText: hint),
    );
  }
}
