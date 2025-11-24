import 'package:buzzify/controller/friends_controller.dart';
import 'package:buzzify/controller/home_controller.dart';
import 'package:buzzify/controller/profile_controller.dart';
import 'package:buzzify/controller/user_list_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  final RxInt _currentIndex = 0.obs;
  final PageController pageController = PageController();

  int get currentIndex => _currentIndex.value;
  @override
  void onInit() {
    super.onInit();

    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => FriendsController());
    Get.lazyPut(() => UsersListController());
    Get.lazyPut(() => ProfileController());
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void changeTabIndex(int index) {
    _currentIndex.value = index;
    pageController.animateToPage(
      index,
      duration: Duration(microseconds: 300),
      curve: Curves.ease,
    );
  }

  void onPageChanged(int index) {
    _currentIndex.value = index;
  }

  int getUnreadCount() {
    try {
      final homeController = Get.find<HomeController>();
      return homeController.getUnreadCount();
     
    } catch (e) {
      return 0;
    }
  }

  int getNotificationCount() {
    try {
      final homeController = Get.find<HomeController>();
      return homeController.getUnreadNotificationsCount();
      
    } catch (e) {
      return 0;
    }
  }
}
