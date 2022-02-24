import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget with PreferredSizeWidget {
  final Size prefferedSize;
  final String title;
  final GlobalKey<ScaffoldState> scaffoldKey;
  const CustomAppBar({required this.title, required this.scaffoldKey, Key? key})
      : prefferedSize = const Size.fromHeight(56.0),
        super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
            onPressed: () => widget.scaffoldKey.currentState!.openDrawer(),
            icon: const Icon(Icons.person))
      ],
    );
  }
}
