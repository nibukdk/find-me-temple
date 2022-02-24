import 'package:church/provider/auth_state_provider.dart';
import 'package:church/utils/router/router_utlis.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:church/provider/app_state_provider.dart';

class UserDrawer extends StatefulWidget {
  const UserDrawer({Key? key}) : super(key: key);

  @override
  _UserDrawerState createState() => _UserDrawerState();
}

class _UserDrawerState extends State<UserDrawer> {
  @override
  Widget build(BuildContext context) {
    AppStateProvider auth = Provider.of<AppStateProvider>(context);

    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 255, 209, 166),
      actionsPadding: EdgeInsets.zero,
      scrollable: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Text(
        "Astha",
        style: Theme.of(context).textTheme.headline1,
      ),
      content: const Divider(
        thickness: 1.0,
        color: Colors.black,
      ),
      actions: [
        ListTile(
            leading: Icon(
              Icons.logout,
              color: Theme.of(context).colorScheme.secondary,
            ),
            title: const Text('Logout'),
            onTap: () {
              Provider.of<AuthStateProvider>(context, listen: false).logOut();
              GoRouter.of(context).goNamed(APP_PAGE.home.routeName);
            })
      ],
    );
  }
}
