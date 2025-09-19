import 'package:buzzify/features/friends/find_friends_screen.dart';
import 'package:buzzify/features/friends/friends_list_screen.dart';
import 'package:buzzify/features/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import '../../common/widgets/custom_bottom_nav_bar.dart'; // Import the new widget
import '../chat/chat_list_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    ChatListScreen(),
    FriendsListScreen(),
    FindFriendsScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      // Replace the old BottomNavigationBar with your reusable widget
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
