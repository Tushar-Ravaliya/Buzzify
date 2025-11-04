import 'package:buzzify/controller/profile_controller.dart';
import 'package:buzzify/features/auth/forgot_password_screen.dart';
import 'package:buzzify/features/auth/signin_screen.dart';
import 'package:buzzify/features/auth/signup_screen.dart';
import 'package:buzzify/features/chat/chat_list_screen.dart';
import 'package:buzzify/features/profile/profile_screen.dart';
import 'package:buzzify/routes/app_routes.dart';
import 'package:get/get.dart';

class AppPages {
  static const initial = AppRoutes.signin;

  static final routes = [
    GetPage(name: AppRoutes.signin, page: () => const SigninScreen()),
    GetPage(name: AppRoutes.signup, page: () => const SignupScreen()),
    // Home/Main routes
    GetPage(name: AppRoutes.home, page: () => const ChatListScreen()),
    GetPage(name: AppRoutes.main, page: () => const ChatListScreen()),
    // Forgot Password
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordScreen(), 
    ),
    // binding: BindingsBuilder(() {
    //   Get.put(RegisterController());
    // }),
    // ),
    // GetPage(name: AppRoutes.home, page: () => const HomePage(),
    // binding: BindingsBuilder(() {
    //   Get.put(HomeController());
    // }),
    // ),
    // GetPage(
    //   name: AppRoutes.main,
    //   page: () => const MainView(),

    //   binding: BindingsBuilder(() {
    //     Get.put(MainController());
    //   }),
    // ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileScreen(),
      binding: BindingsBuilder(() {
        Get.put(ProfileController());
      }),
    ),
    // GetPage(
    //   name: AppRoutes.chat,
    //   page: () => const ChatView(),
    //   binding: BindingsBuilder(() {
    //     Get.put(ChatController());
    //   }),
    // ),
    // GetPage(
    //   name: AppRoutes.userList,
    //   page: () => const UserListView(),
    //   binding: BindingsBuilder(() {
    //     Get.put(UserListController());
    //   }),
    // ),
    // GetPage(
    //   name: AppRoutes.friends,
    //   page: () => const FriendsView(),
    //   binding: BindingsBuilder(() {
    //     Get.put(FriendsController());
    //   }),
    // ),
    // GetPage(
    //   name: AppRoutes.friendRequests,
    //   page: () => const FriendRequestsView(),
    //   binding: BindingsBuilder(() {
    //     Get.put(FriendRequestsController());
    //   }),
    // ),
    // GetPage(
    //   name: AppRoutes.notifications,
    //   page: () => const NotificationsView(),
    //   binding: BindingsBuilder(() {
    //     Get.put(NotificationController());
    //   }),
    // ),
  ];
}
