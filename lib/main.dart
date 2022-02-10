import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
// Custom Files
import './screens/home_screen.dart';
import 'theme/theme.dart';
import 'package:church/provider/events_provider.dart';
import 'package:church/provider/temple_provider.dart';
import 'package:church/screens/events_list_screen.dart';
import 'package:church/screens/temple_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.removeAfter(initialization);

  runApp(MyApp());
}

void initialization(BuildContext context) async {
  // Initialize setting while plash screen is running
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");
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
        // useInheritedMediaQuery: true,
      ),
    );
  }

  final _router = GoRouter(routes: [
    GoRoute(path: "/", builder: (ctx, state) => HomeScreen()
        // builder: (ctx, state) => const HomeScreen(),
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
