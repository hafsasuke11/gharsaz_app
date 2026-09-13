import 'package:flutter/material.dart';

import '../services/auth_service.dart';

import '../widgets/bottom_nav_bar.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;

  const OtpScreen({
    super.key,
    required this.verificationId,
  });

  @override
  State<OtpScreen> createState() =>
      _OtpScreenState();
}

class _OtpScreenState
    extends State<OtpScreen> {
  final otpController =
  TextEditingController();

  bool isLoading = false;

  final AuthService authService =
  AuthService();

  Future<void> verifyOTP() async {
    setState(() {
      isLoading = true;
    });

    final success =
    await authService.signInWithOTP(
      verificationId:
      widget.verificationId,

      smsCode: otpController.text,
    );

    setState(() {
      isLoading = false;
    });

    if (!mounted) return;

    if (success) {
      Navigator.pushAndRemoveUntil(
        context,

        MaterialPageRoute(
          builder: (_) =>
          const BottomNavBar(),
        ),

            (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text('Invalid OTP'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Verify OTP',
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const SizedBox(height: 50),

            const Text(
              'Enter OTP',

              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              'We sent a verification code to your phone.',
            ),

            const SizedBox(height: 40),

            TextField(
              controller: otpController,

              keyboardType:
              TextInputType.number,

              decoration:
              const InputDecoration(
                hintText: 'Enter OTP',
              ),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed:
                isLoading
                    ? null
                    : verifyOTP,

                child: isLoading
                    ? const CircularProgressIndicator(
                  color: Colors.white,
                )
                    : const Text(
                  'Verify OTP',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}