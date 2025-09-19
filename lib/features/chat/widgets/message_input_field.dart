import 'package:flutter/material.dart';
import '../../../common/constants/app_colors.dart';
class MessageInputField extends StatelessWidget {
  final VoidCallback onScheduleTap;
  const MessageInputField({required this.onScheduleTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: AppColors.white,
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.access_time, color: Colors.purple.shade300),
            onPressed: onScheduleTap,
            iconSize: 30,
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Type a message...',
                filled: true,
                fillColor: AppColors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.purple.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.purple.shade300),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: Icon(Icons.send, color: Colors.purple.shade300),
            onPressed: () {},
            iconSize: 30,
          ),
        ],
      ),
    );
  }
}
