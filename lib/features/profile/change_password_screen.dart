import 'package:buzzify/controller/change_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/constants/app_colors.dart';
import '../../common/constants/app_icons.dart';
import '../../common/widgets/custom_button.dart';
import '../../common/widgets/custom_text_field.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChangePasswordController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        
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
                  color: AppColors.primary.withValues(alpha: 0.1),
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

              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    Obx(
                      () => CustomTextField(
                        hintText: 'Current Password',
                        prefixIcon: AppIcons.password,
                        controller: controller.currentPasswordController,
                        obscureText: controller.obscureCurrentPassword.value,
                        validator: controller.validateCurrentPassword,
                        suffixIcon: IconButton(
                          onPressed: controller.toggleCurrentPasswordVisibility,
                          icon: Icon(
                            controller.obscureCurrentPassword.value
                                ? AppIcons.visibility
                                : AppIcons.visibilityOff,
                            color: AppColors.grey,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Obx(
                      () => CustomTextField(
                        hintText: 'New Password',
                        prefixIcon: AppIcons.password,
                        controller: controller.newPasswordController,
                        obscureText: controller.obscureNewPassword.value,
                        validator: controller.validateNewPassword,
                        suffixIcon: IconButton(
                          onPressed: controller.toggleNewPasswordVisibility,
                          icon: Icon(
                            controller.obscureNewPassword.value
                                ? AppIcons.visibility
                                : AppIcons.visibilityOff,
                            color: AppColors.grey,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Obx(
                      () => CustomTextField(
                        hintText: 'Confirm New Password',
                        prefixIcon: AppIcons.password,
                        controller: controller.confirmPasswordController,
                        obscureText: controller.obscureConfirmPassword.value,
                        validator: controller.validateConfirmPassword,
                        suffixIcon: IconButton(
                          onPressed: controller.toggleConfirmPasswordVisibility,
                          icon: Icon(
                            controller.obscureConfirmPassword.value
                                ? AppIcons.visibility
                                : AppIcons.visibilityOff,
                            color: AppColors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Reusing the CustomButton widget
              Obx(
                () => CustomButton(
                  text: 'Update Password',
                  leadingIcon: Icons.shield,
                  onPressed: controller.isLoading.value
                      ? () {}
                      : () => controller.changePassword(),
                  label: controller.isLoading.value
                      ? 'Updating...'
                      : 'Update Password',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
