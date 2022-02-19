import 'dart:async';
import 'package:church/auth/auth_state_provider.dart';
import 'package:church/provider/app_state_provider.dart';
import 'package:flutter/material.dart';

import 'package:church/auth/auth_input_widget.dart';
import 'package:church/auth/auth_utils.dart';
import 'package:church/auth/auth_validator.dart';
import 'package:provider/provider.dart';

class AuthFormWidget extends StatefulWidget {
  late Function register;
  late Function signIn;
  VoidCallback signOut;

  AuthFormWidget(
      {required this.register,
      required this.signIn,
      required this.signOut,
      Key? key})
      : super(key: key);

  @override
  _AuthFormWidgetState createState() => _AuthFormWidgetState();
}

class _AuthFormWidgetState extends State<AuthFormWidget> {
  // Instantiate validator
  final AuthValidators authValidator = AuthValidators();

  // Define Form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // controllers
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

// create focus nodes
  late FocusNode emailFocusNode;
  late FocusNode usernameFocusNode;
  late FocusNode passwordFocusNode;
  late FocusNode confirmPasswordFocusNode;

  bool obscureText = true;
  bool registerAuthMode = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    emailFocusNode = FocusNode();
    usernameFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    confirmPasswordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();

    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
  }

  void toggleObscureText() {
    setState(() {
      obscureText = !obscureText;
    });
  }

// Create a scaffold messanger
  SnackBar msgPopUp(msg) {
    return SnackBar(
        content: Text(
      msg,
      textAlign: TextAlign.center,
    ));
  }

  registerErrorCallback(e) {
    if (e.code == "email-already-in-use") {
      ScaffoldMessenger.of(context)
          .showSnackBar(msgPopUp("The account already exists for that email"));
    }
    setState(() => _isLoading = false);
  }

  signInErrorCallback(e) {
    if (e.code == 'user-not-found') {
      ScaffoldMessenger.of(context)
          .showSnackBar(msgPopUp('No user found for that email.'));
    }
    if (e.code == 'wrong-password') {
      ScaffoldMessenger.of(context).showSnackBar(msgPopUp('Wrong password.'));
    }
  }

  Future<void> _submitForm(BuildContext context, AuthStateProvider authState,
      AppStateProvider appState) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final username = usernameController.text.trim();

    bool isFormValid = _formKey.currentState!.validate();
    setState(() => _isLoading = false);
    if (isFormValid) {
      _formKey.currentState!.save();

      if (registerAuthMode) {
        await authState.registerAccount(
            email, username, password, registerErrorCallback);
      } else {
        await authState.signInWithEmailAndPassword(
            email, password, signInErrorCallback);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authStateProvider = Provider.of<AuthStateProvider>(context);
    final appStateProvider = Provider.of<AppStateProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // Email
            TextFormFieldWidget(
              controller: emailController,
              obscureText: false,
              focusNode: emailFocusNode,
              toggleObscureText: null,
              validator: authValidator.emailValidator,
              prefIcon: const Icon(Icons.mail),
              labelText: "Enter Email Address",
              textInputAction: TextInputAction.next,
              isEmailTextField: true,
            ),
            const SizedBox(
              height: 20,
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              height: registerAuthMode ? 65 : 0,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: registerAuthMode ? 1 : 0,
                child: TextFormFieldWidget(
                  controller: usernameController,
                  obscureText: false,
                  focusNode: usernameFocusNode,
                  toggleObscureText: null,
                  validator: null,
                  prefIcon: const Icon(Icons.person),
                  labelText: "Enter Username(Optional)",
                  textInputAction: TextInputAction.next,
                  isEmailTextField: true,
                ),
              ),
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: registerAuthMode ? 1 : 0,
              child: const SizedBox(
                height: 20,
              ),
            ),
            TextFormFieldWidget(
              controller: passwordController,
              labelText: "Enter Password",
              obscureText: obscureText,
              focusNode: passwordFocusNode,
              toggleObscureText: toggleObscureText,
              validator: authValidator.passwordVlidator,
              prefIcon: const Icon(Icons.password),
              textInputAction: TextInputAction.done,
              isEmailTextField: false,
            ),

            const SizedBox(
              height: 20,
            ),

            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              height: registerAuthMode ? 80 : 0,
              child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: registerAuthMode ? 1 : 0,
                  child: TextFormFieldWidget(
                    controller: confirmPasswordController,
                    focusNode: confirmPasswordFocusNode,
                    isEmailTextField: false,
                    labelText: "Confirm Password",
                    obscureText: obscureText,
                    prefIcon: const Icon(Icons.password),
                    textInputAction: TextInputAction.done,
                    toggleObscureText: toggleObscureText,
                    validator: (val) => authValidator.confirmPasswordValidator(
                        val, passwordController.text),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            AnimatedOpacity(
              opacity: registerAuthMode ? 1 : 0,
              duration: const Duration(milliseconds: 500),
              child: const SizedBox(
                height: 20,
              ),
            ),
            if (_isLoading) const CircularProgressIndicator(),
            if (!_isLoading)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () => _submitForm(
                        context, authStateProvider, appStateProvider),
                    child: Text(registerAuthMode ? 'Register' : 'Sign In'),
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(8.0),
                    ),
                  ),
                ],
              ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(registerAuthMode
                    ? AuthMode.register.titleText
                    : AuthMode.signin.titleText),
                TextButton(
                  onPressed: () =>
                      setState(() => registerAuthMode = !registerAuthMode),
                  child: Text(registerAuthMode
                      ? AuthMode.register.linkText
                      : AuthMode.signin.linkText),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
