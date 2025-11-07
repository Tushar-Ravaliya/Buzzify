import 'package:buzzify/controller/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  final AuthController _authController = Get.find<AuthController>();
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxBool _isLoading = false.obs;
  final RxString _error = ''.obs;
  final RxBool _obscureCurrentPassword = true.obs;
  final RxBool _obscureNewPassword = true.obs;
  final RxBool _obscureConfirmPassword = true.obs;

  RxBool get isLoading => _isLoading;
  RxString get error => _error;
  RxBool get obscureCurrentPassword => _obscureCurrentPassword;
  RxBool get obscureNewPassword => _obscureNewPassword;
  RxBool get obscureConfirmPassword => _obscureConfirmPassword;

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void toggleCurrentPasswordVisibility() {
    _obscureCurrentPassword.value = !_obscureCurrentPassword.value;
  }

  void toggleNewPasswordVisibility() {
    _obscureNewPassword.value = !_obscureNewPassword.value;
  }

  void toggleConfirmPasswordVisibility() {
    _obscureConfirmPassword.value = !_obscureConfirmPassword.value;
  }

  Future<void> changePassword() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    _isLoading.value = true;
    _error.value = '';
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw Exception('No authenticated user found.');
      }
     

      await user.updatePassword(newPasswordController.text);

      await _authController.signOut();

      Get.snackbar('Success', 'Password changed successfully.');
      currentPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();
      Get.back();
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'wrong-password':
          errorMessage = 'The current password is incorrect.';
          break;
        case 'weak-password':
          errorMessage = 'The new password is too weak.';
          break;
        case 'requires-recent-login':
          errorMessage = 'Please log in again to change your password.';
          break;
        default:
          errorMessage = 'An error occurred: ${e.message}';
      }
      _error.value = errorMessage;
      Get.snackbar('Error', _error.value);
    } catch (e) {
      _error.value = e.toString();
      Get.snackbar('Error', _error.value);
    } finally {
      _isLoading.value = false;
    }
  }

  String? validateCurrentPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your current password';
    }
    return null;
  }
  String? validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a new password';
    }
    if (value.length < 6) {
      return 'New password must be at least 6 characters';
    }
    if (value == currentPasswordController.text) {
      return 'New password must be different from current password';
    }
    return null;
  }
  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your new password';
    }
    if (value != newPasswordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }
  void clearError() {
    _error.value = '';
  }
}
