import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum AUTH_STATE { loggedIn, loggedOut, verifyEmail }

extension AuthStateExtension on AUTH_STATE {
  String get appState {
    switch (this) {
      case AUTH_STATE.loggedIn:
        return 'loggedIn';

      case AUTH_STATE.verifyEmail:
        return 'verifyEmail';

      default:
        return 'loggedOut';
    }
  }
}

class AuthStateProvider with ChangeNotifier {
  AuthStateProvider() {
    init();
  }

  Future<void> init() async {
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        print("User is logged IN");
        _appState = AUTH_STATE.loggedIn;
        print("AUTH STATE IS $_appState");
      } else {
        print("User is logged out");

        _appState = AUTH_STATE.loggedOut;
        print("AUTH STATE IS $_appState");
      }
    });

    notifyListeners();
  }

  AUTH_STATE _appState = AUTH_STATE.loggedOut;

  AUTH_STATE get appState => _appState;

  String? _email;
  String? get email => _email;

  Future<bool> signInWithEmailAndPassword(
    String email,
    String password,
    void Function(FirebaseAuthException e) errorCallback,
  ) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _appState = AUTH_STATE.loggedIn;
      notifyListeners();

      return true;
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
      return false;
    } catch (e) {
      notifyListeners();

      return false;
    }
  }

  Future<bool> registerAccount(String email, String userName, String password,
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user!.updateDisplayName(userName);
      _appState = AUTH_STATE.loggedIn;
      notifyListeners();

      return true;
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
      notifyListeners();

      return false;
    }
  }

  void signOut() async {
    FirebaseAuth.instance.signOut();
    _appState = AUTH_STATE.loggedOut;
    notifyListeners();
  }
}
