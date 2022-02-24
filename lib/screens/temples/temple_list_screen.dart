import 'package:church/utils/router/router_utlis.dart';
import 'package:church/widgets/app_bar/custom_app_bar.dart';
import 'package:church/widgets/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:church/provider/temple_provider.dart';
import 'package:church/screens/temples/local_widget/temple_item_widget.dart';
import 'package:church/widgets/user_drawer/user_drawer.dart';

class TempleListScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  get scaffoldKey => _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final templeList = Provider.of<TempleProvider>(context).getTemples;
    return Scaffold(
      key: _scaffoldKey,
      drawer: const UserDrawer(),
      appBar: CustomAppBar(
        scaffoldKey: scaffoldKey,
        title: APP_PAGE.temples.routePageTitle,
      ),
      bottomNavigationBar: BottomNavBar(
        navItemIndex: 2,
      ),
      body: SafeArea(
        child: SizedBox(
          width: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "List of Temples Near You.",
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
              Expanded(
                flex: 2,
                child: ListView.builder(
                  itemBuilder: (context, i) => TempleItemWidget(
                    title: templeList[i].name,
                    address: templeList[i].address,
                    imageUrl: templeList[i].imgUrl,
                    establishedDate: templeList[i].establishedDate.toString(),
                  ),
                  itemCount: templeList.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
