import 'package:flutter/material.dart';
import '../../common/constants/app_colors.dart';

// Enum to manage which tab is selected
enum RequestTab { received, sent }

class FriendRequestsScreen extends StatefulWidget {
  const FriendRequestsScreen({super.key});

  @override
  State<FriendRequestsScreen> createState() => _FriendRequestsScreenState();
}

class _FriendRequestsScreenState extends State<FriendRequestsScreen> {
  // State variable to track the selected tab
  RequestTab _selectedTab = RequestTab.received;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // leading: const Icon(Icons.arrow_back, color: AppColors.black),
        title: const Text(
          'Friend Requests',
          style: TextStyle(color: AppColors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Tab Selector
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              children: [
                _buildTabButton(
                  context,
                  title: 'Received (1)',
                  icon: Icons.chat_bubble_outline,
                  isSelected: _selectedTab == RequestTab.received,
                  onTap: () =>
                      setState(() => _selectedTab = RequestTab.received),
                ),
                const SizedBox(width: 8),
                _buildTabButton(
                  context,
                  title: 'Sent (0)',
                  icon: Icons.send_outlined,
                  isSelected: _selectedTab == RequestTab.sent,
                  onTap: () => setState(() => _selectedTab = RequestTab.sent),
                ),
              ],
            ),
          ),

          // Conditional content based on selected tab
          Expanded(
            child: _selectedTab == RequestTab.received
                ? _buildReceivedList()
                : _buildSentEmptyState(),
          ),
        ],
      ),
    );
  }

  // Helper method to build a tab button
  Widget _buildTabButton(
    BuildContext context, {
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: isSelected
          ? ElevatedButton.icon(
              onPressed: onTap,
              icon: Icon(icon, color: AppColors.white),
              label: Text(
                title,
                style: const TextStyle(color: AppColors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            )
          : TextButton.icon(
              onPressed: onTap,
              icon: Icon(icon, color: AppColors.grey),
              label: Text(title, style: const TextStyle(color: AppColors.grey)),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
    );
  }

  // Widget for the "Received" tab's content
  Widget _buildReceivedList() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: const [_FriendRequestItem()],
    );
  }

  // Widget for the "Sent" tab's empty state
  Widget _buildSentEmptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary.withValues(alpha: 0.1),
          ),
          child: const Icon(
            Icons.send_outlined,
            color: AppColors.primary,
            size: 60,
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'No Send Requests',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Friend requests you send will appear here',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.grey, fontSize: 16),
        ),
      ],
    );
  }
}

// Reusable widget for a single friend request item
class _FriendRequestItem extends StatelessWidget {
  const _FriendRequestItem();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundColor: AppColors.primary,
                child: Text(
                  'D',
                  style: TextStyle(color: AppColors.white, fontSize: 20),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dear Programmer',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'dearprogrammerofficial@gmail.com',
                      style: const TextStyle(color: AppColors.grey),
                    ),
                  ],
                ),
              ),
              const Text(
                'Just now',
                style: TextStyle(color: AppColors.grey, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.close),
                  label: const Text('Decline'),
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.check, color: AppColors.white),
                  label: const Text(
                    'Accept',
                    style: TextStyle(color: AppColors.white),
                  ),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
