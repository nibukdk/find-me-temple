import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventItemWidget extends StatelessWidget {
  final String name;
  final String imgUrl;
  final DateTime occassionTime;
  final String venue;
  final String description;

  const EventItemWidget(
      {required this.name,
      required this.imgUrl,
      required this.occassionTime,
      required this.venue,
      required this.description,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.all(4.0),
        child: ListTile(
          // tileColor: Theme.of(context).colorScheme.primary,
          // tileColor: Colors.blueGrey,

          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                  color: Theme.of(context).colorScheme.secondary, width: 0.5)),
          style: ListTileStyle.list,
          leading: CircleAvatar(
            backgroundImage: AssetImage(
              imgUrl,
            ),
          ),
          title: Text(
            name,
            style: Theme.of(context).textTheme.headline2,
          ),
          subtitle: Text(venue),
          trailing: Text(
            DateFormat.MMMEd().format(occassionTime),
            style: Theme.of(context).textTheme.bodyText2,
          ),
          onTap: () => print("Tapped"),
        ),
      ),
    );
  }
}
