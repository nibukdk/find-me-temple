import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/image_2.jpg",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Text(
                "Find Me Temple",
                style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Colors.white, backgroundColor: Colors.black54),
                textAlign: TextAlign.center,
              )),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.red,
            ),
            title: Text(
              'Home',
            ),
            onTap: () => GoRouter.of(context).go('/'),
          ),
          ListTile(
            leading: Icon(
              Icons.event,
              color: Colors.red,
            ),
            title: Text(
              'Event',
            ),
            onTap: () => GoRouter.of(context).goNamed('eventsListScreen'),
          ),
          ListTile(
            leading: Image.asset(
              "assets/icons/om_icon_25x25.png",
              fit: BoxFit.cover,
            ),
            title: const Text('Temples'),
            onTap: () => GoRouter.of(context).goNamed('templeListScreen'),
          ),
        ],
      ),
    );
  }
}
