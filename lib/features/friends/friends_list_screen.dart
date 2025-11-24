import 'package:buzzify/common/theme/app_theme.dart';
import 'package:buzzify/controller/friends_controller.dart';
import 'package:buzzify/features/friends/widgets/friend_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/constants/app_colors.dart';
import '../../common/widgets/custom_button.dart';

class FriendsListScreen extends GetView<FriendsController> {
  const FriendsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Friends',
          style: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: controller.openFriendRequest,
            icon: const Icon(Icons.person_add_alt_1),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            TextField(
              onChanged: controller.updateSearchQuery,
              decoration: InputDecoration(
                hintText: 'Search Friend...',
                prefixIcon: Icon(Icons.search),
                suffixIcon: Obx(() {
                  return controller.searchQuery.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            controller.clearSearch();
                          },
                        )
                      : SizedBox.shrink();
                }),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  borderSide: BorderSide(color: AppColors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  borderSide: BorderSide(color: AppColors.grey),
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: controller.refreshFriends,
                child: Obx(() {
                  if (controller.friends.isNotEmpty && controller.isLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    );
                  }
                  if (controller.filteredFriends.isEmpty) {
                    return _buildEmptyState();
                  }
                  return ListView.separated(
                    padding: EdgeInsets.all(16),
                    itemCount: controller.filteredFriends.length,
                    separatorBuilder: (context, index) => SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final friend = controller.filteredFriends[index];
                      return FriendListItem(
                        friend: friend,
                        lastSeenText:
                            controller.getLastSeenText(friend),
                        onTap: () => controller.startChat(friend),
                        onRemove: () => controller.removeFriend(friend),
                        onBlock: () => controller.blockFriend(friend),
                      );
                    },
                  );
                }),
              ),
            ),
          ],
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
                Icons.people_outline,
                size: 50,
                color: AppTheme.primaryColor,
              ),
            ),
            SizedBox(height: 20),
            Text(
              controller.searchQuery.isEmpty
                  ? 'No friends found.'
                  : 'No friends match your search.',
              style: Theme.of(Get.context!).textTheme.headlineMedium?.copyWith(
                color: AppTheme.textPrimaryColor,
              ),
            ),
            SizedBox(height: 10),
            Text(
              controller.searchQuery.isEmpty
                  ? 'Try adjusting your search or filter to find what you are looking for.'
                  : 'add some friends to start chatting with them.',
              style: Theme.of(Get.context!).textTheme.bodyMedium?.copyWith(
                color: AppTheme.textSecondaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            if (controller.searchQuery.isEmpty) ...[
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: CustomButton(
                  text: 'Find Friends',
                  leadingIcon: Icons.person_add_alt_1,
                  onPressed: controller.openFriendRequest,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
