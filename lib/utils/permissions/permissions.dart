import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

class AppPermissionProvider with ChangeNotifier {
  PermissionStatus _locationStatus = PermissionStatus.denied;

  // Getter
  get locationStatus => _locationStatus;

  void getLocationStatus() async {
    final status = await Permission.location.request();
    _locationStatus = status;

    notifyListeners();
    print(_locationStatus);
  }
}
