import 'package:buzzify/model/user_model.dart';
import 'package:buzzify/routes/app_routes.dart';
import 'package:buzzify/service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();
  final Rx<User?> _user = Rx<User?>(null);
  final Rx<UserModel?> _userModel = Rx<UserModel?>(null);
  final RxBool _isLoading = false.obs;
  final RxString _error = ''.obs;
  final RxBool _isinitialized = false.obs;
  User? get user => _user.value;
  UserModel? get userModel => _userModel.value;
  bool get isLoading => _isLoading.value;
  String get error => _error.value;
  bool get isAuthenticated => user != null;
  bool get isInitialized => _isinitialized.value;
  @override
  void onInit() {
    super.onInit();
    _user.bindStream(_authService.authStateChanges);
    ever<User?>(_user, _handleAuthStateChanged);
  }

  Future<void> _handleAuthStateChanged(User? user) async {
    if (user == null) {
      if (Get.currentRoute != AppRoutes.signin) {
        Get.offAllNamed(AppRoutes.signin);
      }
    } else {
      if (Get.currentRoute != AppRoutes.main) {
        Get.offAllNamed(AppRoutes.main);
      }
    }
    if (!_isinitialized.value) {
      _isinitialized.value = true;
    }
  }

  void checkInitialAuthState() {
    final currentUser = _authService.currentUser;
    if (currentUser != null) {
      _user.value = currentUser;
      Get.offAllNamed(AppRoutes.main);
    } else {
      Get.offAllNamed(AppRoutes.signin);
    }
    _isinitialized.value = true;
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    _isLoading.value = true;
    _error.value = '';
    try {
      UserModel? userModel = await _authService.signInWithEmailAndPassword(
        email,
        password,
      );
      if (userModel != null) {
        _userModel.value = userModel;
        Get.offAllNamed(AppRoutes.profile);
      }
    } catch (e) {
      _error.value = e.toString();
      Get.snackbar('Sign In Error', _error.value);
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> registerWithEmailAndPassword(
    String email,
    String password,
    String displayName,
  ) async {
    _isLoading.value = true;
    _error.value = '';
    try {
      UserModel? userModel = await _authService.registerWithEmailAndPassword(
        email,
        password,
        displayName,
      );
      if (userModel != null) {
        _userModel.value = userModel;
        Get.offAllNamed(AppRoutes.main);
      }
    } catch (e) {
      _error.value = e.toString();
      Get.snackbar('Registration Error', _error.value);
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    _isLoading.value = true;
    _error.value = '';
    try {
      await _authService.signOut();
      _userModel.value = null;
      Get.offAllNamed(AppRoutes.signin);
    } catch (e) {
      _error.value = e.toString();
      Get.snackbar('Sign Out Error', _error.value);
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> deleteAccount() async {
    _isLoading.value = true;
    _error.value = '';
    try {
      if (_userModel.value != null) {
        await _authService.deleteAccount();
        _userModel.value = null;
        Get.offAllNamed(AppRoutes.signin);
      }
    } catch (e) {
      _error.value = e.toString();
      Get.snackbar('Delete Account Error', _error.value);
    } finally {
      _isLoading.value = false;
    }
  }

  void clearError() {
    _error.value = '';
  }
}
