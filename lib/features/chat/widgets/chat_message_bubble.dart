import 'package:flutter/material.dart';
import '../../../common/constants/app_colors.dart';
class ChatMessageBubble extends StatelessWidget {
  final bool isSender;
  final String text;

  const ChatMessageBubble({required this.isSender, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isSender
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: isSender ? Colors.pink.shade100 : AppColors.lightGrey,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20),
              topRight: const Radius.circular(20),
              bottomLeft: isSender ? const Radius.circular(20) : Radius.zero,
              bottomRight: isSender ? Radius.zero : const Radius.circular(20),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: Text(
                  text,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              if (isSender) ...[
                const SizedBox(width: 8),
                const Icon(Icons.check, color: AppColors.grey, size: 16),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
