import 'package:church/drawer/drawer.dart';
import 'package:church/provider/events_provider.dart';
import 'package:church/widgets/event_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventsListScreen extends StatelessWidget {
  const EventsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var eventsList =
        Provider.of<EventsProvider>(context, listen: false).getEvents;

    return Scaffold(
      appBar: AppBar(title: const Text("Events Screen")),
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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