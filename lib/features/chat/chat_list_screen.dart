import 'dart:math';

import 'package:buzzify/common/theme/app_theme.dart';
import 'package:buzzify/common/widgets/custom_button.dart';
import 'package:buzzify/controller/auth_controller.dart';
import 'package:buzzify/controller/home_controller.dart';
import 'package:buzzify/features/chat/widgets/chat_list_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatListScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context, authController),
      body: Column(
        children: [
          _buildSeachBar(),
          Obx(
            () => controller.isSearching && controller.searchQuery.isNotEmpty
                ? _buildSearchResults()
                : _buildQuickFilters(),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: controller.refreshChats,
              child: Obx(() {
                if (controller.chats.isEmpty) {
                  if (controller.isSearching &&
                      controller.searchQuery.isNotEmpty) {
                    return _buildNoSearchResults();
                  } else if (controller.activeFilter != 'All') {
                    return _buildNoFiltersResults();
                  } else {
                    return _buildEmptyState();
                  }
                }
                return _buildChatsList();
              }),
            ),
          ),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    AuthController authController,
  ) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Obx(
        () => Text(controller.isSearching ? 'Searching...' : 'Messages '),
      ),
      automaticallyImplyLeading: false,
      actions: [
        Obx(
          () => controller.isSearching
              ? IconButton(
                  icon: const Icon(Icons.close, color: Colors.black),
                  onPressed: () {
                    controller.clearSearch();
                  },
                )
              : _builsNotificatiobButton(),
        ),
      ],
    );
  }

  Widget _builsNotificatiobButton() {
    return Obx(
      () => IconButton(
        onPressed: controller.openNotifications,
        icon: Stack(
          children: [
            const Icon(Icons.notifications_none, color: Colors.black),
            if (controller.getUnreadCount() > 0)
              Positioned(
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 12,
                    minHeight: 12,
                  ),
                  child: Text(
                    '${controller.getUnreadNotificationsCount()}',
                    style: const TextStyle(color: Colors.white, fontSize: 8),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeachBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextField(
        onChanged: controller.onSearchChanged,
        decoration: InputDecoration(
          hintText: 'Search Chats...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: Obx(() {
            return controller.searchQuery.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      controller.clearSearch();
                    },
                  )
                : const SizedBox.shrink();
          }),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickFilters() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Obx(
              () => _buildFilterChip(
                'All',
                () => controller.setFilter('All'),
                controller.activeFilter == 'All',
              ),
            ),
            const SizedBox(width: 8),
            Obx(
              () => _buildFilterChip(
                'Unread',
                () => controller.setFilter('Unread'),
                controller.activeFilter == 'Unread',
              ),
            ),
            const SizedBox(width: 8),
            Obx(
              () => _buildFilterChip(
                'Recent',
                () => controller.setFilter('Recent'),
                controller.activeFilter == 'Recent',
              ),
            ),
            const SizedBox(width: 8),
            Obx(
              () => _buildFilterChip(
                'Active',
                () => controller.setFilter('Active'),
                controller.activeFilter == 'Active',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, VoidCallback onTap, bool isSelected) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryColor : Colors.grey[200],
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          label,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(16, 8, 18, 8),
      child: Row(
        children: [
          Obx(
            () => Text(
              '${controller.filteredChats.length} Results found',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppTheme.textSecondaryColor,
              ),
            ),
          ),
          Spacer(),
          TextButton(
            onPressed: controller.clearSearch,
            child: Text(
              'Clear Search',
              style: TextStyle(color: AppTheme.primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoSearchResults() {
    return Expanded(
      child: Center(
        child: Text(
          'No chats found for "${controller.searchQuery}"',
          style: TextStyle(fontSize: 16, color: AppTheme.textSecondaryColor),
        ),
      ),
    );
  }

  Widget _buildNoFiltersResults() {
    return Expanded(
      child: Center(
        child: Text(
          'No chats available',
          style: TextStyle(fontSize: 16, color: AppTheme.textSecondaryColor),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                Icons.chat_bubble_outline,
                size: 50,
                color: AppTheme.primaryColor,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'No chats available.',
              style: TextStyle(
                fontSize: 16,
                color: AppTheme.textSecondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatsList() {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(() {
            String title = 'Recent Chats';
            switch (controller.activeFilter) {
              case 'Unread':
                title = 'Unread Chats';
                break;
              case 'Recent':
                title = 'Recent Chats';
                break;
              case 'Active':
                title = 'Active Chats';
                break;
              default:
                title = 'All Chats';
            }
            return Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimaryColor,
              ),
            );
          }),
          Row(
            children: [
              if (controller.activeFilter != 'All')
                TextButton(
                  onPressed: () => controller.setFilter('All'),
                  child: Text(
                    'Clear Filter',
                    style: TextStyle(color: AppTheme.primaryColor),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: controller.openFriends,
      backgroundColor: AppTheme.primaryColor,
      label: Text('New Chat'),
      icon: Icon(Icons.chat),
    );
  }
}
