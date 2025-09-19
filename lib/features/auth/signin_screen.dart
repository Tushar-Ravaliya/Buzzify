import 'package:buzzify/features/auth/forgot_password_screen.dart';
import 'package:buzzify/features/auth/signup_screen.dart';
import 'package:buzzify/features/main/main_screen.dart';
import 'package:flutter/material.dart';
import '../../common/constants/app_colors.dart';
import '../../common/constants/app_icons.dart';
import '../../common/widgets/custom_button.dart';
import '../../common/widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Chat Icon
              const Icon(
                Icons.chat_bubble_outline, // Replace with your actual app icon
                size: 80,
                color: AppColors.black,
              ),
              const SizedBox(height: 20),

              // Welcome Text
              const Text(
                'Welcome back!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Sign in to continue chatting with your friends',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: AppColors.grey),
              ),
              const SizedBox(height: 40),

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

              // Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Navigate to Forgot Password screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgotPasswordScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: AppColors.black),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Sign In Button
              CustomButton(
                text: 'Sign In',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MainScreen()),
                  );
                },
              ),
              const SizedBox(height: 30),

              // "OR" Divider
              const Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('OR', style: TextStyle(color: AppColors.grey)),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 20),

              // Sign Up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      // Navigate to Sign Up screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Sign Up',
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
