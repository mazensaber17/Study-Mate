import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({required this.message, required this.isFromUser, super.key});

  final String message;
  final bool isFromUser;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isFromUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Text(message),
    );
  }
}
