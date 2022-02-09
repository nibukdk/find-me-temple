import 'package:church/provider/events_provider.dart';
import 'package:church/provider/temple_provider.dart';
import 'package:church/screens/events_list_screen.dart';
import 'package:church/screens/temple_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
//
import './screens/home_screen.dart';
import 'theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TempleProvider()),
        ChangeNotifierProvider(create: (_) => EventsProvider()),
      ],
      child: MaterialApp.router(
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
        theme: findTemepleTheme,
      ),
    );
  }

  final _router = GoRouter(routes: [
    GoRoute(
      path: "/",
      builder: (ctx, state) => const HomeScreen(),
    ),
    GoRoute(
      path: "/events-list",
      name: 'eventsListScreen',
      builder: (ctx, state) => const EventsListScreen(),
    ),
    GoRoute(
      path: "/temple-list",
      name: 'templeListScreen',
      builder: (ctx, state) => const TempleListScreen(),
    ),
  ]);
}
