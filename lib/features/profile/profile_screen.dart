import 'package:buzzify/features/auth/signin_screen.dart';
import 'package:buzzify/features/profile/change_password_screen.dart';
import 'package:flutter/material.dart';
import '../../common/constants/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text('Profile', style: TextStyle(color: AppColors.black)),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Edit',
              style: TextStyle(color: AppColors.grey, fontSize: 16),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              // Profile Header
              const CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.primary,
                child: Text(
                  'D',
                  style: TextStyle(fontSize: 48, color: AppColors.white),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Dear Programmer',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                'dearprogrammerofficial@gmail.com',
                style: TextStyle(fontSize: 16, color: AppColors.grey),
              ),
              const SizedBox(height: 8),
              const Chip(
                label: Text('Online', style: TextStyle(color: Colors.green)),
                backgroundColor: Color(0xFFE8F5E9), // Light green
                padding: EdgeInsets.symmetric(horizontal: 8),
              ),
              const SizedBox(height: 4),
              const Text(
                'Joined Jul 2020',
                style: TextStyle(color: AppColors.grey),
              ),
              const SizedBox(height: 24),

              // Personal Information Card
              _buildPersonalInfoCard(),

              const SizedBox(height: 24),

              // Menu Items
              _ProfileMenuItem(
                icon: Icons.shield_outlined,
                title: 'Change Password',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChangePasswordScreen(),
                    ),
                  );
                },
              ),
              const Divider(),
              _ProfileMenuItem(
                icon: Icons.logout,
                title: 'Sign Out',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SigninScreen(),
                    ),
                  );
                },
              ),
              const Divider(),
              _ProfileMenuItem(
                icon: Icons.delete_outline,
                title: 'Delete Account',
                textColor: Colors.red,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget for the Personal Information card
  Widget _buildPersonalInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Personal Information',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          // Read-only TextFields
          TextField(
            readOnly: true,
            controller: TextEditingController(text: 'Dear Programmer'),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.lightGrey,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            readOnly: true,
            controller: TextEditingController(
              text: 'dearprogrammerofficial@gmail.com',
            ),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.email_outlined),
              filled: true,
              fillColor: AppColors.lightGrey,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none,
              ),
              helperText: 'Email cannot be changed',
              helperStyle: const TextStyle(color: AppColors.grey),
            ),
          ),
        ],
      ),
    );
  }
}

// Helper widget for menu items like "Change Password", "Sign Out", etc.
class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? textColor;

  const _ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: textColor ?? AppColors.black),
      title: Text(
        title,
        style: TextStyle(fontSize: 16, color: textColor ?? AppColors.black),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    );
  }
}
