import 'package:church/utils/router/router_utlis.dart';
import 'package:church/widgets/app_bar/custom_app_bar.dart';
import 'package:church/widgets/user_drawer/user_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Custom File
import 'package:church/widgets/bottom_nav_bar/bottom_nav_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late GoogleMapController googleMapController;
  final LatLng _center = const LatLng(27.6833291, 84.4060325);

  void _onMapCreated(GoogleMapController controller) {
    googleMapController = controller;
  }

  @override
  void dispose() {
    super.dispose();
    googleMapController.dispose();
  }

  get center => _center;
  get onMapCreated => _onMapCreated;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  get scaffoldKey => _scaffoldKey;
  @override
  Widget build(BuildContext context) {
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
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: center,
            zoom: 15,
          ),
          onMapCreated: onMapCreated,
          mapType: MapType.normal,
          compassEnabled: true,
        ),
      ),
    );
  }
}
