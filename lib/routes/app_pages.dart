import 'package:buzzify/controller/friend_request_controller.dart';
import 'package:buzzify/controller/friends_controller.dart';
import 'package:buzzify/controller/main_controller.dart';
import 'package:buzzify/controller/profile_controller.dart';
import 'package:buzzify/controller/user_list_controller.dart';
import 'package:buzzify/features/auth/forgot_password_screen.dart';
import 'package:buzzify/features/auth/signin_screen.dart';
import 'package:buzzify/features/auth/signup_screen.dart';
import 'package:buzzify/features/chat/chat_list_screen.dart';
import 'package:buzzify/features/friends/find_friends_screen.dart';
import 'package:buzzify/features/friends/friend_requests_screen.dart';
import 'package:buzzify/features/friends/friends_list_screen.dart';
import 'package:buzzify/features/main/main_screen.dart';
import 'package:buzzify/features/notification/notification_screen.dart';
import 'package:buzzify/features/profile/change_password_screen.dart';
import 'package:buzzify/features/profile/profile_screen.dart';
import 'package:buzzify/routes/app_routes.dart';
import 'package:get/get.dart';

class AppPages {
  static const initial = AppRoutes.signin;

  static final routes = [
    GetPage(name: AppRoutes.signin, page: () => const SigninScreen()),
    GetPage(name: AppRoutes.signup, page: () => const SignupScreen()),

    // GetPage(name: AppRoutes.main, page: () => ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordScreen(),
    ),
    GetPage(
      name: AppRoutes.changePassword,
      page: () => const ChangePasswordScreen(),
    ),
    GetPage(
      name: AppRoutes.main,
      page: () => MainScreen(),

      binding: BindingsBuilder(() {
        Get.put(MainController());
      }),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => ChatListScreen(),

      binding: BindingsBuilder(() {
        Get.put(MainController());
      }),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => ProfileScreen(),
      binding: BindingsBuilder(() {
        Get.put(() => ProfileController());
      }),
    ),
    // GetPage(
    //   name: AppRoutes.chat,
    //   page: () => const ChatView(),
    //   binding: BindingsBuilder(() {
    //     Get.put(ChatController());
    //   }),
    // ),
    GetPage(
      name: AppRoutes.userList,
      page: () => FindFriendsScreen(),
      binding: BindingsBuilder(() {
        Get.put(UsersListController());
      }),
    ),
    GetPage(
      name: AppRoutes.friends,
      page: () => const FriendsListScreen(),
      binding: BindingsBuilder(() {
        Get.put(FriendsController());
      }),
    ),
    GetPage(
      name: AppRoutes.friendRequests,
      page: () => const FriendRequestsScreen(),
      binding: BindingsBuilder(() {
        Get.put(FriendRequestsController());
      }),
    ),
    GetPage(
      name: AppRoutes.notifications,
      page: () => const NotificationScreen(),
      // binding: BindingsBuilder(() {
      //   Get.put(NotificationController());
      // }),
    ),
  ];
}
