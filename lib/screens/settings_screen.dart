import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),

        children: [
          settingsTile(
            icon: Icons.notifications_outlined,
            title: 'Notifications',
          ),

          settingsTile(
            icon: Icons.language_outlined,
            title: 'Language',
          ),

          settingsTile(
            icon: Icons.lock_outline,
            title: 'Privacy Policy',
          ),

          settingsTile(
            icon: Icons.info_outline,
            title: 'About GharSaz',
          ),
        ],
      ),
    );
  }

  Widget settingsTile({
    required IconData icon,
    required String title,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(24),
      ),

      child: ListTile(
        leading: Icon(icon),

        title: Text(title),

        trailing:
        const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}