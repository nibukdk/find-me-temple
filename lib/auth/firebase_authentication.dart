import 'package:church/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthenticationProvider with ChangeNotifier {
  FirebaseAuthenticationProvider(this._ctx);

  // User?
  UserAuthModel? user;
  UserProfileModel? userProfile;

  // Declare variables
  String _email = "";
  String _password = "";
  // bool _isLoading = false;
  // Context for snack bar
  final BuildContext _ctx;

// Getters
  String get email => _email;
  String get password => _password;
  // bool get isLoading => _isLoading;

// Setters
  set setEmail(String val) {
    _email = val;
  }

  set setPassword(String val) {
    _password = val;
  }

  // set setIsLoading(bool val) {
  //   _isLoading = val;
  // }

// Create a scaffold messanger
  SnackBar msgPopUp(msg) {
    return SnackBar(
        content: Text(
      msg,
      textAlign: TextAlign.center,
    ));
  }

  Future<void> registerUser() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email.trim(),
        password: _password.trim(),
      );
      ScaffoldMessenger.of(_ctx)
          .showSnackBar(msgPopUp("The account has been registered."));
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        ScaffoldMessenger.of(_ctx).showSnackBar(
            msgPopUp("The account already exists for that email"));
      }
    } catch (e) {
      ScaffoldMessenger.of(_ctx).showSnackBar(msgPopUp(e.toString()));
    }
    notifyListeners();
  }

  Future<void> siginUser() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.trim(),
        password: _password.trim(),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // print('No user found for that email.');
        msgPopUp('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        // print('Wrong password provided for that user.');
        msgPopUp('Wrong password provided for that user.');
      }
    }
  }
}

Future<void> logout() async => await FirebaseAuth.instance.signOut();



// try {
//       _isLoading = true;
//       UserCredential userCredential =
//           await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: _email.trim(),
//         password: _password.trim(),
//       );
//     } on FirebaseAuthException catch (e) {
//       if (e.code == "email-already-in-use") {
//         // print("The account already exists for that email");
//         msgPopUp("The account already exists for that email");
//       }
//       _isLoading = false;
//     } catch (e) {
//       msgPopUp(e.toString());
//       _isLoading = false;
//     }