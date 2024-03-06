import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';



class MyBottomNavBar extends StatefulWidget {
  void Function(int)? onTabChange;
  MyBottomNavBar({
    super.key,
    required this.onTabChange,
  });

  @override
  State<MyBottomNavBar> createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: GNav(
        color: Colors.grey[400],
        activeColor: Colors.grey.shade700,
        tabActiveBorder: Border.all(color: Colors.white),
        tabBackgroundColor: Colors.grey.shade100,
        mainAxisAlignment: MainAxisAlignment.center,
        tabBorderRadius: 16,
        gap: 8,
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width >= 600 ? 75 : 26,
          vertical: 10,
        ),
        onTabChange: (value) => widget.onTabChange!(value),
        tabs: const [
          GButton(
            icon: Icons.home_rounded,
            text: 'Home',
          ),
          GButton(
            icon: Icons.bloodtype_rounded,
            text: 'Status',
          ),
          GButton(
            icon: Icons.mark_as_unread_rounded,
            text: 'Messages',
          ),
          GButton(
            icon: Icons.person_rounded,
            text: 'Profile',
          ),
        ],
      ),
    );
  }
}
