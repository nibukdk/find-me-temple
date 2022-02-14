enum APP_PAGE {
  // splash,
  onboarding,
  login,
  home,
  error,
  events,
  temples,
  shop,
}

extension AppPageExtension on APP_PAGE {
  // create path for routes
  String get routeString {
    switch (this) {
      case APP_PAGE.home:
        return "/";

      case APP_PAGE.error:
        return "/error";

      case APP_PAGE.onboarding:
        return "/onboarding";

      case APP_PAGE.login:
        return "/login";

      // case APP_PAGE.splash:
      //   return "/splash";

      case APP_PAGE.events:
        return "/events";

      case APP_PAGE.temples:
        return "/temples";

      case APP_PAGE.shop:
        return "/shop";

      default:
        return "/";
    }
  }

// for named routes
  String get routeName {
    switch (this) {
      case APP_PAGE.home:
        return "HOME";

      case APP_PAGE.error:
        return "ERROR";

      case APP_PAGE.onboarding:
        return "ONBOARDING";

      case APP_PAGE.login:
        return "LOGIN";

      // case APP_PAGE.splash:
      //   return "SPLASH";

      case APP_PAGE.events:
        return "EVENTS";

      case APP_PAGE.temples:
        return "TEMPLES";

      case APP_PAGE.shop:
        return "SHOP";

      default:
        return "HOME";
    }
  }

// for page titles

  String get routePageTitle {
    switch (this) {
      case APP_PAGE.home:
        return "Astha";

      case APP_PAGE.error:
        return "An Error Occured";

      case APP_PAGE.onboarding:
        return "Onboarding";

      case APP_PAGE.login:
        return "Login ";

      // case APP_PAGE.splash:
      //   return "Splash";

      case APP_PAGE.events:
        return "Events Near You";

      case APP_PAGE.temples:
        return "Tempels Near You";

      case APP_PAGE.shop:
        return "Shop ";

      default:
        return "Astha";
    }
  }
}
