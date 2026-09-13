import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth auth =
      FirebaseAuth.instance;

  Future<void> verifyPhoneNumber({
    required String phoneNumber,

    required Function(
        String verificationId,
        )
    codeSent,

    required Function(String error)
    onError,
  }) async {
    await auth.verifyPhoneNumber(
      phoneNumber: AuthService.toE164(phoneNumber),

      verificationCompleted:
          (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(
          credential,
        );
      },

      verificationFailed:
          (FirebaseAuthException e) {
        onError(
          e.message ?? 'Verification failed',
        );
      },

      codeSent: (
          String verificationId,
          int? resendToken,
          ) {
        codeSent(verificationId);
      },

      codeAutoRetrievalTimeout:
          (String verificationId) {},
    );
  }

  /// Firebase Phone Auth requires E.164 (e.g. +923001234567). Users type
  /// local Pakistani numbers like 03001234567, so convert those here.
  static String toE164(String phoneNumber) {
    final digits = phoneNumber.trim();

    if (digits.startsWith('+')) return digits;

    if (digits.startsWith('0')) {
      return '+92${digits.substring(1)}';
    }

    return '+92$digits';
  }

  Future<bool> signInWithOTP({
    required String verificationId,

    required String smsCode,
  }) async {
    try {
      final credential =
      PhoneAuthProvider.credential(
        verificationId: verificationId,

        smsCode: smsCode,
      );

      await auth.signInWithCredential(
        credential,
      );

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> logout() async {
    await auth.signOut();
  }
}