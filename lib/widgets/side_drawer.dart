import 'package:flutter/material.dart';

import 'bottom_nav_bar.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness ==
            Brightness.dark;

    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,

            padding:
            const EdgeInsets.only(
              top: 70,
              left: 24,
              right: 24,
              bottom: 30,
            ),

            decoration:
            const BoxDecoration(
              gradient:
              LinearGradient(
                colors: [
                  Color(0xFF166534),
                  Color(0xFF22C55E),
                ],

                begin:
                Alignment.topLeft,

                end: Alignment
                    .bottomRight,
              ),
            ),

            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment
                  .start,

              children: [
                Container(
                  padding:
                  const EdgeInsets.all(
                    18,
                  ),

                  decoration:
                  const BoxDecoration(
                    color: Colors.white,

                    shape:
                    BoxShape.circle,
                  ),

                  child: const Icon(
                    Icons.work,

                    color:
                    Colors.green,

                    size: 38,
                  ),
                ),

                const SizedBox(
                  height: 24,
                ),

                const Text(
                  'GharSaz',

                  style: TextStyle(
                    color:
                    Colors.white,

                    fontSize: 38,

                    fontWeight:
                    FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),

                const Text(
                  'Premium Home Services',

                  style: TextStyle(
                    color:
                    Colors.white70,

                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Container(
              color: isDark
                  ? const Color(
                0xff0B0F19,
              )
                  : Colors.white,

              child: ListView(
                padding:
                const EdgeInsets.only(
                  top: 20,
                ),

                children: [
                  drawerTile(
                    context,
                    Icons.home,
                    'Home',
                    0,
                    isDark,
                  ),

                  drawerTile(
                    context,
                    Icons.explore,
                    'Explore',
                    1,
                    isDark,
                  ),

                  drawerTile(
                    context,
                    Icons.receipt_long,
                    'My Bookings',
                    2,
                    isDark,
                  ),

                  drawerTile(
                    context,
                    Icons.person,
                    'Profile',
                    3,
                    isDark,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget drawerTile(
      BuildContext context,
      IconData icon,
      String title,
      int index,
      bool isDark,
      ) {
    return ListTile(
      leading: Icon(
        icon,

        color: isDark
            ? Colors.white
            : Colors.black87,

        size: 28,
      ),

      title: Text(
        title,

        style: TextStyle(
          color: isDark
              ? Colors.white
              : Colors.black,

          fontSize: 20,

          fontWeight:
          FontWeight.w600,
        ),
      ),

      trailing: Icon(
        Icons.arrow_forward_ios,

        color: isDark
            ? Colors.white70
            : Colors.black54,

        size: 18,
      ),

      onTap: () {
        Navigator.pushReplacement(
          context,

          MaterialPageRoute(
            builder: (_) =>
                BottomNavBar(
                  initialIndex:
                  index,
                ),
          ),
        );
      },
    );
  }
}