import 'package:flutter/material.dart';
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
    final availableHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;

    final availableWidth = MediaQuery.of(context).size.width -
        AppBar().preferredSize.width -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
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
          onTap: () {},
        )
      ],
    );
  }
}

//  Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           DrawerHeader(
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage(
//                   "assets/images/image_2.jpg",
//                 ),
//                 fit: BoxFit.cover,
//               ),
//             ),
//             child: Text(
//               "Find Me Temple",
//               style: Theme.of(context).textTheme.headline2!.copyWith(
//                   color: Colors.white, backgroundColor: Colors.black54),
//               textAlign: TextAlign.center,
//             ),
//           ),
//           ListTile(
//               leading: const Icon(
//                 Icons.home,
//                 color: Colors.red,
//               ),
//               title: const Text(
//                 'Home',
//               ),
//               onTap: () {}),
//           ListTile(
//               leading: const Icon(
//                 Icons.event,
//                 color: Colors.red,
//               ),
//               title: const Text(
//                 'Event',
//               ),
//               onTap: () {}),
//           ListTile(
//               leading: Image.asset(
//                 "assets/icons/om_icon_25x25.png",
//                 fit: BoxFit.cover,
//               ),
//               title: const Text('Temples'),
//               onTap: () {}),
//         ],
//       ),
//     );
