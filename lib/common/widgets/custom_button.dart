import 'package:buzzify/common/theme/app_theme.dart';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? leadingIcon; // Add this line

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.leadingIcon, // Add this line
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        child: Row(
          // Use a Row to accommodate the icon
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leadingIcon != null) // Conditionally show the icon
              Icon(leadingIcon, color: AppColors.white),
            if (leadingIcon != null) const SizedBox(width: 8), // Add spacing
            Text(
              text,
              style: const TextStyle(fontSize: 18, color: AppColors.white),
            ),
          ],
        ),
      ),
    );
  }
}
