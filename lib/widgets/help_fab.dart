import 'package:flutter/material.dart';

class HelpFab extends StatelessWidget {
  const HelpFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.green,

      elevation: 4,

      child: const Icon(
        Icons.support_agent,
        color: Colors.white,
      ),

      onPressed: () {
        showModalBottomSheet(
          context: context,

          isScrollControlled: true,

          backgroundColor:
          Colors.transparent,

          builder: (_) {
            return Container(
              padding:
              const EdgeInsets.all(24),

              decoration: BoxDecoration(
                color:
                Theme.of(context)
                    .scaffoldBackgroundColor,

                borderRadius:
                const BorderRadius.vertical(
                  top: Radius.circular(32),
                ),
              ),

              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize:
                  MainAxisSize.min,

                  children: [
                    // Handle
                    Container(
                      width: 60,
                      height: 6,

                      decoration: BoxDecoration(
                        color: Colors.grey[400],

                        borderRadius:
                        BorderRadius.circular(
                          20,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Icon
                    Container(
                      padding:
                      const EdgeInsets.all(
                        20,
                      ),

                      decoration: BoxDecoration(
                        color: Colors.green
                            .withValues(
                          alpha: 0.1,
                        ),

                        shape:
                        BoxShape.circle,
                      ),

                      child: const Icon(
                        Icons.support_agent,

                        size: 40,

                        color: Colors.green,
                      ),
                    ),

                    const SizedBox(height: 25),

                    const Text(
                      'Support Center',

                      style: TextStyle(
                        fontSize: 28,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      'Get help and support for your bookings and services.',

                      textAlign:
                      TextAlign.center,

                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 35),

                    supportTile(
                      icon: Icons.chat_bubble,

                      title: 'Live Chat',

                      subtitle:
                      'Chat with support team',

                      onTap: () {
                        Navigator.pop(
                            context);

                        ScaffoldMessenger.of(
                            context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Live chat coming soon',
                            ),
                          ),
                        );
                      },
                    ),

                    supportTile(
                      icon: Icons.email,

                      title:
                      'Email Support',

                      subtitle:
                      'support@gharsaz.pk',
                    ),

                    supportTile(
                      icon: Icons.phone,

                      title:
                      'Call Support',

                      subtitle:
                      '+92 300 1234567',
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget supportTile({
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return Builder(
      builder: (context) {
        return Container(
          margin:
          const EdgeInsets.only(
            bottom: 18,
          ),

          decoration: BoxDecoration(
            color:
            Theme.of(context)
                .cardColor,

            borderRadius:
            BorderRadius.circular(
              22,
            ),
          ),

          child: ListTile(
            leading: Container(
              padding:
              const EdgeInsets.all(
                10,
              ),

              decoration: BoxDecoration(
                color: Colors.green
                    .withValues(
                  alpha: 0.1,
                ),

                borderRadius:
                BorderRadius.circular(
                  14,
                ),
              ),

              child: Icon(
                icon,
                color: Colors.green,
              ),
            ),

            title: Text(
              title,

              style: const TextStyle(
                fontWeight:
                FontWeight.w600,
              ),
            ),

            subtitle: Text(
              subtitle,
            ),

            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 18,
            ),

            onTap: onTap,
          ),
        );
      },
    );
  }
}