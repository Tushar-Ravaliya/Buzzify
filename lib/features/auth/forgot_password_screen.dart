import 'package:buzzify/common/theme/app_theme.dart';
import 'package:buzzify/controller/forgot_password_controller.dart';
import 'package:buzzify/features/auth/reset_confirmation_screen.dart';
import 'package:buzzify/features/auth/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/constants/app_colors.dart';
import '../../common/constants/app_icons.dart';
import '../../common/widgets/custom_button.dart';
import '../../common/widgets/custom_text_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgotPasswordController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          // 1. Wrap your Column with SingleChildScrollView
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // Title
                const Text(
                  'Forgot Password',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimaryColor,
                  ),
                ),
                const SizedBox(height: 8),

                // Subtitle
                const Text(
                  'Enter your email to receive a password reset link',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppTheme.textSecondaryColor,
                  ),
                ),
                const SizedBox(height: 60),

                // Reset Icon
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.lock_reset,
                      color: AppColors.primary,
                      size: 40,
                    ),
                  ),
                ),
                const SizedBox(height: 60),

                // Form with Email Field
                Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      // Email Field
                      CustomTextField(
                        controller: controller.emailController,
                        hintText: 'Email Address',
                        prefixIcon: AppIcons.email,
                        validator: controller.validateEmail,
                      ),
                      const SizedBox(height: 40),

                      // Send Reset Link Button
                      Obx(
                        () => CustomButton(
                          text: controller.isLoading
                              ? 'Sending...'
                              : 'Send Reset Link',
                          leadingIcon: Icons.send,
                          onPressed: controller.isLoading
                              ? () {}
                              : () {
                                  controller.sendPasswordResetEmail().then((_) {
                                    if (controller.emailSent &&
                                        context.mounted) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ResetConfirmationScreen(
                                                email: controller
                                                    .emailController
                                                    .text,
                                              ),
                                        ),
                                      );
                                    }
                                  });
                                },
                        ),
                      ),
                    ],
                  ),
                ),

                // 2. Remove the Spacer widget.
                // const Spacer(),

                // Add some space manually if needed
                const SizedBox(height: 40),

                // "Remember your password?"
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Remember your password?",
                      style: TextStyle(color: AppColors.grey),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
