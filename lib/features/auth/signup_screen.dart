import 'package:buzzify/features/auth/signin_screen.dart';
import 'package:flutter/material.dart';
import '../../common/constants/app_colors.dart';
import '../../common/constants/app_icons.dart';
import '../../common/widgets/custom_button.dart';
import '../../common/widgets/custom_text_field.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Title
              const Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 8),

              // Subtitle
              const Text(
                'Fill in your details to get started',
                style: TextStyle(fontSize: 16, color: AppColors.grey),
              ),
              const SizedBox(height: 40),

              // Name Field
              const CustomTextField(
                hintText: 'Name',
                prefixIcon: Icons.person_outline,
              ),
              const SizedBox(height: 20),

              // Email Field
              const CustomTextField(
                hintText: 'Email',
                prefixIcon: AppIcons.email,
              ),
              const SizedBox(height: 20),

              // Password Field
              const CustomTextField(
                hintText: 'Password',
                prefixIcon: AppIcons.password,
                obscureText: true,
                suffixIcon: Icon(AppIcons.visibility, color: AppColors.grey),
              ),
              const SizedBox(height: 20),

              // Confirm Password Field
              const CustomTextField(
                hintText: 'Confirm Password',
                prefixIcon: AppIcons.password,
                obscureText: true,
                suffixIcon: Icon(AppIcons.visibility, color: AppColors.grey),
              ),
              const SizedBox(height: 40),

              // Sign Up Button
              CustomButton(
                text: 'Sign Up',
                onPressed: () {
                  // Handle sign up logic
                },
              ),
              const SizedBox(height: 20),

              // "Already have an account?"
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(color: AppColors.black),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SigninScreen(),
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
            ],
          ),
        ),
      ),
    );
  }
}
