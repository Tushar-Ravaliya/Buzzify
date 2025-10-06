import 'package:flutter/material.dart';
import '../../common/constants/app_colors.dart';
import '../../common/constants/app_icons.dart';
import '../../common/widgets/custom_button.dart';
import '../../common/widgets/custom_text_field.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // leading: const Icon(Icons.arrow_back, color: AppColors.black),
        title: const Text(
          'Change Password',
          style: TextStyle(color: AppColors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Shield Icon
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withOpacity(0.1),
                ),
                child: const Icon(
                  Icons.shield_outlined,
                  color: AppColors.primary,
                  size: 60,
                ),
              ),
              const SizedBox(height: 24),

              // Title and Subtitle
              const Text(
                'Update Your Password',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Enter your current password and choose a new secure password',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.grey, fontSize: 16),
              ),
              const SizedBox(height: 32),

              // Reusing the CustomTextField widget
              const CustomTextField(
                hintText: 'Current Password',
                prefixIcon: AppIcons.password,
                obscureText: true,
                suffixIcon: Icon(AppIcons.visibility, color: AppColors.grey),
              ),
              const SizedBox(height: 20),
              const CustomTextField(
                hintText: 'New Password',
                prefixIcon: AppIcons.password,
                obscureText: true,
                suffixIcon: Icon(AppIcons.visibility, color: AppColors.grey),
              ),
              const SizedBox(height: 20),
              const CustomTextField(
                hintText: 'Confirm New Password',
                prefixIcon: AppIcons.password,
                obscureText: true,
                suffixIcon: Icon(AppIcons.visibility, color: AppColors.grey),
              ),
              const SizedBox(height: 40),

              // Reusing the CustomButton widget
              CustomButton(
                text: 'Update Password',
                leadingIcon: Icons.shield,
                onPressed: () {
                  // Handle password update logic
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
