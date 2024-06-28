import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stack_overflow/_util/api_response.dart';
import 'package:stack_overflow/_util/extensions.dart';

abstract class PhoneAuthRepo {
  Future<Either<Failure, String>> verifyPhoneNumber(
      {required String phoneNumber});

  Future<Either<Failure, String>> signInWithSmsCode({
    required String verificationCode,
    required String smsCode,
  });
}

class PhoneAuthRepoImpl implements PhoneAuthRepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final completer = Completer<Either<Failure, String>>();

  @override
  Future<Either<Failure, String>> verifyPhoneNumber(
      {required String phoneNumber}) async {
    "===== Phone Auth 1 ====>".logIt;
    try {
      await firebaseAuth.verifyPhoneNumber(

        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 20),
        verificationCompleted: (credentials) =>
            _verificationCompleted(credentials),
        verificationFailed: (authException) =>
            _verificationFailed(authException),
        codeSent: (verificationCode, token) =>
            _smsCodeSent(verificationCode, token),
        codeAutoRetrievalTimeout: (verificationId) =>
            _codeAutoRetrievalTimeout(verificationId),
      );
      final result = completer.future;
      return result;
    } on FirebaseAuthException catch (e) {
      return left(
        Failure(
          response: e.message ?? "Some error occurred. Please try again!",
        ),
      );
    } catch (e) {
      return left(
        Failure(
          response: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, String>> signInWithSmsCode(
      {required String verificationCode, required String smsCode}) async {
    "===>Verification Code: $verificationCode".length;
    final AuthCredential authCredential = PhoneAuthProvider.credential(
      verificationId: verificationCode,
      smsCode: smsCode,
    );

    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(authCredential);
    final userID = await userCredential.user!.uid;
    return right(userID);
  }

  void _verificationCompleted(AuthCredential authCredential) {
    "Firebase Auth Verification COmpleted: ${authCredential.accessToken}".logIt;
  }

  void _smsCodeSent(String verificationCode, int? token) {
    "Firebase Authentication SMS Code sent successfully".logIt;
    "====> VerificationID: $verificationCode, Token: $token".logIt;
    completer.complete(right(verificationCode));
  }

  String _verificationFailed(FirebaseAuthException authException) {
    "verification failed: ${authException.code} Message:${authException.message}"
        .logIt;

    completer.complete(
      left(
        Failure(
          response: authException.message == "invalid-phone-number"
              ? "Please enter valid phoneNumber"
              : authException.message ??
                  "Some error occurred. Please try again!",
        ),
      ),
    );

    return authException.message ?? "Error occurred. Please try again!";
  }

  void _codeAutoRetrievalTimeout(String verificationCode) {
    "========>>>>VerificationCode: $verificationCode}".logIt;
    if (!completer.isCompleted) completer.complete(right(verificationCode));
  }
}
