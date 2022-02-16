import 'package:flutter/foundation.dart';
import '../models/temple.dart';

class TempleProvider with ChangeNotifier {
  // Create the fake list of temples
  final List<TempleModel> _temples = [
    TempleModel(
      name: "Ramershowr Temple",
      address: "Ramghat 04",
      imgUrl: "assets/images/image_1.jpg",
      establishedDate: DateTime.utc(1999, 02, 09),
    ),
    TempleModel(
      name: "Ramershowr Temple",
      address: "Ramghat 04",
      imgUrl: "assets/images/image_1.jpg",
      establishedDate: DateTime.utc(1999, 02, 09),
    ),
    TempleModel(
      name: "Temple 2",
      address: "Ramghat 04",
      imgUrl: "assets/images/image_3.jpg",
      establishedDate: DateTime.utc(1999, 02, 09),
    ),
    TempleModel(
      name: "Temple 3",
      address: "Ramghat 04",
      imgUrl: "assets/images/image_2.jpg",
      establishedDate: DateTime.utc(1999, 02, 09),
    ),
    TempleModel(
      name: "Temple 4",
      address: "Ramghat 04",
      imgUrl: "assets/images/image_3.jpg",
      establishedDate: DateTime.utc(1999, 02, 09),
    ),
  ];

  // Future<void> getTemples() async {}

  List<TempleModel> get getTemples => [..._temples];
}
