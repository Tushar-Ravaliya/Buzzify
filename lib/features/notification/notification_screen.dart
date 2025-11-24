import 'package:buzzify/common/theme/app_theme.dart';
import 'package:buzzify/features/friends/friend_requests_screen.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // leading: const Icon(Icons.arrow_back, color: AppTheme.textPrimaryColor),
        title: const Text(
          'Notification',
          style: TextStyle(color: AppTheme.textPrimaryColor),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Mark all read',
              style: TextStyle(color: AppTheme.primaryColor, fontSize: 16),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FriendRequestsScreen(),
                ),
              );
            },
            child: const _NotificationItem(
              title: 'New Friend Request',
              subtitle: 'you have received new friend request',
              time: 'just now',
            ),
          ),
        ],
      ),
    );
  }
}

// A reusable widget for a single notification item
class _NotificationItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;

  const _NotificationItem({
    required this.title,
    required this.subtitle,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: AppTheme.borderColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          CircleAvatar(
            radius: 24,
            backgroundColor: AppTheme.accentColor.withOpacity(0.2),
            child: const Icon(Icons.person_outline, color: Colors.pink),
          ),
          const SizedBox(width: 12),
          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: AppTheme.textSecondaryColor)),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(color: AppTheme.textSecondaryColor, fontSize: 12),
                ),
              ],
            ),
          ),
          // Dismiss button
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.close, color: AppTheme.textSecondaryColor),
          ),
        ],
      ),
    );
  }
}
