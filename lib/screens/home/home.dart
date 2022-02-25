import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Custom File
import 'package:church/widgets/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:church/utils/router/router_utlis.dart';
import 'package:church/widgets/app_bar/custom_app_bar.dart';
import 'package:church/widgets/user_drawer/user_drawer.dart';
import 'package:church/utils/permissions/permissions.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late GoogleMapController googleMapController;
  late AppPermissionProvider appPermission;
  final LatLng _center = const LatLng(27.6833291, 84.4060325);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  get center => _center;
  get onMapCreated => _onMapCreated;
  get scaffoldKey => _scaffoldKey;

  void _onMapCreated(GoogleMapController controller) {
    googleMapController = controller;
  }

  @override
  void dispose() {
    super.dispose();
    googleMapController.dispose();
  }

  @override
  void initState() {
    super.initState();

    appPermission = Provider.of<AppPermissionProvider>(context, listen: false);
    appPermission.getLocationStatus();
  }

  @override
  Widget build(BuildContext context) {
    // var status = Provider.of<AppPermission>(context).locationStatus;

    // print("The location status is $status");
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
          builder: (context, appPermissionProvider, _) => GoogleMap(
            myLocationButtonEnabled:
                appPermissionProvider.locationStatus == PermissionStatus.granted
                    ? true
                    : false,
            myLocationEnabled: true,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 15,
            ),
            onMapCreated: onMapCreated,
            mapType: MapType.hybrid,
            compassEnabled: true,
          ),
        ),
      ),
    );
  }
}
