import 'package:church/screens/auth/local_widgets/auth_form_widget.dart';
import 'package:church/utils/router/router_utlis.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(APP_PAGE.auth.routePageTitle)),
      // drawer: const CustomDrawer(),
      // bottomNavigationBar: const BottomNavBar(),
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
                const AuthFormWidget()
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
