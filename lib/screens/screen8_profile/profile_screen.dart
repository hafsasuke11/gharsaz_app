import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../providers/theme_provider.dart';

import '../../services/auth_service.dart';

import '../../widgets/side_drawer.dart';

import '../screen1_name_phone/name_phone_screen.dart';

class ProfileScreen
    extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authProvider =
    context.watch<AuthProvider>();

    final themeProvider =
    context.watch<ThemeProvider>();

    final isDark =
        Theme.of(context).brightness ==
            Brightness.dark;

    return Scaffold(
      drawer: const SideDrawer(),

      appBar: AppBar(
        title: Text(
          'Profile',

          style: TextStyle(
            color: isDark
                ? Colors.white
                : Colors.black,
          ),
        ),

        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding:
        const EdgeInsets.all(
          20,
        ),

        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),

            CircleAvatar(
              radius: 50,

              backgroundColor:
              Colors.green,

              child: Text(
                authProvider
                    .userName
                    .isNotEmpty
                    ? authProvider
                    .userName[0]
                    .toUpperCase()
                    : 'G',

                style:
                const TextStyle(
                  fontSize: 38,

                  color:
                  Colors.white,

                  fontWeight:
                  FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(
              height: 18,
            ),

            Text(
              authProvider.userName,

              style: TextStyle(
                fontSize: 28,

                fontWeight:
                FontWeight.bold,

                color: isDark
                    ? Colors.white
                    : Colors.black,
              ),
            ),

            const SizedBox(
              height: 8,
            ),

            Text(
              authProvider.phoneNumber,

              style: TextStyle(
                color: isDark
                    ? Colors.white70
                    : Colors.grey,

                fontSize: 16,
              ),
            ),

            const SizedBox(
              height: 40,
            ),

            profileTile(
              context,
              Icons.dark_mode,
              'Dark Mode',

              trailing: Switch(
                value:
                themeProvider
                    .isDarkMode,

                onChanged: (
                    value,
                    ) {
                  themeProvider
                      .toggleTheme();
                },
              ),

              isDark: isDark,
            ),

            profileTile(
              context,
              Icons.notifications,
              'Notifications',

              isDark: isDark,

              onTap: () {
                showDialog(
                  context: context,

                  builder: (_) {
                    return AlertDialog(
                      title: const Text(
                        'Notifications',
                      ),

                      content:
                      const Text(
                        'Notification system coming soon',
                      ),

                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(
                              context,
                            );
                          },

                          child:
                          const Text(
                            'OK',
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),

            profileTile(
              context,
              Icons.language,
              'Language',

              isDark: isDark,

              onTap: () {
                showDialog(
                  context: context,

                  builder: (_) {
                    return AlertDialog(
                      title: const Text(
                        'Language',
                      ),

                      content:
                      const Text(
                        'Multi-language support coming soon',
                      ),

                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(
                              context,
                            );
                          },

                          child:
                          const Text(
                            'OK',
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),

            profileTile(
              context,
              Icons.privacy_tip,
              'Privacy Policy',

              isDark: isDark,

              onTap: () {
                showDialog(
                  context: context,

                  builder: (_) {
                    return AlertDialog(
                      title: const Text(
                        'Privacy Policy',
                      ),

                      content:
                      const Text(
                        'GharSaz protects your personal information and booking data.',
                      ),

                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(
                              context,
                            );
                          },

                          child:
                          const Text(
                            'OK',
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),

            profileTile(
              context,
              Icons.info,
              'About App',

              isDark: isDark,

              onTap: () {
                showAboutDialog(
                  context: context,

                  applicationName:
                  'GharSaz',

                  applicationVersion:
                  '1.0.0',

                  applicationLegalese:
                  'Professional Home Services App',
                );
              },
            ),

            profileTile(
              context,
              Icons.support_agent,
              'Support',

              isDark: isDark,

              onTap: () {
                showDialog(
                  context: context,

                  builder: (_) {
                    return AlertDialog(
                      title:
                      const Text(
                        'Support',
                      ),

                      content:
                      const Text(
                        'Need help?\n\nEmail: support@gharsaz.pk',
                      ),

                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(
                              context,
                            );
                          },

                          child:
                          const Text(
                            'OK',
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),

            const SizedBox(
              height: 25,
            ),

            SizedBox(
              width: double.infinity,

              child:
              ElevatedButton(
                onPressed:
                    () async {
                  await AuthService()
                      .logout();

                  authProvider
                      .logout();

                  if (!context
                      .mounted) {
                    return;
                  }

                  Navigator.pushAndRemoveUntil(
                    context,

                    MaterialPageRoute(
                      builder:
                          (_) =>
                      const NamePhoneScreen(),
                    ),

                        (route) =>
                    false,
                  );
                },

                style:
                ElevatedButton.styleFrom(
                  backgroundColor:
                  Colors.red,

                  padding:
                  const EdgeInsets.symmetric(
                    vertical: 16,
                  ),

                  shape:
                  RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(
                      18,
                    ),
                  ),
                ),

                child: const Text(
                  'Logout',

                  style: TextStyle(
                    color:
                    Colors.black,

                    fontWeight:
                    FontWeight.bold,

                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget profileTile(
      BuildContext context,
      IconData icon,
      String title, {
        Widget? trailing,
        VoidCallback? onTap,
        required bool isDark,
      }) {
    return Container(
      margin:
      const EdgeInsets.only(
        bottom: 18,
      ),

      decoration:
      BoxDecoration(
        color: isDark
            ? const Color(
          0xff161B22,
        )
            : Theme.of(context)
            .cardColor,

        borderRadius:
        BorderRadius.circular(
          22,
        ),
      ),

      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.green,
        ),

        title: Text(
          title,

          style: TextStyle(
            fontWeight:
            FontWeight.w600,

            color: isDark
                ? Colors.white
                : Colors.black,
          ),
        ),

        trailing:
        trailing ??
            Icon(
              Icons
                  .arrow_forward_ios,

              size: 18,

              color: isDark
                  ? Colors.white70
                  : Colors.black54,
            ),

        onTap: onTap,
      ),
    );
  }
}