import 'dart:convert';
import 'dart:math';
import 'package:church/models/temple_model.dart';
import 'package:church/screens/auth/auth_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class TempleProvider with ChangeNotifier {
  final String _placesApi = dotenv.env['GMAP_PLACES_API_KEY_ANDROID'] as String;
  final FirebaseAuth auth = FirebaseAuth.instance;
  // Create the fake list of temples
  List<TempleModel>? _temples;
  List? _resultList;
  LatLng? _userLocation;
  String? _errMsg;

  List<TempleModel> get temples => [..._temples as List];
  List get resultList => _resultList as List;
  LatLng get userLocation => _userLocation as LatLng;
  String get errMsg => _errMsg as String;

  // final String baseUrlFindPlaceFromText =
  //     "https://maps.googleapis.com/maps/api/place/textsearch/json?";
  static const String _baseUrlNearBySearch =
      "https://maps.googleapis.com/maps/api/place/nearbysearch/json?";

  double calcuateDisatance(LatLng pointOne, LatLng pointTwo) {
    // Calculate distance between two points from user to temple
    // radius of earth in KM
    const radius = 6371;
    final double lon1 = pointOne.longitude * pi / 180;
    final double lat1 = pointOne.latitude * pi / 180;
    final double lon2 = pointTwo.longitude * pi / 180;
    final double lat2 = pointTwo.latitude * pi / 180;

    // Diffence is two points
    final double dlon = lon1 - lon2;
    final double dlat = lat1 - lat2;

    final a =
        pow(sin(dlat / 2), 2) + cos(lat1) * cos(lat2) * pow(sin(dlon / 2), 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    // Distance in meters
    final haverDistance = radius * c;
    return haverDistance;
  }

  void getNearyByTemples(LatLng userLocation) async {
    final api = "&key=$_placesApi";
    final location =
        "location=${userLocation.latitude},${userLocation.longitude}";
    const type = "&type=hindu_temple";
    // const radius = "&radius=50000";
    const rankBy = "&rankby=distance";
    final url =
        Uri.parse(_baseUrlNearBySearch + location + rankBy + type + api);

    try {
      ViewState.busy;

      final res = await http.get(url);
      final decodedRes = await jsonDecode(res.body) as Map;

      final results = await decodedRes['results'] as List;
      // addToTemplesList(results, userLocation);
      for (var result in results) {
        print(result);
        final address = result['vicinity'] ?? 'Not Available';
        final name = result['name'] ?? 'Not Available';
        final id = result['id'] ?? 'Not Available';
        final lat = result['location']['lat'] ?? 'Not Available';
        final long = result['location']['lng'] ?? 'Not Available';
        final templeLocation = LatLng(lat, long);
        // Calulate distance between two locations
        final distance = calcuateDisatance(userLocation, templeLocation);

        TempleModel temple = TempleModel(
            name: name,
            address: address,
            latLng: templeLocation,
            distance: distance);
        // update Temple list
        _temples?.add(temple);
      }
      ViewState.idle;
    } catch (e) {
      _errMsg = "Something went wrong. Please try again";
      ViewState.idle;
    }
    ViewState.idle;
    notifyListeners();
  }

  void addToTemplesList(List results, LatLng userLocation) {
    for (var result in results) {
      print(result);
      final address = result['vicinity'] ?? 'Not Available';
      final name = result['name'] ?? 'Not Available';
      final id = result['id'] ?? 'Not Available';
      final lat = result['location']['lat'] ?? 'Not Available';
      final long = result['location']['lng'] ?? 'Not Available';
      final templeLocation = LatLng(lat, long);
      // Calulate distance between two locations
      final distance = calcuateDisatance(userLocation, templeLocation);

      TempleModel temple = TempleModel(
          name: name,
          address: address,
          latLng: templeLocation,
          distance: distance);
      // update Temple list
      _temples?.add(temple);
    }

    notifyListeners();
  }
}
