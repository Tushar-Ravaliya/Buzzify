import 'package:buzzify/common/theme/app_theme.dart';
import 'package:buzzify/controller/friend_request_controller.dart';
import 'package:buzzify/features/friends/widgets/friend_request_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FriendRequestsScreen extends GetView<FriendRequestsController> {
  const FriendRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Friend Requests'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Obx(
              () => Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => controller.changeTab(0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        decoration: BoxDecoration(
                          color: controller.selectedTabIndex == 0
                              ? AppTheme.primaryColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.inbox,
                              color: controller.selectedTabIndex == 0
                                  ? Colors.white
                                  : AppTheme.textSecondaryColor,
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              'Received (${controller.receivedRequests.length})',
                              style: TextStyle(
                                color: controller.selectedTabIndex == 0
                                    ? Colors.white
                                    : AppTheme.textSecondaryColor,
                                fontWeight: controller.selectedTabIndex == 0
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => controller.changeTab(1),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        decoration: BoxDecoration(
                          color: controller.selectedTabIndex == 1
                              ? AppTheme.primaryColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.send,
                              color: controller.selectedTabIndex == 1
                                  ? Colors.white
                                  : AppTheme.textSecondaryColor,
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              'Sent (${controller.sentRequests.length})',
                              style: TextStyle(
                                color: controller.selectedTabIndex == 1
                                    ? Colors.white
                                    : AppTheme.textSecondaryColor,
                                fontWeight: controller.selectedTabIndex == 1
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              return IndexedStack(
                index: controller.selectedTabIndex,
                children: [
                  _buildReceivedRequestsTab(),
                  _buildSentRequestsTab(),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildReceivedRequestsTab() {
    return Obx(() {
      if (controller.receivedRequests.isEmpty) {
        return _buildEmptyState(
          icon: Icons.inbox_outlined,
          title: 'No Received Requests',
          message: 'You have no received friend requests at the moment.',
        );
      }
      return ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: controller.receivedRequests.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12.0),
        itemBuilder: (contex, index) {
          final request = controller.receivedRequests[index];
          final sender = controller.getUser(request.senderId);
          if (sender == null) {
            return const SizedBox.shrink();
          }
          return FriendRequestItem(
            request: request,
            user: sender,
            timeText: controller.getRequestTimeText(request.createdAt),
            isReceived: true,
            onAccept: () => controller.acceptRequest(request),
            onDecline: () => controller.declineRequest(request),
          );
        },
      );
    });
  }

  Widget _buildSentRequestsTab() {
    return Obx(() {
      if (controller.sentRequests.isEmpty) {
        return _buildEmptyState(
          icon: Icons.send_outlined,
          title: 'No Sent Requests',
          message: 'You have not sent any friend requests yet.',
        );
      }
      return ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: controller.sentRequests.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12.0),
        itemBuilder: (context, index) {
          final request = controller.sentRequests[index];
          final recipient = controller.getUser(request.senderId);
          if (recipient == null) {
            return const SizedBox.shrink();
          }
          return FriendRequestItem(
            request: request,
            user: recipient,
            timeText: controller.getRequestTimeText(request.createdAt),
            isReceived: false,
            statusText: controller.getStatusText(request.status),
            statusColor: controller.getStatusColor(request.status),
          );
        },
      );
    });
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String message,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 16.0),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16.0, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
