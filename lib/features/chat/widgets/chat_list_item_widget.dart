import 'package:flutter/material.dart';
import '../../../common/constants/app_colors.dart';

class ChatListItemWidget extends StatelessWidget {
  final String name;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final String avatarInitial;
  final VoidCallback? onTap;

  const ChatListItemWidget({
    super.key,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
    required this.avatarInitial,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Wrap the Container with InkWell
    return InkWell(
      onTap: onTap, // Use the onTap callback here
      borderRadius: BorderRadius.circular(12.0), // For a nice ripple effect
      child: Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: AppColors.grey.withOpacity(0.5)),
        ),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.purple.shade100,
            child: Text(
              avatarInitial,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
          ),
          title: Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            lastMessage,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (unreadCount > 0)
                CircleAvatar(
                  radius: 12,
                  backgroundColor: AppColors.primary,
                  child: Text(
                    unreadCount.toString(),
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 12,
                    ),
                  ),
                )
              else
                const SizedBox(height: 24),
              const SizedBox(height: 4),
              Text(
                time,
                style: const TextStyle(color: AppColors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
