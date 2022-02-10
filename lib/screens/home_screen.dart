import 'package:church/drawer/drawer.dart';
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
      primary: true,
      drawer: const CustomDrawer(),
      // body: TempleListScreen(),
      body: SafeArea(
        child: Center(child: Text("Home Page")),
      ),
    );
  }
}
