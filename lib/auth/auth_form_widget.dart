import 'package:church/auth/auth_input_widget.dart';
import 'package:flutter/material.dart';

enum AuthMode { signin, register }

extension AuthModeExtension on AuthMode {
  String get titleText {
    switch (this) {
      case AuthMode.register:
        return "Already Have an account?";

      case AuthMode.signin:
        return "Don't have an account yet?";
      default:
        return "Don't have an account yet?";
    }
  }

  String get linkText {
    switch (this) {
      case AuthMode.register:
        return "Sign In";
      case AuthMode.signin:
        return "Register";
      default:
        return "Register";
    }
  }
}

class AuthFormWidget extends StatefulWidget {
  const AuthFormWidget({Key? key}) : super(key: key);

  @override
  _AuthFormWidgetState createState() => _AuthFormWidgetState();
}

class _AuthFormWidgetState extends State<AuthFormWidget> {
  // Define Form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

// create focus nodes
  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;
  late FocusNode confirmPasswordFocusNode;

  bool obscureText = true;

  bool registerAuthMode = true;

  // bool _isEmailValid = false;
  // bool _isPasswordValid = false;

  static const String emailErrMsg =
      "Invlid Email Address, Please provide a valid email.";
  static const String passwordErrMsg =
      "Password must have atleast 6 characters.";
  static const String confirmPasswordErrMsg = "Two passwords don't match.";

  @override
  void initState() {
    super.initState();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    confirmPasswordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();

    emailController.dispose();
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

  // A simple email validator that  checks presence and position of @
  String? emailValidator(String? val) {
    final String email = val as String;

    // If length of email is <=3 then its invlaid
    if (email.length <= 3) return emailErrMsg;

    // Validation related to @
    final hasAtSymbol = email.contains('@');
    final indexOfAt = email.indexOf('@');
    // Check number of @
    final numberOfAt = "@".allMatches(email).length;

    // Valid if has @
    // also @ is not first or last character
    // also if number of @ is only 1

    if (!hasAtSymbol) return emailErrMsg;
    if (numberOfAt != 1) return emailErrMsg;
    if (indexOfAt == email.length - 1 || indexOfAt == 0) return emailErrMsg;

    return null;
  }

  String? passwordVlidator(String? val) {
    final String password = val as String;

    if (password.isEmpty || password.length <= 5) return passwordErrMsg;

    return null;
  }

  String? confirmPasswordValidator(String? val) {
    final String firstPassword = passwordController.text;
    final String secondPassword = val as String;
    if (firstPassword.isEmpty ||
        secondPassword.isEmpty ||
        firstPassword.length != secondPassword.length) {
      return confirmPasswordErrMsg;
    }

    if (firstPassword != secondPassword) return confirmPasswordErrMsg;

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormFieldWidget(
              controller: emailController,
              obscureText: obscureText,
              focusNode: emailFocusNode,
              toggleObscureText: toggleObscureText,
              validator: emailValidator,
              prefIcon: Icon(Icons.mail),
              labelText: "Enter Email Address",
              textInputAction: TextInputAction.next,
              isEmailTextField: true,
            ),
            const SizedBox(
              height: 20,
            ),
            // Exp
            TextFormFieldWidget(
              controller: passwordController,
              labelText: "Enter Email Address",
              obscureText: obscureText,
              focusNode: passwordFocusNode,
              toggleObscureText: toggleObscureText,
              validator: passwordVlidator,
              prefIcon: Icon(Icons.password),
              textInputAction: TextInputAction.done,
              isEmailTextField: false,
            ),

            const SizedBox(
              height: 20,
            ),

            const SizedBox(
              height: 20,
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              height: registerAuthMode ? 60 : 0,
              child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: registerAuthMode ? 1 : 0,
                  child: TextFormFieldWidget(
                    controller: confirmPasswordController,
                    focusNode: confirmPasswordFocusNode,
                    isEmailTextField: false,
                    labelText: "Confirm Password",
                    obscureText: obscureText,
                    prefIcon: Icon(Icons.password),
                    textInputAction: TextInputAction.done,
                    toggleObscureText: toggleObscureText,
                    validator: confirmPasswordValidator,
                  )),
            ),
            AnimatedOpacity(
              opacity: registerAuthMode ? 1 : 0,
              duration: const Duration(milliseconds: 500),
              child: const SizedBox(
                height: 20,
              ),
            ),
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
                  onPressed: () {
                    _formKey.currentState!.validate();
                  },
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


//  TextFormField(
//               controller: emailController,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                 ),
//                 label: Text("Enter Email Address"),
//                 prefixIcon: Icon(Icons.mail),
//               ),
//               focusNode: emailFocusNode,
//               textInputAction: TextInputAction.next,
//               validator: emailValidator,
//               // onSaved: emailValidator,
//             ),

   //
            // TextFormField(
            //   controller: passwordController,
            //   decoration: InputDecoration(
            //     border: const OutlineInputBorder(
            //       borderRadius: BorderRadius.all(Radius.circular(10.0)),
            //     ),
            //     label: const Text("Enter Password"),
            //     prefixIcon: const Icon(Icons.password),
            //     suffixIcon: IconButton(
            //       onPressed: toggleObscureText,
            //       icon: obscureText
            //           ? const Icon(Icons.visibility)
            //           : const Icon(Icons.visibility_off),
            //     ),
            //   ),
            //   focusNode: passwordFocusNode,
            //   textInputAction: TextInputAction.done,
            //   obscureText: obscureText,
            //   validator: passwordVlidator,
            //   // onSaved: passwordVlidator,
            // ),


            // TextFormField(
            //       controller: confirmPasswordController,
            //       decoration: InputDecoration(
            //         border: const OutlineInputBorder(
            //           borderRadius: BorderRadius.all(Radius.circular(10.0)),
            //         ),
            //         label: const Text("Confirm Password"),
            //         prefixIcon: const Icon(Icons.password),
            //         suffixIcon: IconButton(
            //           onPressed: toggleObscureText,
            //           icon: obscureText
            //               ? const Icon(Icons.visibility)
            //               : const Icon(Icons.visibility_off),
            //         ),
            //       ),
            //       focusNode: confirmPasswordFocusNode,
            //       textInputAction: TextInputAction.done,
            //       obscureText: obscureText,
            //       validator: confirmPasswordValidator,
            //       // onSaved: passwordVlidator,
            //     ),