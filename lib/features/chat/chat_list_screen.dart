import 'package:buzzify/features/chat/chat_detail_screen.dart';
import 'package:buzzify/features/friends/friends_list_screen.dart';
import 'package:buzzify/features/notification/notification_screen.dart';
import 'package:flutter/material.dart';
import '../../common/constants/app_colors.dart';
import 'widgets/chat_list_item_widget.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Messages',
          style: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.notifications_none_outlined,
              color: AppColors.black,
              size: 30,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search conversations...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(color: AppColors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(color: AppColors.grey),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Filter Chips
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildFilterChip('All', isSelected: true),
                _buildFilterChip('Unread (0)'),
                _buildFilterChip('Recent (0)'),
                _buildFilterChip('Active (0)'),
              ],
            ),
            const SizedBox(height: 24),

            // Recent Chats Title
            const Text(
              'Recent Chats',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Chat List
            Expanded(
              child: ListView(
                children: [
                  ChatListItemWidget(
                    name: 'Alex',
                    lastMessage: 'hi',
                    time: 'Just now',
                    unreadCount: 1,
                    avatarInitial: 'A',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChatDetailScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigate to the Find Friends screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FriendsListScreen()),
          );
        },
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.chat, color: AppColors.white),
        label: const Text('New chat', style: TextStyle(color: AppColors.white)),
      ),
    );
  }

  // Helper widget for filter chips
  Widget _buildFilterChip(String label, {bool isSelected = false}) {
    return Chip(
      label: Text(
        label,
        style: TextStyle(color: isSelected ? AppColors.white : AppColors.black),
      ),
      backgroundColor: isSelected ? AppColors.primary : AppColors.lightGrey,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
    );
  }
}
