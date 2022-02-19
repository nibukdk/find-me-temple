import 'package:church/auth/auth_state_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Custom Files
import 'theme/theme.dart';
import 'package:church/provider/events_state_provider.dart';
import 'package:church/provider/temple_state_provider.dart';
import 'package:church/provider/app_state_provider.dart';
import 'package:church/router/app_router.dart';

int? onBoardDisplayCount;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Flutter DotEnv settings
  await dotenv.load(fileName: ".env");

  // Share Prefrences
  onBoardDisplayCount = prefs.getInt('onBoardKey');

  // TaskBar background
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.black38),
  );

  // Firebase auth instance
  FirebaseAuth.instance.userChanges().listen((user) {
    if (user != null) {
      runApp(MyApp(prefs: prefs, authState: true));
    } else {
      runApp(MyApp(prefs: prefs, authState: false));
    }
  });
}

class MyApp extends StatefulWidget {
  final SharedPreferences prefs;
  final bool authState;
  const MyApp({required this.prefs, required this.authState, Key? key})
      : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppStateProvider _appStateProvider;

  @override
  void initState() {
    super.initState();
    _appStateProvider =
        AppStateProvider(prefs: widget.prefs, authState: widget.authState);
  }

  @override
  Widget build(BuildContext context) {
    // print(toOnBoard);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthStateProvider()),
        ChangeNotifierProvider(
          create: (_) => TempleProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => EventsProvider(),
        ),
        ChangeNotifierProvider<AppStateProvider>(
            create: (_) => _appStateProvider),
        Provider<AsthaAppRouter>(
            create: (_) => AsthaAppRouter(_appStateProvider, widget.prefs,
                onBoardDisplayCount, widget.authState))
      ],
      child: Builder(builder: (context) {
        final GoRouter _router = Provider.of<AsthaAppRouter>(context).router;

        return MaterialApp.router(
          routeInformationParser: _router.routeInformationParser,
          routerDelegate: _router.routerDelegate,
          theme: findTemepleTheme,
          debugShowCheckedModeBanner: false,
        );
      }),
    );
  }
}
