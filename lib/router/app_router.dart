import 'package:church/auth/authentication_screen.dart';
import 'package:church/provider/app_state_provider.dart';
import 'package:church/models/route_utils.dart';
import 'package:church/screens/events_list_screen.dart';
import 'package:church/screens/home_screen.dart';
import 'package:church/screens/onboarding/onboard_screen.dart';
import 'package:church/screens/temple_list_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AsthaAppRouter {
  late final AppStateProvider appStateProvider;
  late final SharedPreferences prefs;
  int? onBoardDisplayCount;
  GoRouter get router => _goRouter;

  AsthaAppRouter(this.appStateProvider, this.prefs, this.onBoardDisplayCount);

  late final GoRouter _goRouter = GoRouter(
      refreshListenable: appStateProvider,
      initialLocation: APP_PAGE.home.routeString,
      routes: [
        GoRoute(
          path: APP_PAGE.home.routeString,
          name: APP_PAGE.home.routeName,
          builder: (ctx, state) => const HomeScreen(),
        ),
        GoRoute(
          path: APP_PAGE.events.routeString,
          name: APP_PAGE.events.routeName,
          builder: (ctx, state) => const EventsListScreen(),
        ),
        GoRoute(
          path: APP_PAGE.temples.routeString,
          name: APP_PAGE.temples.routeName,
          builder: (ctx, state) => const TempleListScreen(),
        ),
        // Oboard Screens
        GoRoute(
          path: APP_PAGE.onboarding.routeString,
          name: APP_PAGE.onboarding.routeName,
          builder: (ctx, state) => const OnboardScreen(),
        ),

        // Auth Screen
        GoRoute(
          path: APP_PAGE.auth.routeString,
          name: APP_PAGE.auth.routeName,
          builder: (ctx, state) => const AuthScreen(),
        ),
      ],
      redirect: (state) {
        final onboardLoc = state.namedLocation(APP_PAGE.onboarding.routeName);
        final homeLoc = state.namedLocation(APP_PAGE.home.routeName);

        // to only onboard if display count is non null
        // since we haven't set sharedprefs yet the following
        //statement will return null
        final toOnboard = onBoardDisplayCount != 0 ? true : false;

        final isInitiazed = appStateProvider.getIsInitializedState;

        if (isInitiazed || toOnboard) {
          onBoardDisplayCount = 0;
          // return APP_PAGE.onboarding.routeName;
          return onboardLoc;
        }
        if (isInitiazed && !toOnboard) {
          // return APP_PAGE.home.routeName;

          return homeLoc;
        }
      });
}
