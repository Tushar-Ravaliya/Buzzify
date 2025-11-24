import 'package:buzzify/common/theme/app_theme.dart';
import 'package:flutter/material.dart';
class MessageInputField extends StatelessWidget {
  final VoidCallback onScheduleTap;
  const MessageInputField({required this.onScheduleTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Theme.of(context).colorScheme.surface,
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.access_time, color: AppTheme.primaryColor),
            onPressed: onScheduleTap,
            iconSize: 30,
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Type a message...',
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: AppTheme.primaryColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: AppTheme.primaryColor),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: Icon(Icons.send, color: AppTheme.primaryColor),
            onPressed: () {},
            iconSize: 30,
          ),
        ],
      ),
    );
  }
}
