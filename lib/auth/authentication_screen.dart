import 'dart:async';

import 'package:church/auth/auth_state_provider.dart';
import 'package:church/drawer/drawer.dart';
import 'package:church/models/route_utils.dart';
import 'package:church/auth/auth_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(APP_PAGE.auth.routePageTitle)),
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: SizedBox(
              // height: MediaQuery.of(context).size.height * 0.9,
              width: double.infinity,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/AuthScreen/WelcomeScreenImage_landscape_2.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Consumer<AuthStateProvider>(
                    builder: (context, authState, _) => AuthFormWidget(
                        register: authState.registerAccount,
                        signIn: authState.signInWithEmailAndPassword,
                        signOut: authState.signOut)),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
