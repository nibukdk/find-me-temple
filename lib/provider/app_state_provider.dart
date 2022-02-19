import 'dart:async';
import 'package:church/auth/auth_state_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:flutter_dotenv/flutter_dotenv.dart';

// String loginKey = dotenv.env['LOGIN_KEY'] as String;
// String onBoardKey = dotenv.env['ONBOARD_KEY'] as String;
String loginKey = 'qEBKaNywmD';
String onBoardKey = 'NVsyZxuJ4U';

class AppStateProvider extends ChangeNotifier {
  late final SharedPreferences prefs;
  bool authState;
  AppStateProvider({required this.prefs, required this.authState});

  // Create variables for different states
  bool _isLoggedInState = false;
  bool _isInitializedState = false;
  bool _isOnboadingState = false;
  // Create getters
  bool get getIsLoggedInState => _isLoggedInState;
  bool get getIsInitializedState => _isInitializedState;
  bool get getIsOnboadingState => _isOnboadingState;

  // Create Setter for login
  set setIsLoggedInState(bool val) {
    //change is loggedin val
    _isLoggedInState = val;
    notifyListeners();
  }

  // Create Setter for onboaring
  set setIsInitializedState(bool val) {
    //change isinitialized val
    _isInitializedState = val;
    notifyListeners();
  }

  set setIsOnboardingState(bool val) {
    _isOnboadingState = val;
    notifyListeners();
  }

  Future<void> login() async {
    _isLoggedInState = true;

    notifyListeners();
  }

  Future<void> logout() async {
    _isLoggedInState = false;
    prefs.setBool(loginKey, false);
    notifyListeners();
  }
}
