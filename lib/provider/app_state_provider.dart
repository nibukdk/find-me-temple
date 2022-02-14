import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

// String loginKey = dotenv.env['LOGIN_KEY'] as String;
// String onBoardKey = dotenv.env['ONBOARD_KEY'] as String;
String loginKey = 'qEBKaNywmD';
String onBoardKey = 'NVsyZxuJ4U';

class AppStateProvider extends ChangeNotifier {
  late final SharedPreferences prefs;

  AppStateProvider({required this.prefs});

  final StreamController<bool> _loginStateChanges =
      StreamController<bool>.broadcast();

  // Create variables for different states
  bool _isLoggedInState = false;
  bool _isInitializedState = false;
  bool _isOnboadingState = false;

  // Create getters
  bool get getIdLoggedInState => _isLoggedInState;
  bool get getIsInitializedState => _isInitializedState;
  bool get getIsOnboadingState => _isOnboadingState;
  Stream<bool> get loginStateChanges => _loginStateChanges.stream;

  // Create Setter for login
  set setIsLoggedInState(bool val) {
    prefs.setBool(loginKey, val);
    //change is loggedin val
    _isLoggedInState = val;

    // change loggedin strem values
    _loginStateChanges.add(val);
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
}
