import 'package:flutter/material.dart';
import '../../../common/constants/app_colors.dart';

// Enum to manage the different states of the friend request button
enum FriendStatus { none, requestSent }

class FindFriendListItemWidget extends StatelessWidget {
  final String name;
  final String email;
  final String avatarInitial;
  final FriendStatus status;

  const FindFriendListItemWidget({
    super.key,
    required this.name,
    required this.email,
    required this.avatarInitial,
    this.status = FriendStatus.none,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: AppColors.grey.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          CircleAvatar(
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
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(email, style: const TextStyle(color: AppColors.grey)),
              ],
            ),
          ),
          // Conditionally build the button based on the status
          _buildActionButton(),
        ],
      ),
    );
  }

  // Helper method to build the correct button based on the status
  Widget _buildActionButton() {
    switch (status) {
      case FriendStatus.requestSent:
        return Column(
          children: [
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.access_time,
                color: Colors.orange,
                size: 16,
              ),
              label: const Text(
                'Request Sent',
                style: TextStyle(color: Colors.orange),
              ),
              style: TextButton.styleFrom(
                side: const BorderSide(color: Colors.orange),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 4),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.cancel_outlined,
                color: Colors.red,
                size: 16,
              ),
              label: const Text('Cancel', style: TextStyle(color: Colors.red)),
              style: TextButton.styleFrom(
                side: const BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        );
      // case FriendStatus.none:
      default:
        return ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(
            Icons.person_add_alt_1,
            color: AppColors.white,
            size: 16,
          ),
          label: const Text(
            'Add Friend',
            style: TextStyle(color: AppColors.white),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
    }
  }
}
