import 'package:church/utils/router/router_utlis.dart';
import 'package:church/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:church/provider/events_provider.dart';
import 'package:church/screens/events/local_widget/event_item_widget.dart';
import 'package:church/widgets/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:church/widgets/user_drawer/user_drawer.dart';

class EventsListScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  get scaffoldKey => _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    var eventsList =
        Provider.of<EventsProvider>(context, listen: false).getEvents;

    return Scaffold(
      key: _scaffoldKey,
      drawer: const UserDrawer(),
      appBar: CustomAppBar(
        scaffoldKey: scaffoldKey,
        title: APP_PAGE.events.routePageTitle,
      ),
      bottomNavigationBar: BottomNavBar(navItemIndex: 2),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ...eventsList.map(
                (event) => EventItemWidget(
                  name: event.name,
                  venue: event.venue,
                  imgUrl: event.imgUrl,
                  occassionTime: event.occassionTime,
                  description: event.description,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}



//  Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               "Upcoming Events",
//               style: Theme.of(context).textTheme.headline2,
//             ),
//           ),


// Expanded(
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   itemBuilder: (context, i) => EventItemWidget(
//                     name: eventsList[i].name,
//                     venue: eventsList[i].venue,
//                     imgUrl: eventsList[i].imgUrl,
//                     occassionTime: eventsList[i].occassionTime,
//                     description: eventsList[i].description,
//                   ),
//                   itemCount: eventsList.length,
//                 ),
//               ),