import 'package:flutter/material.dart';
import '../../common/constants/app_colors.dart';
import 'widgets/find_friend_list_item_widget.dart';

class FindFriendsScreen extends StatelessWidget {
  const FindFriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Find Peoples',
          style: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            // Search Bar
            const TextField(
              decoration: InputDecoration(
                hintText: 'Search conversations...',
                prefixIcon: Icon(Icons.search),
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
            const SizedBox(height: 20),

            // User List
            Expanded(
              child: ListView(
                children: const [
                  FindFriendListItemWidget(
                    name: 'Alex',
                    email: 'alex@gmail.com',
                    avatarInitial: 'A',
                    status: FriendStatus.none, // "Add Friend" button
                  ),
                  FindFriendListItemWidget(
                    name: 'John',
                    email: 'john@gmail.com',
                    avatarInitial: 'J',
                    status: FriendStatus.none,
                  ),
                  FindFriendListItemWidget(
                    name: 'Max',
                    email: 'max@gmail.com',
                    avatarInitial: 'M',
                    status: FriendStatus.none,
                  ),
                  FindFriendListItemWidget(
                    name: 'Lewis',
                    email: 'lewis@gmail.com',
                    avatarInitial: 'L',
                    status: FriendStatus.requestSent, // "Request Sent" buttons
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
