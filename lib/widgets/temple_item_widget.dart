import 'package:flutter/material.dart';

class TempleItemWidget extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String address;
  final String establishedDate;

  const TempleItemWidget(
      {required this.title,
      required this.imageUrl,
      required this.address,
      required this.establishedDate,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      width: 200,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                width: 200,
                height: 120,
              ),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.headline3,
              // softWrap: true,
              overflow: TextOverflow.fade,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}




  // Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
  //               children: [
  //                 Text(
  //                   address,
  //                   style: Theme.of(context).textTheme.bodyText1,
  //                 ),
  //                 Text(
  //                   address,
  //                   style: Theme.of(context).textTheme.bodyText1,
  //                 ),
  //               ],
  //             ),
  //           )