import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

import '../../services/auth_service.dart';

import '../otp_screen.dart';

class NamePhoneScreen extends StatefulWidget {
  const NamePhoneScreen({super.key});

  @override
  State<NamePhoneScreen> createState() =>
      _NamePhoneScreenState();
}

class _NamePhoneScreenState
    extends State<NamePhoneScreen> {
  final nameController =
  TextEditingController();

  final phoneController =
  TextEditingController();

  bool isLoading = false;

  final AuthService authService =
  AuthService();

  Future<void> sendOTP() async {
    if (nameController.text.isEmpty ||
        phoneController.text.isEmpty) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    context.read<AuthProvider>().setUser(
      nameController.text,
      phoneController.text,
    );

    await authService.verifyPhoneNumber(
      phoneNumber: phoneController.text,

      codeSent: (verificationId) {
        setState(() {
          isLoading = false;
        });

        Navigator.push(
          context,

          MaterialPageRoute(
            builder: (_) => OtpScreen(
              verificationId:
              verificationId,
            ),
          ),
        );
      },

      onError: (error) {
        setState(() {
          isLoading = false;
        });

        ScaffoldMessenger.of(context)
            .showSnackBar(
          SnackBar(
            content: Text(error),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [
            const SizedBox(height: 80),

            const Text(
              'Welcome to GharSaz 👋',

              style: TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Pakistan’s trusted home services app.',

              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 60),

            TextField(
              controller: nameController,

              decoration: const InputDecoration(
                hintText: 'Enter your name',

                prefixIcon:
                Icon(Icons.person_outline),
              ),
            ),

            const SizedBox(height: 25),

            TextField(
              controller: phoneController,

              keyboardType:
              TextInputType.phone,

              decoration: const InputDecoration(
                hintText:
                'Enter phone number',

                prefixIcon:
                Icon(Icons.phone_outlined),
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed:
                isLoading ? null : sendOTP,

                child: isLoading
                    ? const CircularProgressIndicator(
                  color: Colors.white,
                )
                    : const Text(
                  'Continue',
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}