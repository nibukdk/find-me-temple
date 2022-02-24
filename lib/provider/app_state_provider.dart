import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStateProvider with ChangeNotifier {
  AppStateProvider(this.onBoardCount, this.prefs, this.auth);
  // final String isLoggedIn;
  int? onBoardCount;
  late SharedPreferences prefs;
  late FirebaseAuth auth;

  bool? _isOnboarded;
  bool? _isLoggedIn;

  bool get isOnboard => _isOnboarded as bool;
  bool get isLoggedIn => _isLoggedIn as bool;

  void hasOnBoarded() async {
    await prefs.setInt('onBoardKey', 0);
    _isOnboarded = true;

    notifyListeners();
  }

  void hasLoggedIn() async {
    _isLoggedIn = auth.currentUser != null ? true : false;
    notifyListeners();
  }
}
