import 'package:church/auth/firebase_authentication.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
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

  // Splash Native Screen
  FlutterNativeSplash.removeAfter(initialization);
  // Share Prefrences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  onBoardDisplayCount = prefs.getInt('onBoardKey');
  // TaskBar background
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.black38),
  );
  runApp(MyApp(prefs: prefs));
}

// Initialization for flutter native spalsh
void initialization(BuildContext context) async {
  // Firebase intialization
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Flutter DotEnv settings
  await dotenv.load(fileName: ".env");
}

class MyApp extends StatefulWidget {
  final SharedPreferences prefs;

  const MyApp({required this.prefs, Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppStateProvider _appStateProvider;

  @override
  void initState() {
    _appStateProvider = AppStateProvider(prefs: widget.prefs);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(toOnBoard);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TempleProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => EventsProvider(),
        ),
        ChangeNotifierProvider<AppStateProvider>(
            create: (_) => _appStateProvider),
        ChangeNotifierProvider(
            create: (BuildContext context) =>
                FirebaseAuthenticationProvider(context)),
        Provider<AsthaAppRouter>(
            create: (_) => AsthaAppRouter(
                _appStateProvider, widget.prefs, onBoardDisplayCount))
      ],
      child: Builder(
        builder: (context) {
          final GoRouter _router = Provider.of<AsthaAppRouter>(context).router;

          return MaterialApp.router(
            title: "Astha",
            routeInformationParser: _router.routeInformationParser,
            routerDelegate: _router.routerDelegate,
            theme: findTemepleTheme,
          );
        },
      ),
    );
  }
}
