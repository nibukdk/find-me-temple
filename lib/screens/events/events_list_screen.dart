import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:church/provider/events_provider.dart';
import 'package:church/screens/events/local_widget/event_item_widget.dart';
import 'package:church/widgets/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:church/widgets/user_drawer/user_drawer.dart';

class EventsListScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var eventsList =
        Provider.of<EventsProvider>(context, listen: false).getEvents;

    return Scaffold(
      key: _scaffoldKey,
      drawer: const UserDrawer(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Events Screen"),
        actions: [
          IconButton(
              // onPressed: () => UserDrawer(),
              onPressed: () => _scaffoldKey.currentState!.openDrawer(),
              icon: const Icon(Icons.person))
        ],
      ),
      bottomNavigationBar: BottomNavBar(navItemIndex: 1),
      body: SafeArea(
        child: SizedBox(
          // height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Upcoming Events",
                        style: Theme.of(context).textTheme.headline2!),
                    TextButton(
                        onPressed: () {
                          print("txt btn pressed");
                        },
                        child: const Text("View All"))
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, i) => EventItemWidget(
                    name: eventsList[i].name,
                    venue: eventsList[i].venue,
                    imgUrl: eventsList[i].imgUrl,
                    occassionTime: eventsList[i].occassionTime,
                    description: eventsList[i].description,
                  ),
                  itemCount: eventsList.length,
                ),
              ),
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