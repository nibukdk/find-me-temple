import 'package:church/screens/events_list_screen.dart';
import 'package:church/screens/temple_list_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      // body: TempleListScreen(),
      body: Center(child: Text("Home Page")),
    );
  }
}
