import 'package:church/screens/auth/auth_screen.dart';
import 'package:church/screens/events/events_list_screen.dart';
import 'package:church/screens/home/home.dart';
import 'package:church/provider/app_state_provider.dart';
import 'package:church/screens/onboarding/onboard.dart';
import 'package:church/screens/temples/temple_list_screen.dart';
import 'package:church/utils/router/router_utlis.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppRouter {
  late AppStateProvider appStateProvider;
  late SharedPreferences prefs;
  // final FirebaseAuth authInstance;
  int? onBoardCount;

  AppRouter({
    required this.appStateProvider,
    required this.onBoardCount,
    required this.prefs,
    // required this.authInstance
  });
  get router => _router;

  late final _router = GoRouter(
      refreshListenable: appStateProvider,
      initialLocation: "/",
      routes: [
        GoRoute(
          path: APP_PAGE.home.routePath,
          name: APP_PAGE.home.routeName,
          builder: (context, state) => const Home(),
        ),
        GoRoute(
          path: APP_PAGE.auth.routePath,
          name: APP_PAGE.auth.routeName,
          builder: (context, state) => const AuthScreen(),
        ),
        GoRoute(
          path: APP_PAGE.events.routePath,
          name: APP_PAGE.events.routeName,
          builder: (context, state) => EventsListScreen(),
        ),
        GoRoute(
          path: APP_PAGE.temples.routePath,
          name: APP_PAGE.temples.routeName,
          builder: (context, state) => TempleListScreen(),
        ),
        GoRoute(
            path: APP_PAGE.onboard.routePath,
            name: APP_PAGE.onboard.routeName,
            builder: (context, state) => const OnBoardScreen())
      ],
      redirect: (state) {
        final String onboardLocation =
            state.namedLocation(APP_PAGE.onboard.routeName);

        final String authLocation =
            state.namedLocation(APP_PAGE.auth.routeName);

        bool isOnboarding = state.subloc == onboardLocation;
        bool isLogginIn = state.subloc == authLocation;

        bool? toOnboard = prefs.containsKey('onBoardKey') ? false : true;
        // bool? isLoggedIn = authInstance.currentUser != null ? true : false;
        bool? isLoggedIn =
            appStateProvider.auth.currentUser == null ? false : true;

        print("Is LoggedIn is $isLoggedIn");
        if (toOnboard) {
          // onBoardCount = 0;
          return isOnboarding ? null : onboardLocation;
        } else if (!isLoggedIn) {
          return isLogginIn ? null : authLocation;
        }

        return null;
      });
}
