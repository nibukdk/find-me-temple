import 'dart:async';
import 'package:location/location.dart' as location_package;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

// Custom File
import 'package:church/provider/temple_provider.dart';
import 'package:church/widgets/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:church/utils/router/router_utlis.dart';
import 'package:church/widgets/app_bar/custom_app_bar.dart';
import 'package:church/widgets/user_drawer/user_drawer.dart';
import 'package:church/utils/permissions/permissions.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // late GoogleMapController _googleMapController;
  final Completer<GoogleMapController> _googleMapController = Completer();
  late AppPermissionProvider appPermission;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final location_package.Location location = location_package.Location();
  bool findNearbyTemples = false;

  get onMapCreated => _onMapCreated;
  get scaffoldKey => _scaffoldKey;

  void _onMapCreated(GoogleMapController controller) {
    _googleMapController.complete(controller);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // appPermission.getLocationStatus();

    appPermission = Provider.of<AppPermissionProvider>(context, listen: false);
    Future.delayed(Duration.zero, () async {
      appPermission.getLocationStatus();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    appPermission.getLocation();
  }

  void getTemplesNearby(LatLng latLng, TempleProvider templeProvider) {
    templeProvider.getNearyByTemples(latLng);
  }

  Set<Marker> addMarkers(List locations) {
    int id = 0;
    final Set<Marker> _markers = locations.length == 1
        ? {
            Marker(
              markerId: const MarkerId("1"),
              position: locations[0],
              icon: BitmapDescriptor.defaultMarker,
              infoWindow: const InfoWindow(
                title: 'Your Current Location ',
                snippet: 'Khadka Residence',
              ),
            )
          }
        : locations.map((location) {
            return Marker(
              markerId: MarkerId(((id++).toString())),
              position: location,
              icon: BitmapDescriptor.defaultMarker,
              infoWindow: const InfoWindow(
                title: 'My Home ',
                snippet: 'Khadka Residence',
              ),
            );
          }).toSet();
    return _markers;
  }

  @override
  Widget build(BuildContext context) {
    final TempleProvider templeProvider = Provider.of<TempleProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
      drawer: const UserDrawer(),
      appBar: CustomAppBar(
        scaffoldKey: scaffoldKey,
        title: APP_PAGE.home.routePageTitle,
      ),
      primary: true,
      bottomNavigationBar: BottomNavBar(navItemIndex: 0),
      body: SafeArea(
        child: Consumer<AppPermissionProvider>(
          builder: (context, appPermissionProvider, _) => appPermission
                      .locationCenter ==
                  null
              ? const Center(child: CircularProgressIndicator())
              : Stack(
                  children: [
                    GoogleMap(
                      markers: findNearbyTemples
                          ? addMarkers([
                              appPermissionProvider.locationCenter,
                              LatLng(27.676698, 84.387353),
                              LatLng(27.676736, 84.367225),
                              LatLng(27.675178, 84.404647)
                            ])
                          : addMarkers([appPermissionProvider.locationCenter]),
                      myLocationButtonEnabled:
                          appPermissionProvider.locationStatus != null
                              ? true
                              : false,
                      myLocationEnabled: true,
                      initialCameraPosition: CameraPosition(
                        target: appPermissionProvider.locationCenter,
                        zoom: 14,
                      ),
                      onMapCreated: onMapCreated,
                      mapType: MapType.normal,
                      compassEnabled: true,
                    ),
                    Positioned(
                      left: 4,
                      top: 10,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all<double>(3.0),
                          backgroundColor: findNearbyTemples
                              ? MaterialStateProperty.all<Color>(
                                  const Color.fromARGB(255, 254, 121, 64),
                                )
                              : MaterialStateProperty.all<Color>(
                                  Colors.white,
                                ),
                        ),
                        onPressed: () {
                          setState(
                              () => findNearbyTemples = !findNearbyTemples);
                          getTemplesNearby(appPermissionProvider.locationCenter,
                              templeProvider);
                        },
                        child: const Text("Nearby Temples"),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}


// /  location.onLocationChanged.listen((loc) {
//       _googleMapController.animateCamera(
//         CameraUpdate.newCameraPosition(
//           CameraPosition(
//               target: LatLng(loc.latitude as double, loc.longitude as double),
//               zoom: 14),
//         ),
//       );
//     });


//  GoogleMap(
//                       markers: addMarkers([
//                         appPermission.locationCenter,
//                         LatLng(27.676698, 84.387353),
//                         LatLng(27.676736, 84.367225),
//                         LatLng(27.675178, 84.404647)
//                       ]),
//                       myLocationButtonEnabled:
//                           appPermissionProvider.locationStatus ==
//                                   PermissionStatus.granted
//                               ? true
//                               : false,
//                       myLocationEnabled: true,
//                       initialCameraPosition: CameraPosition(
//                         target: appPermission.locationCenter,
//                         zoom: 14,
//                       ),
//                       onMapCreated: onMapCreated,
//                       mapType: MapType.normal,
//                       compassEnabled: true,
//                     ),


