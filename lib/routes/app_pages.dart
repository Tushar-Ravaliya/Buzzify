import 'package:buzzify/features/auth/signin_screen.dart';
import 'package:buzzify/routes/app_routes.dart';
import 'package:get/route_manager.dart';


class AppPages {
  static const initial = AppRoutes.login;

  static final routes = [
    // GetPage(name: AppRoutes.splash, page: () => const SplashView()),
    GetPage(name: AppRoutes.login, page: () => const SigninScreen()),
    // GetPage(name: AppRoutes.register, page: () => const RegisterView(),
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
    // GetPage(
    //   name: AppRoutes.profile,
    //   page: () => const ProfileView(),
    //   binding: BindingsBuilder(() {
    //     Get.put(ProfileController());
    //   }),
    // ),
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
