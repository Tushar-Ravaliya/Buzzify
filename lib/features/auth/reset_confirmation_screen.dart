import 'package:buzzify/controller/forgot_password_controller.dart';
import 'package:buzzify/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/constants/app_colors.dart';
import '../../common/widgets/custom_button.dart';

class ResetConfirmationScreen extends StatelessWidget {
  // Pass the user's email to display it on the screen
  final String email;
  final ForgotPasswordController controller =
      Get.find<ForgotPasswordController>();

  ResetConfirmationScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Forgot Password',
          style: TextStyle(color: AppColors.black),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Confirmation Box
              Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: AppColors.lightGreen,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.mark_email_read_outlined,
                      color: Colors.green,
                      size: 60,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Email Sent!',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "We've sent a password reset link to:\n$email",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Check your email and follow the instructions to reset your password',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: AppColors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Resend Email Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.refresh, color: AppColors.black),
                  label: const Text(
                    'Resend Email',
                    style: TextStyle(fontSize: 16, color: AppColors.black),
                  ),
                  onPressed: () {
                    controller.sendPasswordResetEmail();
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    backgroundColor: AppColors.lightGrey,
                    side: const BorderSide(color: Colors.transparent),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Back to Sign In Button (reusing our custom widget)
              CustomButton(
                text: 'Back To Sign In',
                leadingIcon: Icons.arrow_back,
                onPressed: () {
                  Get.toNamed(AppRoutes.signin);
                },
              ),
              const Spacer(),

              // Spam Folder Info Box
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 8.0,
                  runSpacing: 4.0,

                  children: [
                    Icon(Icons.info_outline, color: AppColors.grey, size: 20),
                    Text(
                      "Didn't receive the email? Check spam folder",
                      style: TextStyle(color: AppColors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
