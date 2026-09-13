import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_auth/firebase_auth.dart'
    hide AuthProvider;

import 'package:provider/provider.dart';

import 'firebase_options.dart';

import 'config/app_theme.dart';

import 'providers/auth_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/services_provider.dart';
import 'providers/professionals_provider.dart';
import 'providers/booking_provider.dart';

import 'widgets/bottom_nav_bar.dart';

import 'screens/screen1_name_phone/name_phone_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options:
    DefaultFirebaseOptions
        .currentPlatform,
  );

  runApp(
    const GharSazApp(),
  );
}

class GharSazApp
    extends StatelessWidget {
  const GharSazApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create:
              (_) =>
              AuthProvider(),
        ),

        ChangeNotifierProvider(
          create:
              (_) =>
              ThemeProvider(),
        ),

        ChangeNotifierProvider(
          create:
              (_) =>
          ServicesProvider()
            ..fetchServices(),
        ),

        ChangeNotifierProvider(
          create:
              (_) =>
          ProfessionalsProvider()
            ..fetchProfessionals(),
        ),

        ChangeNotifierProvider(
          create:
              (_) =>
              BookingProvider(),
        ),
      ],

      child:
      Consumer<ThemeProvider>(
        builder: (
            context,
            themeProvider,
            child,
            ) {
          return MaterialApp(
            debugShowCheckedModeBanner:
            false,

            title: 'GharSaz',

            theme:
            AppTheme.lightTheme,

            darkTheme:
            AppTheme.darkTheme,

            themeMode:
            themeProvider
                .isDarkMode
                ? ThemeMode.dark
                : ThemeMode.light,

            home:
            FirebaseAuth
                .instance
                .currentUser !=
                null
                ? const BottomNavBar()
                : const NamePhoneScreen(),
          );
        },
      ),
    );
  }
}