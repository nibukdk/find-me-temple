import 'package:church/models/user.dart';
import 'package:church/screens/auth/auth_utils.dart';
import 'package:church/utils/router/router_utlis.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthStateProvider extends ChangeNotifier {
  FirebaseAuth authInstance = FirebaseAuth.instance;
  // AuthState _authState = AuthState.loggedOut;
  ViewState _viewState = ViewState.idle;

  UserModel? _user;
  String? _email;
  String? _password;
  String? _username;

  UserModel get user => _user as UserModel;
  // AuthState get authState => _authState;
  ViewState get viewState => _viewState;

  get email => _email;
  get password => _password;
  get username => _username;

  // setAuthState(AuthState authState) {
  //   _authState = authState;
  //   notifyListeners();
  // }

  void setViewState(ViewState viewState) {
    _viewState = viewState;
    notifyListeners();
  }

  // Create a scaffold messanger
  SnackBar msgPopUp(msg) {
    return SnackBar(
        content: Text(
      msg,
      textAlign: TextAlign.center,
    ));
  }

  AlertDialog errorDialog(BuildContext context, String errMsg) {
    return AlertDialog(
      title: const Text("Error"),
      content: Text(errMsg),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }

  void register(String email, String password, String username,
      BuildContext context) async {
    setViewState(ViewState.busy);
    try {
      UserCredential userCred = await authInstance
          .createUserWithEmailAndPassword(email: email, password: password);
      await userCred.user!.updateDisplayName(username);
      _email = email;
      _username = username;
      _password = password;
      ScaffoldMessenger.of(context)
          .showSnackBar(msgPopUp("The account has been registered."));
      GoRouter.of(context).goNamed(APP_PAGE.home.routeName);
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        showDialog(
            context: context,
            builder: (context) => errorDialog(
                context, "The account with this email already exists."));
      }
      if (e.code == 'weak-password') {
        showDialog(
            context: context,
            builder: (context) =>
                errorDialog(context, "Password is too weak."));
      }
      setViewState(ViewState.idle);
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) =>
              errorDialog(context, "Something went wrong please try again."));

      setViewState(ViewState.idle);
    }

    notifyListeners();
  }

  void login(String email, String password, BuildContext context) async {
    setViewState(ViewState.busy);
    try {
      UserCredential userCred = await authInstance.signInWithEmailAndPassword(
          email: email, password: password);

      _username = userCred.user!.displayName;
      _email = email;

      ScaffoldMessenger.of(context).showSnackBar(msgPopUp("Welcome Back"));
      GoRouter.of(context).goNamed(APP_PAGE.home.routeName);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showDialog(
            context: context,
            builder: (context) =>
                errorDialog(context, "No user found for that email."));
      }
      if (e.code == 'wrong-password') {
        showDialog(
            context: context,
            builder: (context) => errorDialog(context, "Wrong password."));
      }
      setViewState(ViewState.idle);
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) =>
              errorDialog(context, "Something went wrong please try again"));
      setViewState(ViewState.idle);
    }

    notifyListeners();
  }

  void logOut() async {
    setViewState(ViewState.busy);
    await authInstance.signOut();
    setViewState(ViewState.idle);
  }
}
