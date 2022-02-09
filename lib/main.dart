import 'package:church/provider/events_provider.dart';
import 'package:church/provider/temple_provider.dart';
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
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TempleProvider()),
        ChangeNotifierProvider(create: (_) => EventsProvider()),
      ],
      child: MaterialApp(
        home: HomeScreen(),
        theme: findTemepleTheme,
      ),
    );
  }
}
