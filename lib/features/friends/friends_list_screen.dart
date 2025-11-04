import 'package:flutter/material.dart';
import '../../common/constants/app_colors.dart';
import '../../common/widgets/custom_button.dart';
import 'find_friends_screen.dart'; // To navigate to the find friends page

class FriendsListScreen extends StatelessWidget {
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
            onPressed: () {
              // Navigate to the Find Friends screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FindFriendsScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.person_add_alt_1_outlined,
              color: AppColors.black,
            ),
          ),
          const SizedBox(width: 8),
        ],
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

            // Empty State Content
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary.withValues(alpha: 0.1),
                    ),
                    child: Icon(
                      Icons.people_outline,
                      color: AppColors.primary,
                      size: 60,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'No Friends yet',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Add friends to start chatting with them',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.grey, fontSize: 16),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: CustomButton(
                      text: 'View Friend Request',
                      leadingIcon: Icons.person_add_alt_1,
                      onPressed: () {
                        // Navigate to the Find Friends screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FindFriendsScreen(),
                          ),
                        );
                      },
                    ),
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
