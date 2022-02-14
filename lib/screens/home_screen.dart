import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Custom File
import 'package:church/drawer/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GoogleMapController googleMapController;
  final LatLng _center = LatLng(27.6833291, 84.4060325);

  void _onMapCreated(GoogleMapController controller) {
    googleMapController = controller;
  }

  get center => _center;
  get onMapCreated => _onMapCreated;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      primary: true,
      drawer: const CustomDrawer(),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: center,
          zoom: 15,
        ),
        onMapCreated: onMapCreated,
        mapType: MapType.normal,
        compassEnabled: true,
      ),
    );
  }
}
