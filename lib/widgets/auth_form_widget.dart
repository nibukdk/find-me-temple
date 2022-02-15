import 'package:flutter/material.dart';

class AuthFormWidget extends StatefulWidget {
  const AuthFormWidget({Key? key}) : super(key: key);

  @override
  _AuthFormWidgetState createState() => _AuthFormWidgetState();
}

class _AuthFormWidgetState extends State<AuthFormWidget> {
  // Define Form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;

  bool obscureText = true;

  bool _isEmailValid = false;
  bool _isPasswordValid = false;

  static const String emailErrMsg =
      "Invlid Email Address, Please provide a valid email.";
  static const String passwordErrMsg =
      "Password must have atleast 6 characters.";

  @override
  void initState() {
    super.initState();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                label: Text("Enter Email Address"),
                prefixIcon: Icon(Icons.mail),
              ),
              focusNode: emailFocusNode,
              textInputAction: TextInputAction.next,
              validator: emailValidator,
              // onSaved: emailValidator,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                label: const Text("Enter Password"),
                prefixIcon: const Icon(Icons.password),
                suffixIcon: IconButton(
                  onPressed: toggleObscureText,
                  icon: obscureText
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                ),
              ),
              focusNode: passwordFocusNode,
              textInputAction: TextInputAction.done,
              obscureText: obscureText,
              validator: passwordVlidator,
              // onSaved: passwordVlidator,
            ),
            const SizedBox(
              height: 20,
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
                  child: const Text('Sign In'),
                  style: ButtonStyle(elevation: MaterialStateProperty.all(8.0)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
