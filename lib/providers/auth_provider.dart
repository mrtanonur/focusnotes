import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:focusnotes/models/user_model.dart';
import 'package:focusnotes/services/auth_service.dart';
import 'package:focusnotes/services/firestore_service.dart';

enum AuthStatus {
  initial,
  signIn,
  verificationProcess,
  unVerified,
  resetPassword,
  signOut,
  failure,
}

class AuthProvider extends ChangeNotifier {
  AuthStatus status = AuthStatus.initial;
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();
  String? error;
  UserModel? userData;

  Future<bool> authCheck() async {
    final response = await _authService.authCheck();
    return response;
  }

  Future signUp(String email, String password) async {
    final response = await _authService.signUp(email, password);
    response.fold(
      (String errorMessage) {
        error = errorMessage;
        status = AuthStatus.failure;
      },
      (UserCredential userCredential) async {
        final User user = userCredential.user!;
        final UserModel userModel = UserModel(
          id: user.uid,
          email: user.email!,
          fullName: user.displayName,
          signInMethod: userCredential.credential?.signInMethod,
        );
        userData = userModel;
        status = AuthStatus.verificationProcess;
      },
    );
    notifyListeners();
  }

  Future sendEmailVerification() async {
    final response = await _authService.sendVerificationLink();
    response.fold(
      (String errorMessage) {
        error = errorMessage;
        status = AuthStatus.failure;
      },
      (_) {
        status = AuthStatus.verificationProcess;
      },
    );
    notifyListeners();
  }

  Future storeUserData() async {
    final response = await _firestoreService.storeUserData(userData!);
    response.fold((String errorMessage) {
      error = errorMessage;
      status = AuthStatus.failure;
      notifyListeners();
    }, (_) {});
  }

  Future getUserData() async {
    final response = await _firestoreService.getUserData();
    response.fold(
      (String errorMessage) {
        error = errorMessage;
        status = AuthStatus.failure;
        notifyListeners();
      },
      (UserModel userModel) {
        userData = userModel;
      },
    );
  }

  Future signIn(String email, String password) async {
    final response = await _authService.signIn(email, password);
    response.fold(
      (String errorMessage) {
        error = errorMessage;
        status = AuthStatus.failure;
      },
      (User? user) {
        if (user != null) {
          if (user.emailVerified) {
            status = AuthStatus.signIn;
          } else {
            status = AuthStatus.unVerified;
          }
        } else {
          status = AuthStatus.failure;
        }
      },
    );
    notifyListeners();
  }

  Future googleSignIn() async {
    final response = await _authService.googleSignIn();
    response.fold(
      (String errorMessage) {
        error = errorMessage;
        status = AuthStatus.failure;
      },
      (_) {
        status = AuthStatus.signIn;
      },
    );
  }

  // apple sign in
  Future appleSignIn() async {
    final response = await _authService.appleSignIn();
    response.fold(
      (String errorMessage) {
        error = errorMessage;
        status = AuthStatus.failure;
      },
      (User? user) {
        status = AuthStatus.signIn;
      },
    );
    notifyListeners();
  }

  Future sendPasswordResetLink(String email) async {
    final response = await _authService.sendPasswordResetLink(email);
    response.fold(
      (errorMessage) {
        error = errorMessage;
        status = AuthStatus.failure;
      },
      (_) {
        status = AuthStatus.resetPassword;
      },
    );
    notifyListeners();
  }

  Future signOut() async {
    final response = await _authService.signOut();
    response.fold(
      (errorMessage) {
        error = errorMessage;
        status = AuthStatus.failure;
      },
      (_) {
        status = AuthStatus.signOut;
      },
    );
    notifyListeners();
  }
}
