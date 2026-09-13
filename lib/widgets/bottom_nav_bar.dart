import 'package:flutter/material.dart';

import '../screens/screen2_home/home_screen.dart';
import '../screens/screen3_explore/explore_screen.dart';
import '../screens/screen7_my_bookings/my_bookings_screen.dart';
import '../screens/screen8_profile/profile_screen.dart';

class BottomNavBar
    extends StatefulWidget {
  final int initialIndex;

  const BottomNavBar({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<BottomNavBar>
  createState() =>
      _BottomNavBarState();
}

class _BottomNavBarState
    extends State<BottomNavBar> {
  late int currentIndex;

  late List<Widget> screens;

  @override
  void initState() {
    super.initState();

    currentIndex =
        widget.initialIndex;

    screens = const [
      HomeScreen(),
      ExploreScreen(),
      MyBookingsScreen(),
      ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],

      bottomNavigationBar:
      BottomNavigationBar(
        currentIndex:
        currentIndex,

        type:
        BottomNavigationBarType
            .fixed,

        selectedItemColor:
        Colors.green,

        unselectedItemColor:
        Colors.grey,

        onTap: (index) {
          setState(() {
            currentIndex =
                index;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),

            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(
              Icons.explore,
            ),

            label: 'Explore',
          ),

          BottomNavigationBarItem(
            icon: Icon(
              Icons.receipt_long,
            ),

            label: 'Bookings',
          ),

          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),

            label: 'Profile',
          ),
        ],
      ),
    );
  }
}