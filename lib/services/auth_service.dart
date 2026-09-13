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
      phoneNumber: phoneNumber,

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