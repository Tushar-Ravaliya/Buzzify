import 'package:buzzify/controller/auth_controller.dart';
import 'package:buzzify/model/user_model.dart';
import 'package:buzzify/service/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final FirestoreService _firestoreService = FirestoreService();
  final AuthController _authController = Get.find<AuthController>();
  final TextEditingController displayNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final RxBool _isLoading = false.obs;
  final RxString _error = ''.obs;
  final RxBool _isEditing = false.obs;
  final Rx<UserModel?> _currentUser = Rx<UserModel?>(null);

  bool get isLoading => _isLoading.value;
  String get error => _error.value;
  bool get isEditing => _isEditing.value;
  UserModel? get currentUser => _currentUser.value;

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
  }

  @override
  void onClose() {
    displayNameController.dispose();
    emailController.dispose();
    super.onClose();
  }

  Future<void> _loadUserData() async {
    final currentUserId = _authController.user?.uid;
    if (currentUserId != null) {
      _currentUser.bindStream(_firestoreService.fetUserStream(currentUserId));

      ever(_currentUser, (UserModel? user) {
        if (user != null) {
          displayNameController.text = user.displayName;
          emailController.text = user.email;
        }
      });
    }
  }
  void toggleEditing() {
    _isEditing.value = !_isEditing.value;

    if(!_isEditing.value) {
      final user = _currentUser.value;
      if(user != null) {
        displayNameController.text = user.displayName;
        emailController.text = user.email;
      }
    }
  }
  Future<void> updateProfile() async {
    try{
      _isLoading.value = true;
      _error.value = '';
      final user = _currentUser.value;
      if(user == null) {
       return;
      }
      final updatedUser = user.copyWith(
        displayName: displayNameController.text.trim(),
      );
      await _firestoreService.updateUserProfile(updatedUser);
      _isEditing.value = false;
      Get.snackbar(
        'Success',
        'Profile updated successfully.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }catch(e){
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
  Future<void> signOut() async {
    await _authController.signOut();
  }
  Future<void> deleteAccount() async {
    try {
     final result = await Get.dialog<bool>(
        AlertDialog(
          title: const Text('Delete Account'),
          content: const Text('Are you sure you want to delete your account? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () => Get.back(result: false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Get.back(result: true),
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      );
     if(result == true){
      _isLoading.value = true;
      await _authController.deleteAccount();
     }
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
  String getJoinedData(){
    final user = _currentUser.value;
    if(user == null) {
      return '';
    }
    final date = user.createdAt;
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return 'Joined ${months[date.month - 1]} ${date.year}';
  }
}
