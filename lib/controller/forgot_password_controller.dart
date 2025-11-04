import 'package:buzzify/service/auth_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final AuthService _authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxBool _isLoading = false.obs;
  final RxString _error = ''.obs;
  final RxBool _emailSent = false.obs;

  bool get emailSent => _emailSent.value;
  String get error => _error.value;
  bool get isLoading => _isLoading.value;
  
  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
  Future<void> sendPasswordResetEmail() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    _isLoading.value = true;
    _error.value = '';
    try {
      await _authService.sendPasswordResetEmail(emailController.text.trim());
      _emailSent.value = true;
      Get.snackbar(
        'Success',
        'Password reset email sent. Please check your inbox.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      _error.value = e.toString();
      Get.snackbar(
        'Error',
        _error.value,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _isLoading.value = false;
    }
  }
  void resentMail() {
    _emailSent.value = false;
    sendPasswordResetEmail();
  }
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }
  void clearError() {
    _error.value = '';
  }
}